# This script is/was used to generate parts of the code by scraping the API page.
# It might stop working, and in that case it might be feasible to fix it or not.

Mix.install([:floki])

defmodule Scraper do
  # used to signal to the parser to take the exact value from the JSON:
  @scalar :scalar
  # some methods take either a file upload or a URL:
  @input_file_or_string :input_file_or_string
  # cooked up polymorphic type for those messages returning a message object or `true`:
  @message_or_true "MessageOrTrue"
  # In some error cases, the response contains this:
  @response_parameters "ResponseParameters"

  def run do
    url = "https://core.telegram.org/bots/api"
    {body, 0} = System.cmd("curl", [url])
    {:ok, document} = Floki.parse_document(body)

    Floki.find(document, "#dev_page_content")
    |> then(fn [{_, _, nodes}] -> nodes end)
    |> headlined_sections("h4")
    |> Enum.map(&put_headline_info/1)
    |> Enum.map(fn
      map = %{headline_format: :pascal} -> put_pascal_content_analysis(map)
      map = %{headline_format: :camel} -> put_camel_content_analysis(map)
      map -> map
    end)
    |> Enum.filter(& &1[:name])
    |> put_subtype_determination()
    |> Kernel.++([
      %{
        role: :polymorphic_type,
        name: @message_or_true,
        subtypes: ["Message", @scalar]
      }
    ])
    |> Enum.sort_by(& &1.name)
    |> filter_and_group()
    |> add_global_properties()
    |> tap(&analyze_completeness/1)
    |> put_generated_code_snippets()
    |> emit()
  end

  def headlined_sections(nodes, htag) do
    nodes
    |> Enum.filter(&(tuple_size(&1) == 3))
    |> Enum.chunk_while(
      [],
      fn {tag, _, _} = node, acc ->
        if tag == htag do
          if acc == [] do
            {:cont, [node]}
          else
            {:cont, Enum.reverse(acc), [node]}
          end
        else
          {:cont, [node | acc]}
        end
      end,
      fn
        [] -> {:cont, []}
        acc -> {:cont, Enum.reverse(acc), []}
      end
    )
    |> Enum.filter(fn [{tag, _, _} | _] -> tag == htag end)
    |> Enum.map(fn [{_htag, _, content} | rest] ->
      %{headline_content: content, content_nodes: rest}
    end)
  end

  def put_headline_info(%{headline_content: headline_content} = map) do
    Floki.text(headline_content)
    |> String.split()
    |> case do
      [word] ->
        # headline is a single word
        cond do
          Regex.match?(~r{^[A-Z]}, word) ->
            map
            |> Map.put(:headline_format, :pascal)
            |> Map.put(:headline_word, word)

          Regex.match?(~r{^[a-z]}, word) ->
            map
            |> Map.put(:headline_format, :camel)
            |> Map.put(:headline_word, word)

          true ->
            map
            |> Map.put(:headline_format, :other_single_word)
        end

      _else ->
        map
        |> Map.put(:headline_format, :multi_word)
    end
  end

  @subtypes_re ~r{the following [^.:]* are supported:|it should be one of|currently support [^.:]*the following \w* types:}i

  def put_pascal_content_analysis(%{content_nodes: content_nodes} = map) do
    case Floki.find(content_nodes, "table") do
      [] ->
        text = Floki.text(content_nodes)

        cond do
          String.contains?(text, "urrently holds no information.") ->
            map
            |> Map.put(:role, :type_with_fields)
            |> Map.put(:name, map.headline_word)
            |> Map.put(:fields, [])

          Regex.match?(@subtypes_re, text) ->
            [{"ul", _, lis}] = Floki.find(content_nodes, "ul")

            subtypes = Enum.map(lis, fn {"li", _, content} -> Floki.text(content) end)

            map
            |> Map.put(:role, :polymorphic_type)
            |> Map.put(:name, map.headline_word)
            |> Map.put(:subtypes, subtypes)

          true ->
            map
        end

      [table] ->
        # sanity check:
        [
          {"thead", [],
           [
             {"tr", [],
              [
                {"th", [], ["Field"]},
                {"th", [], ["Type"]},
                {"th", [], ["Description"]}
              ]}
           ]}
        ] = Floki.find(table, "thead")

        Floki.find(table, "tbody > tr")
        |> Enum.map(fn {"tr", _, tds} ->
          [{"td", [], [field_name]}, {"td", [], type_content}, {"td", [], desc}] = tds

          type =
            case type_content do
              [string] when is_binary(string) -> @scalar
              [{"a", _, [type]}] when is_binary(type) -> type
              ["Array of ", {"a", _, [type]}] when is_binary(type) -> type
              ["Array of Array of ", {"a", _, [type]}] when is_binary(type) -> type
              [{"a", _, ["InputFile"]}, " or String"] -> @input_file_or_string
            end

          desc_text = Floki.text(desc)

          fixed_value =
            cond do
              captures = Regex.run(~r{always “(\w+)”($|\.)}, desc_text) ->
                Enum.at(captures, 1)

              captures = Regex.run(~r{must be (\w+)($|\.)}, desc_text) ->
                Enum.at(captures, 1)

              true ->
                nil
            end

          if fixed_value do
            %{fixed_value: fixed_value}
          else
            %{}
          end
          |> Map.merge(%{name: field_name, type: type})
        end)
        |> then(fn fields ->
          map
          |> Map.put(:role, :type_with_fields)
          |> Map.put(:name, map.headline_word)
          |> Map.put(:fields, fields)
        end)
    end
  end

  @return_prose_res [
    ~r{return error|returned the error|return the score|an empty list is returned}i,
    ~r{return an object with|the creator will be returned|returns an error}i,
    ~r{optionally returned|return to the chat|return to the group}i
  ]

  @sentences_with_return_type %{
    "On success, the sent Message is returned" => "Message",
    "Returns True on success" => @scalar,
    "On success, True is returned" => @scalar,
    "Returns Int on success" => @scalar,
    "On success, an array of Messages that were sent is returned" => "Message",
    "An Array of Update objects is returned" => "Update",
    "On success, the stopped Poll is returned" => "Poll",
    "Returns basic information about the bot in form of a User object" => "User",
    "Returns the MessageId of the sent message on success" => "MessageId",
    "Returns the uploaded File on success" => "File"
  }

  @message_or_true_re ~r{if [^,]*, the (?:edited )?Message is returned, otherwise True is returned}i

  @extract_type_res [
    ~r{On success, returns a (\w*) object}i,
    ~r{On success, returns a (\w*) object}i,
    ~r{On success, a (\w*) object is returned}i,
    ~r{Returns a (\w*) object}i,
    ~r{Returns Array of (\w*) on success}i,
    ~r{Returns the (?:new|edited|revoked) invite link (?:as|as a) (\w*) object}i,
    ~r{On success, returns an Array of (\w*) objects}i
  ]

  def put_camel_content_analysis(%{content_nodes: content_nodes} = map) do
    content_nodes
    |> Enum.reject(fn {tag, _, _} -> tag in ["table", "blockquote"] end)
    |> then(fn nodes ->
      text = Floki.text(nodes)

      # First, split into sentences, and grab those which contain "return"
      text
      |> String.split(~r{[.!?]\s*})
      |> Enum.filter(fn sentence -> Regex.match?(~r{return}i, sentence) end)
      |> then(fn sentences ->
        # Then, remove sentences where "return" occurs in a context which is known cases of prose
        # describing the semantics of the return value or a user returning to a chat or group
        sentences
        |> Enum.reject(fn sentence ->
          Enum.any?(@return_prose_res, &Regex.match?(&1, sentence))
        end)
      end)
      |> then(fn [sentence] ->
        # Make sure we filtered out correctly, so that exactly one sentence remains
        sentence
      end)
      |> then(fn sentence ->
        # Now, match onto types. Do this very conservatively. Better add a case than try to be clever...

        cond do
          type = Map.get(@sentences_with_return_type, sentence) ->
            # Handle the cases remaining after we catch most cases using regex's
            type

          Regex.match?(@message_or_true_re, text) ->
            # invented polymorphic type
            @message_or_true

          captures = Enum.find_value(@extract_type_res, &Regex.run(&1, text)) ->
            Enum.at(captures, 1)

          Regex.run(~r{Returns the (?:new|edited|revoked) invite link as String}, text) ->
            @scalar
        end
      end)
      |> then(fn type ->
        map
        |> Map.put(:role, :method)
        |> Map.put(:name, map.headline_word)
        |> Map.put(:result_type, type)
      end)
    end)
  end

  def filter_and_group(maps) do
    maps
    |> Enum.filter(& &1[:role])
    |> Enum.group_by(& &1.role)
  end

  def put_subtype_determination(maps) do
    Enum.map(maps, fn
      %{role: :polymorphic_type} = map ->
        map.subtypes
        |> Enum.map(fn subtype ->
          %{} = find_type_map(subtype, maps)
        end)
        |> Enum.map(fn subtype_map ->
          # sanity check:
          # currently, if there is a fixed type field, it is always the first
          Enum.find_index(subtype_map.fields, &Map.has_key?(&1, :fixed_value))
          |> case do
            nil -> false
            0 -> :ok
          end
          |> case do
            false ->
              # no fixed value field
              nil

            :ok ->
              [%{fixed_value: fixed_value, name: name} | _] = subtype_map.fields

              %{
                type: subtype_map.headline_word,
                field: name,
                value: fixed_value
              }
          end
        end)
        |> then(fn fixed_value_fields ->
          # sanity check: either all subtypes have a fixed field, or none
          Enum.frequencies_by(fixed_value_fields, &is_nil/1)
          |> then(fn frequencies ->
            # assert a frequency would be zero, since there's only two possible keys
            # this is equivalent to there being only one map key
            1 = Enum.count(frequencies)
          end)

          fixed_value_fields
          |> Enum.filter(& &1)
          |> case do
            [] -> Map.put(map, :subtypes_fixed_value_fields, nil)
            list -> Map.put(map, :subtypes_fixed_value_fields, list)
          end
        end)

      map ->
        map
    end)
  end

  def add_global_properties(groups) do
    %{
      method: methods,
      polymorphic_type: polymorphic_types,
      type_with_fields: types_with_fields
    } = groups

    all_types = polymorphic_types ++ types_with_fields

    # Compute all types that can appear as part of a message return value.
    # Implicitly checks that message return types exist
    # * we do not care about the @scalar type
    # * we manually add the @response_parameters type because that may or may not be part of
    #   an error return
    types_in_method_returns =
      methods
      |> Enum.map(& &1.result_type)
      |> Enum.uniq
      |> Kernel.--([@scalar])
      |> Kernel.++([@response_parameters, @message_or_true])
      |> compute_closure(fn types ->
        reachable_types =
          types
          |> Enum.map(fn type ->
            %{} = find_type_map(type, all_types)
          end)
          |> Enum.flat_map(&referred_types/1)
          |> Enum.reject(&(&1 == @scalar))

        # add new types to the end, uniq
        Enum.uniq(types ++ reachable_types)
      end)

    tag = fn type_maps ->
      Enum.map(type_maps, fn map ->
        Map.put(map, :in_method_return?, map.name in types_in_method_returns)
      end)
    end

    groups
    |> Map.put(:polymorphic_type, tag.(polymorphic_types))
    |> Map.put(:type_with_fields, tag.(types_with_fields))
  end

  def analyze_completeness(groups) do
    %{
      polymorphic_type: polymorphic_types,
      type_with_fields: types_with_fields
    } = groups

    all_types = polymorphic_types ++ types_with_fields

    # Check that all types referred to by any type exist.
    # We skip @input_file_or_string because both types do not need a type map,
    # both can be treated as scalars
    all_types
    |> Enum.each(fn map ->
      referred_types(map)
      |> Enum.reject(&(&1 == @scalar))
      |> Enum.reject(&(&1 == @input_file_or_string))
      |> Enum.each(fn type ->
        %{} = find_type_map(type, all_types)
      end)
    end)

    # check that all polymorphic types that are part of a message return
    # can be pattern-matched to a subtype
    all_types
    |> Enum.filter(& &1.role == :polymorphic_type)
    |> Enum.filter(& &1.in_method_return?)
    |> Enum.reject(&(&1.name == @message_or_true))
    |> Enum.each(fn map ->
      subtypes_count = Enum.count(map.subtypes)

      # Sanity check: subtypes agree on fixed value field
      1 =
        map.subtypes_fixed_value_fields
        |> Enum.map(& &1.field)
        |> Enum.uniq()
        |> Enum.count()

      # Sanity check: the field values are unique
      ^subtypes_count =
        map.subtypes_fixed_value_fields
        |> Enum.map(& &1.value)
        |> Enum.uniq()
        |> Enum.count()
    end)
  end

  def find_type_map(type_name, maps) do
    Enum.find(maps, &(&1.name == type_name))
  end

  def referred_types(%{role: :type_with_fields, fields: fields}) do
    Enum.map(fields, & &1.type)
  end

  def referred_types(%{role: :polymorphic_type, subtypes: types}), do: types

  def compute_closure(data, function) do
    new_data = function.(data)

    if new_data == data do
      data
    else
      compute_closure(new_data, function)
    end
  end

  def put_generated_code_snippets(groups) do
    %{method: methods} = groups

    groups
    |> update_in([:type_with_fields, Access.all()], fn map ->
      module = type_with_fields_module(map)

      Map.put(map, :module, module)
    end)
    |> update_in([:polymorphic_type, Access.all()], fn map ->
      if dynamic_api_type_head = dynamic_api_type_head(map) do
        Map.put(map, :dynamic_api_type, dynamic_api_type_head)
      else
        map
      end
    end)
    |> Map.put(:method_types_map, method_types_map(methods))
  end

  def type_with_fields_module(map) do
    %{headline_word: name, fields: fields} = map

    %{
      scalar: scalar,
      fixed: fixed,
      structured: structured
    } =
      fields
      |> Enum.group_by(fn
        %{fixed_value: _} -> :fixed
        %{type: @scalar} -> :scalar
        %{type: @input_file_or_string} -> :scalar
        _else -> :structured
      end)
      |> Map.put_new(:fixed, [])
      |> Map.put_new(:scalar, [])
      |> Map.put_new(:structured, [])

    # The generated code is assumed to have
    # `alias Cablegram.{Type, Model}`
    # in a prelude

    scalar = Enum.map(scalar, & &1.name) |> Enum.join(" ")

    fixed =
      fixed
      |> Enum.map(fn %{name: name, type: @scalar, fixed_value: "" <> value} ->
        "#{name}: #{inspect(value)}"
      end)
      |> Enum.join(", ")

    structured =
      structured
      |> Enum.map(&"#{&1.name}: Type.#{&1.type}")
      |> Enum.join(", ")

    """
    defmodule Cablegram.Model.#{name} do
      @scalars ~w{#{scalar}}a
      @fixed [#{fixed}]
      @structured [#{structured}]

      use Model, api_type: Type.#{name}, members: @scalars ++ @fixed ++ @structured
    end
    """
  end

  def dynamic_api_type_head(%{in_method_return?: false}), do: nil
  def dynamic_api_type_head(%{subtypes_fixed_value_fields: nil}), do: nil

  def dynamic_api_type_head(:fallback) do
    """
    def dynamic_api_type(type, _data), do: type
    """
  end

  def dynamic_api_type_head(%{name: @message_or_true}) do
    """
    def dynamic_api_type(Type.MessageOrTrue, data) do
      case data do
        true -> Type.Itself
        _else -> Type.Message
      end
    end
    """
  end

  def dynamic_api_type_head(map) do
    %{
      name: name,
      subtypes_fixed_value_fields: [%{field: field} | _] = subtypes_fixed_value_fields
    } = map

    # The generated code is assumed to have
    # `alias Cablegram.Type`
    # in a prelude

    case_matches =
      subtypes_fixed_value_fields
      |> Enum.map(fn %{type: type, value: value} ->
        ~s{"#{value}" -> Type.#{type}}
      end)
      |> Kernel.++(["_ -> Type.Fallback"])

    """
    def dynamic_api_type(Type.#{name}, %{"#{field}" => #{field}}) do
      case #{field} do
    #{case_matches |> Enum.map(&("    " <> &1)) |> Enum.join("\n")}
      end
    end
    """
  end

  def method_types_map(methods) do
    # The generated code is assumed to have
    # `alias Cablegram.Type`
    # in a prelude

    methods
    |> Map.new(fn map ->
      {map.name, map.result_type}
    end)
    |> Enum.sort()
    |> Enum.map(fn
      {method, @scalar} -> {method, "Itself"}
      {method, "" <> type} -> {method, type}
    end)
    |> then(fn tuples ->
      """
      %{
      #{
        Enum.map(tuples, fn {method, type} -> "#{inspect(method)} => Type.#{type}" end)
        |> Enum.join(",\n")
      }
      }
      """
    end)
  end

  @sep "\n\n"

  def emit(groups_with_method_types) do
    %{
      polymorphic_type: polymorphic_types,
      type_with_fields: types_with_fields,
      method_types_map: method_types_map
    } = groups_with_method_types

    polymorphic_types = Enum.filter(polymorphic_types, & &1[:dynamic_api_type])

    [
      "### generated method types map",
      method_types_map,
      "### polymorphic types dispatch",
      Enum.map(polymorphic_types, & &1.dynamic_api_type) |> Enum.join(@sep),
      @sep,
      dynamic_api_type_head(:fallback),
      "### types with fields",
      types_with_fields |> Enum.map(& &1.module) |> Enum.join(@sep)
    ]
    |> Enum.join(@sep)
    |> Code.format_string!()
    |> then(fn generated ->
      File.write("generated.ex", generated)
    end)
  end
end

Scraper.run()
