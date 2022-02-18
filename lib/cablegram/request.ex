defmodule Cablegram.Request do
  @moduledoc """
  A request for the API. Initialize it with your token, the method name and params:

      %Request{
        token: "YOUR_BOT_TOKEN",
        method_name: "sendMessage",
        params: [chat_id: chat_id, text: "Hello World"]
      }

  Params can be JSON serializable (via the `Jason.Encoder` protocol) structs, maps,
  scalars and lists thereof. For uploads, pass a `Cablegram.InputFile` struct as param.

  A request is sent and the response parsed by calling `Request.handle(request)`.
  """

  defstruct [
    :token,
    :method_name,
    :params,
    request_handler: Cablegram.RequestHandler,
    response_parser: Cablegram.ResponseParser
  ]

  @doc """
  Prepares and sends the request, and parses the response. Returns `{:ok, parsed}` where,
  if the response type of the method called is known, `parsed` is a model struct
  populated from the response. For example, a request with `method_name: "sendMessage"`
  will return a `Cablegram.Model.Message` struct.

  Returns `{:error, reason}` if something went wrong.
  """
  def handle(request) do
    %{request_handler: request_handler, response_parser: response_parser} = request

    case request_handler.run(request) do
      {:ok, result_in_response} ->
        result = response_parser.parse_result_in_response(result_in_response, request)

        {:ok, result}

      {:error, %{json: json} = reason} ->
        case json do
          %{"parameters" => response_parameters} ->
            response_parameters =
              response_parser.parse_as(response_parameters, Cablegram.Type.ResponseParameters)

            {:error, Map.put(reason, :parameters, response_parameters)}

          _else ->
            {:error, reason}
        end

      {:error, reason} ->
        {:error, reason}
    end
  end
end
