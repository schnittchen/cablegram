defmodule Cablegram.Model do
  @moduledoc """
  Utility module to build a model
  """

  defmacro __using__(opts) do
    %{api_type: api_type, members: members} =
      opts
      |> Keyword.validate!([:api_type, :members])
      |> Map.new()

    quote do
      import unquote(__MODULE__)

      @api_type unquote(api_type)
      def api_type, do: @api_type

      members = unquote(members)

      @member_infos Map.new(members, fn input ->
                      info = unquote(__MODULE__).build_member_info(input)

                      {info.payload_field, info}
                    end)

      def member_parse_info(payload_field) do
        Map.get(@member_infos, payload_field)
      end

      struct_fields =
        for {_, info} <- @member_infos, !info[:ignore?] do
          case info do
            %{field: field, default: default} -> {field, default}
            %{field: field} -> field
          end
        end

      @derive [Jason.Encoder]
      defstruct struct_fields

      def build(parsed) do
        struct!(__MODULE__, parsed)
      end
    end
  end

  def build_member_info(name) when is_atom(name) do
    %{field: name, as: Cablegram.Type.Itself, payload_field: to_string(name)}
  end

  def build_member_info({name, :ignore}) do
    %{payload_field: to_string(name), ignore?: true}
  end

  def build_member_info({name, type}) when is_atom(type) do
    %{field: name, as: type, payload_field: to_string(name)}
  end

  def build_member_info({name, fixed_value}) when is_binary(fixed_value) do
    %{
      field: name,
      as: Cablegram.Type.Itself,
      payload_field: to_string(name),
      default: fixed_value
    }
  end
end
