defmodule Cablegram.ResponseParser do
  def default_opts do
    [knowledge: Cablegram.Knowledge, warn_unknown_fields?: true]
  end

  def parse_update(data, opts \\ default_opts()) do
    parse_as(data, Cablegram.Type.Update, opts)
  end

  def parse_result_in_response(data, request, opts \\ default_opts()) do
    knowledge = Keyword.fetch!(opts, :knowledge)

    type =
      knowledge.method_result_type(request.method_name)
      |> knowledge.dynamic_api_type(data)

    parse_as(data, type, opts)
  end

  defp parse_as(data, type, opts) when is_list(data) do
    Enum.map(data, &parse_as(&1, type, opts))
  end

  defp parse_as(data, Cablegram.Type.Itself, _opts), do: data

  defp parse_as(data, api_type, opts) do
    knowledge = Keyword.fetch!(opts, :knowledge)

    type = knowledge.dynamic_api_type(api_type, data)

    if model = knowledge.model_for_api_type(type) do
      do_parse(data, model, opts)
    else
      require Logger

      Logger.warn "fallback_transform for #{api_type}"

      knowledge.fallback_transform(data)
    end
  end

  defp do_parse(data, host_model, opts) do
    Enum.reduce(data, [], fn {field, value}, acc ->
      case host_model.member_parse_info(field) do
        %{ignore?: true} ->
          acc

        nil ->
          if Keyword.get(opts, :warn_unknown_fields?) do
            require Logger

            Logger.warn("Unknown field #{inspect(field)} for type #{inspect(host_model)}")

            IO.inspect data
          end

          acc

        %{as: field_type, field: field} ->
          value =
            if is_list(value) do
              Enum.map(value, fn value ->
                parse_as(value, field_type, opts)
              end)
            else
              parse_as(value, field_type, opts)
            end

          [{field, value} | acc]
      end
    end)
    |> then(fn list -> host_model.build(list) end)
  end
end
