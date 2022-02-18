defmodule Cablegram do
  @moduledoc """
  Call the Telegram API by building and handling a `Cablegram.Request` (see details there):

      alias Cablegram.Request

      %Request{
        token: "YOUR_BOT_TOKEN",
        method_name: "sendMessage",
        params: [chat_id: chat_id, text: "Hello World"]
      }
      |> Request.handle
      |> case do
        {:ok, message} ->
          # message is parsed from the response data, a Cablegram.Model.Message struct
          :ok
      end

  When you receive updates via a web hook, call
  `Cablegram.ResponseParser.parse_update` which returns an update struct.
  """
end
