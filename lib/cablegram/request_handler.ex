defmodule Cablegram.RequestHandler do
  @moduledoc """
  Handles the low-level request, including params transformation.
  """

  def default_opts do
    [base_url: "https://api.telegram.org/bot"]
  end

  def run(request, opts \\ default_opts()) do
    base_url = Keyword.fetch!(opts, :base_url)
    url = "#{base_url}#{request.token}/#{request.method_name}"

    body = httpoison_body(request)
    headers = []

    HTTPoison.request(:post, url, body, headers)
    |> case do
      {:ok, %HTTPoison.Response{body: body, status_code: status_code}} ->
        Jason.decode(body)
        |> case do
          {:ok, %{"ok" => true, "result" => result}} ->
            {:ok, result}

          {:ok, %{"ok" => false} = json} ->
            {:error, %{status_code: status_code, json: json}}

          {:error, _} ->
            {:error, %{body: body, status_code: status_code, reason: :bad_json_in_body}}
        end

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp httpoison_body(request) do
    {upload_tuple, params} = pop_upload_param(request.params || [])
    params = serialize_form_params(params)

    case upload_tuple do
      nil ->
        {:form, params}

      {name, %{path: "" <> path} = input_file} ->
        disposition = disposition(name, input_file)
        extra_headers = []

        part = {:file, path, disposition, extra_headers}

        {:multipart, [part | params]}

      {name, %{binary: "" <> binary} = input_file} ->
        disposition = disposition(name, input_file)
        extra_headers = []

        part = {to_string(name), binary, disposition, extra_headers}

        {:multipart, [part | params]}
    end
  end

  defp pop_upload_param(params) do
    params
    |> Enum.split_with(fn
      {_, %Cablegram.InputFile{}} -> true
      _else -> false
    end)
    |> then(fn {uploads, params} ->
      case uploads do
        [] -> {nil, params}
        [upload_tuple] -> {upload_tuple, params}
        _else -> raise "only one upload is possible"
      end
    end)
  end

  defp serialize_form_params(params) do
    # As of the time of this writing, the API documentation at
    # https://core.telegram.org/bots/api mentions for each parameter
    # that it is JSON serialized if and only if the parameter at hand is
    # * an Array, or
    # * a compound type (object) known to the API, or
    # * the "provider_data" on the "sendInvoice" method
    # The latter is data of a type that is unknown to the bot API.
    #
    # This code interprets this as follows:
    # A parameter is sent JSON serialized if and only if it is an array
    # or a compound data structure (an Elixir struct or map).

    params
    |> Enum.filter(fn {_, v} -> v end)
    |> Enum.map(fn
      {k, list} when is_list(list) -> {to_string(k), Jason.encode!(list)}
      {k, %_{} = value} -> {to_string(k), Jason.encode!(value)}
      {k, v} -> {to_string(k), to_string(v)}
    end)
  end

  defp disposition(name, input_file) do
    {"form-data", [name: name, filename: input_file.filename]}
  end
end
