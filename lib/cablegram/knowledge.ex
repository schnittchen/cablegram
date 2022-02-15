defmodule Cablegram.Knowledge do
  @moduledoc """
  Provides knowledge to `Cablegram.ResponseParser`:

  * determines method result types
  * determines the concrete type of data which is of a polymorphic type.

  The Telegram Bot API documentation does not talk about polymorphic types, neverless
  it uses this concept.
  """

  alias Cablegram.Type

  def method_result_type(method_name) do
    %{
      "addStickerToSet" => Type.Itself,
      "answerCallbackQuery" => Type.Itself,
      "answerInlineQuery" => Type.Itself,
      "answerPreCheckoutQuery" => Type.Itself,
      "answerShippingQuery" => Type.Itself,
      "approveChatJoinRequest" => Type.Itself,
      "banChatMember" => Type.Itself,
      "banChatSenderChat" => Type.Itself,
      "close" => Type.Itself,
      "copyMessage" => Type.MessageId,
      "createChatInviteLink" => Type.ChatInviteLink,
      "createNewStickerSet" => Type.Itself,
      "declineChatJoinRequest" => Type.Itself,
      "deleteChatPhoto" => Type.Itself,
      "deleteChatStickerSet" => Type.Itself,
      "deleteMessage" => Type.Itself,
      "deleteMyCommands" => Type.Itself,
      "deleteStickerFromSet" => Type.Itself,
      "deleteWebhook" => Type.Itself,
      "editChatInviteLink" => Type.ChatInviteLink,
      "editMessageCaption" => Type.MessageOrTrue,
      "editMessageLiveLocation" => Type.MessageOrTrue,
      "editMessageMedia" => Type.MessageOrTrue,
      "editMessageReplyMarkup" => Type.MessageOrTrue,
      "editMessageText" => Type.MessageOrTrue,
      "exportChatInviteLink" => Type.Itself,
      "forwardMessage" => Type.Message,
      "getChat" => Type.Chat,
      "getChatAdministrators" => Type.ChatMember,
      "getChatMember" => Type.ChatMember,
      "getChatMemberCount" => Type.Itself,
      "getFile" => Type.File,
      "getGameHighScores" => Type.GameHighScore,
      "getMe" => Type.User,
      "getMyCommands" => Type.BotCommand,
      "getStickerSet" => Type.StickerSet,
      "getUpdates" => Type.Update,
      "getUserProfilePhotos" => Type.UserProfilePhotos,
      "getWebhookInfo" => Type.WebhookInfo,
      "leaveChat" => Type.Itself,
      "logOut" => Type.Itself,
      "pinChatMessage" => Type.Itself,
      "promoteChatMember" => Type.Itself,
      "restrictChatMember" => Type.Itself,
      "revokeChatInviteLink" => Type.ChatInviteLink,
      "sendAnimation" => Type.Message,
      "sendAudio" => Type.Message,
      "sendChatAction" => Type.Itself,
      "sendContact" => Type.Message,
      "sendDice" => Type.Message,
      "sendDocument" => Type.Message,
      "sendGame" => Type.Message,
      "sendInvoice" => Type.Message,
      "sendLocation" => Type.Message,
      "sendMediaGroup" => Type.Message,
      "sendMessage" => Type.Message,
      "sendPhoto" => Type.Message,
      "sendPoll" => Type.Message,
      "sendSticker" => Type.Message,
      "sendVenue" => Type.Message,
      "sendVideo" => Type.Message,
      "sendVideoNote" => Type.Message,
      "sendVoice" => Type.Message,
      "setChatAdministratorCustomTitle" => Type.Itself,
      "setChatDescription" => Type.Itself,
      "setChatPermissions" => Type.Itself,
      "setChatPhoto" => Type.Itself,
      "setChatStickerSet" => Type.Itself,
      "setChatTitle" => Type.Itself,
      "setGameScore" => Type.MessageOrTrue,
      "setMyCommands" => Type.Itself,
      "setPassportDataErrors" => Type.Itself,
      "setStickerPositionInSet" => Type.Itself,
      "setStickerSetThumb" => Type.Itself,
      "setWebhook" => Type.Itself,
      "stopMessageLiveLocation" => Type.MessageOrTrue,
      "stopPoll" => Type.Poll,
      "unbanChatMember" => Type.Itself,
      "unbanChatSenderChat" => Type.Itself,
      "unpinAllChatMessages" => Type.Itself,
      "unpinChatMessage" => Type.Itself,
      "uploadStickerFile" => Type.File
    }
    |> Map.get(method_name, Type.Fallback)
  end

  def dynamic_api_type(Type.ChatMember, %{"status" => status}) do
    case status do
      "creator" -> Type.ChatMemberOwner
      "administrator" -> Type.ChatMemberAdministrator
      "member" -> Type.ChatMemberMember
      "restricted" -> Type.ChatMemberRestricted
      "left" -> Type.ChatMemberLeft
      "kicked" -> Type.ChatMemberBanned
      _ -> Type.Fallback
    end
  end

  def dynamic_api_type(Type.MessageOrTrue, data) do
    case data do
      true -> Type.Itself
      _else -> Type.Message
    end
  end

  def dynamic_api_type(type, _data), do: type

  def fallback_transform(data), do: {:fallback, data}

  Cablegram.Models.all()
  |> Enum.each(fn model ->
    api_type = model.api_type()

    def model_for_api_type(unquote(api_type)), do: unquote(model)
  end)

  def model_for_api_type(_), do: nil
end
