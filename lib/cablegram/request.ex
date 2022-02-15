defmodule Cablegram.Request do
  defstruct [
    :token,
    :method_name,
    :params,
    request_handler: Cablegram.RequestHandler,
    response_parser: Cablegram.ResponseParser
  ]

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
