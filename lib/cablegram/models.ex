alias Cablegram.{Type, Model}

defmodule Cablegram.Model.Animation do
  @scalars ~w{file_id file_unique_id width height duration file_name mime_type file_size}a
  @fixed []
  @structured [thumb: Type.PhotoSize]

  use Model, api_type: Type.Animation, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.Audio do
  @scalars ~w{file_id file_unique_id duration performer title file_name mime_type file_size}a
  @fixed []
  @structured [thumb: Type.PhotoSize]

  use Model, api_type: Type.Audio, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.BotCommand do
  @scalars ~w{command description}a
  @fixed []
  @structured []

  use Model, api_type: Type.BotCommand, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.BotCommandScopeAllChatAdministrators do
  @scalars ~w{}a
  @fixed [type: "all_chat_administrators"]
  @structured []

  use Model,
    api_type: Type.BotCommandScopeAllChatAdministrators,
    members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.BotCommandScopeAllGroupChats do
  @scalars ~w{}a
  @fixed [type: "all_group_chats"]
  @structured []

  use Model,
    api_type: Type.BotCommandScopeAllGroupChats,
    members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.BotCommandScopeAllPrivateChats do
  @scalars ~w{}a
  @fixed [type: "all_private_chats"]
  @structured []

  use Model,
    api_type: Type.BotCommandScopeAllPrivateChats,
    members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.BotCommandScopeChat do
  @scalars ~w{chat_id}a
  @fixed [type: "chat"]
  @structured []

  use Model, api_type: Type.BotCommandScopeChat, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.BotCommandScopeChatAdministrators do
  @scalars ~w{chat_id}a
  @fixed [type: "chat_administrators"]
  @structured []

  use Model,
    api_type: Type.BotCommandScopeChatAdministrators,
    members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.BotCommandScopeChatMember do
  @scalars ~w{chat_id user_id}a
  @fixed [type: "chat_member"]
  @structured []

  use Model, api_type: Type.BotCommandScopeChatMember, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.BotCommandScopeDefault do
  @scalars ~w{}a
  @fixed [type: "default"]
  @structured []

  use Model, api_type: Type.BotCommandScopeDefault, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.CallbackGame do
  @scalars ~w{}a
  @fixed []
  @structured []

  use Model, api_type: Type.CallbackGame, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.CallbackQuery do
  @scalars ~w{id inline_message_id chat_instance data game_short_name}a
  @fixed []
  @structured [from: Type.User, message: Type.Message]

  use Model, api_type: Type.CallbackQuery, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.Chat do
  @scalars ~w{id type title username first_name last_name bio has_private_forwards description invite_link slow_mode_delay message_auto_delete_time has_protected_content sticker_set_name can_set_sticker_set linked_chat_id}a
  @fixed []
  @structured [
    photo: Type.ChatPhoto,
    pinned_message: Type.Message,
    permissions: Type.ChatPermissions,
    location: Type.ChatLocation
  ]

  use Model, api_type: Type.Chat, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.ChatAdministratorRights do
  @scalars ~w{is_anonymous can_manage_chat can_delete_messages can_manage_video_chats can_restrict_members can_promote_members can_change_info can_invite_users can_post_messages can_edit_messages can_pin_messages}a
  @fixed []
  @structured []

  use Model, api_type: Type.ChatAdministratorRights, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.ChatInviteLink do
  @scalars ~w{invite_link creates_join_request is_primary is_revoked name expire_date member_limit pending_join_request_count}a
  @fixed []
  @structured [creator: Type.User]

  use Model, api_type: Type.ChatInviteLink, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.ChatJoinRequest do
  @scalars ~w{date bio}a
  @fixed []
  @structured [chat: Type.Chat, from: Type.User, invite_link: Type.ChatInviteLink]

  use Model, api_type: Type.ChatJoinRequest, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.ChatLocation do
  @scalars ~w{address}a
  @fixed []
  @structured [location: Type.Location]

  use Model, api_type: Type.ChatLocation, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.ChatMemberAdministrator do
  @scalars ~w{can_be_edited is_anonymous can_manage_chat can_delete_messages can_manage_video_chats can_restrict_members can_promote_members can_change_info can_invite_users can_post_messages can_edit_messages can_pin_messages custom_title}a
  @fixed [status: "administrator"]
  @structured [user: Type.User]

  use Model, api_type: Type.ChatMemberAdministrator, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.ChatMemberBanned do
  @scalars ~w{until_date}a
  @fixed [status: "kicked"]
  @structured [user: Type.User]

  use Model, api_type: Type.ChatMemberBanned, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.ChatMemberLeft do
  @scalars ~w{}a
  @fixed [status: "left"]
  @structured [user: Type.User]

  use Model, api_type: Type.ChatMemberLeft, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.ChatMemberMember do
  @scalars ~w{}a
  @fixed [status: "member"]
  @structured [user: Type.User]

  use Model, api_type: Type.ChatMemberMember, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.ChatMemberOwner do
  @scalars ~w{is_anonymous custom_title}a
  @fixed [status: "creator"]
  @structured [user: Type.User]

  use Model, api_type: Type.ChatMemberOwner, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.ChatMemberRestricted do
  @scalars ~w{is_member can_change_info can_invite_users can_pin_messages can_send_messages can_send_media_messages can_send_polls can_send_other_messages can_add_web_page_previews until_date}a
  @fixed [status: "restricted"]
  @structured [user: Type.User]

  use Model, api_type: Type.ChatMemberRestricted, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.ChatMemberUpdated do
  @scalars ~w{date}a
  @fixed []
  @structured [
    chat: Type.Chat,
    from: Type.User,
    old_chat_member: Type.ChatMember,
    new_chat_member: Type.ChatMember,
    invite_link: Type.ChatInviteLink
  ]

  use Model, api_type: Type.ChatMemberUpdated, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.ChatPermissions do
  @scalars ~w{can_send_messages can_send_media_messages can_send_polls can_send_other_messages can_add_web_page_previews can_change_info can_invite_users can_pin_messages}a
  @fixed []
  @structured []

  use Model, api_type: Type.ChatPermissions, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.ChatPhoto do
  @scalars ~w{small_file_id small_file_unique_id big_file_id big_file_unique_id}a
  @fixed []
  @structured []

  use Model, api_type: Type.ChatPhoto, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.ChosenInlineResult do
  @scalars ~w{result_id inline_message_id query}a
  @fixed []
  @structured [from: Type.User, location: Type.Location]

  use Model, api_type: Type.ChosenInlineResult, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.Contact do
  @scalars ~w{phone_number first_name last_name user_id vcard}a
  @fixed []
  @structured []

  use Model, api_type: Type.Contact, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.Dice do
  @scalars ~w{emoji value}a
  @fixed []
  @structured []

  use Model, api_type: Type.Dice, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.Document do
  @scalars ~w{file_id file_unique_id file_name mime_type file_size}a
  @fixed []
  @structured [thumb: Type.PhotoSize]

  use Model, api_type: Type.Document, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.EncryptedCredentials do
  @scalars ~w{data hash secret}a
  @fixed []
  @structured []

  use Model, api_type: Type.EncryptedCredentials, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.EncryptedPassportElement do
  @scalars ~w{type data phone_number email hash}a
  @fixed []
  @structured [
    files: Type.PassportFile,
    front_side: Type.PassportFile,
    reverse_side: Type.PassportFile,
    selfie: Type.PassportFile,
    translation: Type.PassportFile
  ]

  use Model, api_type: Type.EncryptedPassportElement, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.File do
  @scalars ~w{file_id file_unique_id file_size file_path}a
  @fixed []
  @structured []

  use Model, api_type: Type.File, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.ForceReply do
  @scalars ~w{force_reply input_field_placeholder selective}a
  @fixed []
  @structured []

  use Model, api_type: Type.ForceReply, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.Game do
  @scalars ~w{title description text}a
  @fixed []
  @structured [
    photo: Type.PhotoSize,
    text_entities: Type.MessageEntity,
    animation: Type.Animation
  ]

  use Model, api_type: Type.Game, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.GameHighScore do
  @scalars ~w{position score}a
  @fixed []
  @structured [user: Type.User]

  use Model, api_type: Type.GameHighScore, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.InlineKeyboardButton do
  @scalars ~w{text url callback_data switch_inline_query switch_inline_query_current_chat pay}a
  @fixed []
  @structured [
    web_app: Type.WebAppInfo,
    login_url: Type.LoginUrl,
    callback_game: Type.CallbackGame
  ]

  use Model, api_type: Type.InlineKeyboardButton, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.InlineKeyboardMarkup do
  @scalars ~w{}a
  @fixed []
  @structured [inline_keyboard: Type.InlineKeyboardButton]

  use Model, api_type: Type.InlineKeyboardMarkup, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.InlineQuery do
  @scalars ~w{id query offset chat_type}a
  @fixed []
  @structured [from: Type.User, location: Type.Location]

  use Model, api_type: Type.InlineQuery, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.InlineQueryResultArticle do
  @scalars ~w{id title url hide_url description thumb_url thumb_width thumb_height}a
  @fixed [type: "article"]
  @structured [
    input_message_content: Type.InputMessageContent,
    reply_markup: Type.InlineKeyboardMarkup
  ]

  use Model, api_type: Type.InlineQueryResultArticle, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.InlineQueryResultAudio do
  @scalars ~w{id audio_url title caption parse_mode performer audio_duration}a
  @fixed [type: "audio"]
  @structured [
    caption_entities: Type.MessageEntity,
    reply_markup: Type.InlineKeyboardMarkup,
    input_message_content: Type.InputMessageContent
  ]

  use Model, api_type: Type.InlineQueryResultAudio, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.InlineQueryResultCachedAudio do
  @scalars ~w{id audio_file_id caption parse_mode}a
  @fixed [type: "audio"]
  @structured [
    caption_entities: Type.MessageEntity,
    reply_markup: Type.InlineKeyboardMarkup,
    input_message_content: Type.InputMessageContent
  ]

  use Model,
    api_type: Type.InlineQueryResultCachedAudio,
    members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.InlineQueryResultCachedDocument do
  @scalars ~w{id title document_file_id description caption parse_mode}a
  @fixed [type: "document"]
  @structured [
    caption_entities: Type.MessageEntity,
    reply_markup: Type.InlineKeyboardMarkup,
    input_message_content: Type.InputMessageContent
  ]

  use Model,
    api_type: Type.InlineQueryResultCachedDocument,
    members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.InlineQueryResultCachedGif do
  @scalars ~w{id gif_file_id title caption parse_mode}a
  @fixed [type: "gif"]
  @structured [
    caption_entities: Type.MessageEntity,
    reply_markup: Type.InlineKeyboardMarkup,
    input_message_content: Type.InputMessageContent
  ]

  use Model, api_type: Type.InlineQueryResultCachedGif, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.InlineQueryResultCachedMpeg4Gif do
  @scalars ~w{id mpeg4_file_id title caption parse_mode}a
  @fixed [type: "mpeg4_gif"]
  @structured [
    caption_entities: Type.MessageEntity,
    reply_markup: Type.InlineKeyboardMarkup,
    input_message_content: Type.InputMessageContent
  ]

  use Model,
    api_type: Type.InlineQueryResultCachedMpeg4Gif,
    members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.InlineQueryResultCachedPhoto do
  @scalars ~w{id photo_file_id title description caption parse_mode}a
  @fixed [type: "photo"]
  @structured [
    caption_entities: Type.MessageEntity,
    reply_markup: Type.InlineKeyboardMarkup,
    input_message_content: Type.InputMessageContent
  ]

  use Model,
    api_type: Type.InlineQueryResultCachedPhoto,
    members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.InlineQueryResultCachedSticker do
  @scalars ~w{id sticker_file_id}a
  @fixed [type: "sticker"]
  @structured [
    reply_markup: Type.InlineKeyboardMarkup,
    input_message_content: Type.InputMessageContent
  ]

  use Model,
    api_type: Type.InlineQueryResultCachedSticker,
    members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.InlineQueryResultCachedVideo do
  @scalars ~w{id video_file_id title description caption parse_mode}a
  @fixed [type: "video"]
  @structured [
    caption_entities: Type.MessageEntity,
    reply_markup: Type.InlineKeyboardMarkup,
    input_message_content: Type.InputMessageContent
  ]

  use Model,
    api_type: Type.InlineQueryResultCachedVideo,
    members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.InlineQueryResultCachedVoice do
  @scalars ~w{id voice_file_id title caption parse_mode}a
  @fixed [type: "voice"]
  @structured [
    caption_entities: Type.MessageEntity,
    reply_markup: Type.InlineKeyboardMarkup,
    input_message_content: Type.InputMessageContent
  ]

  use Model,
    api_type: Type.InlineQueryResultCachedVoice,
    members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.InlineQueryResultContact do
  @scalars ~w{id phone_number first_name last_name vcard thumb_url thumb_width thumb_height}a
  @fixed [type: "contact"]
  @structured [
    reply_markup: Type.InlineKeyboardMarkup,
    input_message_content: Type.InputMessageContent
  ]

  use Model, api_type: Type.InlineQueryResultContact, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.InlineQueryResultDocument do
  @scalars ~w{id title caption parse_mode document_url mime_type description thumb_url thumb_width thumb_height}a
  @fixed [type: "document"]
  @structured [
    caption_entities: Type.MessageEntity,
    reply_markup: Type.InlineKeyboardMarkup,
    input_message_content: Type.InputMessageContent
  ]

  use Model, api_type: Type.InlineQueryResultDocument, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.InlineQueryResultGame do
  @scalars ~w{id game_short_name}a
  @fixed [type: "game"]
  @structured [reply_markup: Type.InlineKeyboardMarkup]

  use Model, api_type: Type.InlineQueryResultGame, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.InlineQueryResultGif do
  @scalars ~w{id gif_url gif_width gif_height gif_duration thumb_url thumb_mime_type title caption parse_mode}a
  @fixed [type: "gif"]
  @structured [
    caption_entities: Type.MessageEntity,
    reply_markup: Type.InlineKeyboardMarkup,
    input_message_content: Type.InputMessageContent
  ]

  use Model, api_type: Type.InlineQueryResultGif, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.InlineQueryResultLocation do
  @scalars ~w{id latitude longitude title horizontal_accuracy live_period heading proximity_alert_radius thumb_url thumb_width thumb_height}a
  @fixed [type: "location"]
  @structured [
    reply_markup: Type.InlineKeyboardMarkup,
    input_message_content: Type.InputMessageContent
  ]

  use Model, api_type: Type.InlineQueryResultLocation, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.InlineQueryResultMpeg4Gif do
  @scalars ~w{id mpeg4_url mpeg4_width mpeg4_height mpeg4_duration thumb_url thumb_mime_type title caption parse_mode}a
  @fixed [type: "mpeg4_gif"]
  @structured [
    caption_entities: Type.MessageEntity,
    reply_markup: Type.InlineKeyboardMarkup,
    input_message_content: Type.InputMessageContent
  ]

  use Model, api_type: Type.InlineQueryResultMpeg4Gif, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.InlineQueryResultPhoto do
  @scalars ~w{id photo_url thumb_url photo_width photo_height title description caption parse_mode}a
  @fixed [type: "photo"]
  @structured [
    caption_entities: Type.MessageEntity,
    reply_markup: Type.InlineKeyboardMarkup,
    input_message_content: Type.InputMessageContent
  ]

  use Model, api_type: Type.InlineQueryResultPhoto, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.InlineQueryResultVenue do
  @scalars ~w{id latitude longitude title address foursquare_id foursquare_type google_place_id google_place_type thumb_url thumb_width thumb_height}a
  @fixed [type: "venue"]
  @structured [
    reply_markup: Type.InlineKeyboardMarkup,
    input_message_content: Type.InputMessageContent
  ]

  use Model, api_type: Type.InlineQueryResultVenue, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.InlineQueryResultVideo do
  @scalars ~w{id video_url mime_type thumb_url title caption parse_mode video_width video_height video_duration description}a
  @fixed [type: "video"]
  @structured [
    caption_entities: Type.MessageEntity,
    reply_markup: Type.InlineKeyboardMarkup,
    input_message_content: Type.InputMessageContent
  ]

  use Model, api_type: Type.InlineQueryResultVideo, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.InlineQueryResultVoice do
  @scalars ~w{id voice_url title caption parse_mode voice_duration}a
  @fixed [type: "voice"]
  @structured [
    caption_entities: Type.MessageEntity,
    reply_markup: Type.InlineKeyboardMarkup,
    input_message_content: Type.InputMessageContent
  ]

  use Model, api_type: Type.InlineQueryResultVoice, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.InputContactMessageContent do
  @scalars ~w{phone_number first_name last_name vcard}a
  @fixed []
  @structured []

  use Model, api_type: Type.InputContactMessageContent, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.InputInvoiceMessageContent do
  @scalars ~w{title description payload provider_token currency max_tip_amount suggested_tip_amounts provider_data photo_url photo_size photo_width photo_height need_name need_phone_number need_email need_shipping_address send_phone_number_to_provider send_email_to_provider is_flexible}a
  @fixed []
  @structured [prices: Type.LabeledPrice]

  use Model, api_type: Type.InputInvoiceMessageContent, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.InputLocationMessageContent do
  @scalars ~w{latitude longitude horizontal_accuracy live_period heading proximity_alert_radius}a
  @fixed []
  @structured []

  use Model,
    api_type: Type.InputLocationMessageContent,
    members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.InputMediaAnimation do
  @scalars ~w{media thumb caption parse_mode width height duration}a
  @fixed [type: "animation"]
  @structured [caption_entities: Type.MessageEntity]

  use Model, api_type: Type.InputMediaAnimation, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.InputMediaAudio do
  @scalars ~w{media thumb caption parse_mode duration performer title}a
  @fixed [type: "audio"]
  @structured [caption_entities: Type.MessageEntity]

  use Model, api_type: Type.InputMediaAudio, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.InputMediaDocument do
  @scalars ~w{media thumb caption parse_mode disable_content_type_detection}a
  @fixed [type: "document"]
  @structured [caption_entities: Type.MessageEntity]

  use Model, api_type: Type.InputMediaDocument, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.InputMediaPhoto do
  @scalars ~w{media caption parse_mode}a
  @fixed [type: "photo"]
  @structured [caption_entities: Type.MessageEntity]

  use Model, api_type: Type.InputMediaPhoto, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.InputMediaVideo do
  @scalars ~w{media thumb caption parse_mode width height duration supports_streaming}a
  @fixed [type: "video"]
  @structured [caption_entities: Type.MessageEntity]

  use Model, api_type: Type.InputMediaVideo, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.InputTextMessageContent do
  @scalars ~w{message_text parse_mode disable_web_page_preview}a
  @fixed []
  @structured [entities: Type.MessageEntity]

  use Model, api_type: Type.InputTextMessageContent, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.InputVenueMessageContent do
  @scalars ~w{latitude longitude title address foursquare_id foursquare_type google_place_id google_place_type}a
  @fixed []
  @structured []

  use Model, api_type: Type.InputVenueMessageContent, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.Invoice do
  @scalars ~w{title description start_parameter currency total_amount}a
  @fixed []
  @structured []

  use Model, api_type: Type.Invoice, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.KeyboardButton do
  @scalars ~w{text request_contact request_location}a
  @fixed []
  @structured [request_poll: Type.KeyboardButtonPollType, web_app: Type.WebAppInfo]

  use Model, api_type: Type.KeyboardButton, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.KeyboardButtonPollType do
  @scalars ~w{type}a
  @fixed []
  @structured []

  use Model, api_type: Type.KeyboardButtonPollType, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.LabeledPrice do
  @scalars ~w{label amount}a
  @fixed []
  @structured []

  use Model, api_type: Type.LabeledPrice, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.Location do
  @scalars ~w{longitude latitude horizontal_accuracy live_period heading proximity_alert_radius}a
  @fixed []
  @structured []

  use Model, api_type: Type.Location, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.LoginUrl do
  @scalars ~w{url forward_text bot_username request_write_access}a
  @fixed []
  @structured []

  use Model, api_type: Type.LoginUrl, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.MaskPosition do
  @scalars ~w{point x_shift y_shift scale}a
  @fixed []
  @structured []

  use Model, api_type: Type.MaskPosition, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.MenuButtonCommands do
  @scalars ~w{}a
  @fixed [type: "commands"]
  @structured []

  use Model, api_type: Type.MenuButtonCommands, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.MenuButtonDefault do
  @scalars ~w{}a
  @fixed [type: "default"]
  @structured []

  use Model, api_type: Type.MenuButtonDefault, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.MenuButtonWebApp do
  @scalars ~w{text}a
  @fixed [type: "web_app"]
  @structured [web_app: Type.WebAppInfo]

  use Model, api_type: Type.MenuButtonWebApp, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.Message do
  @scalars ~w{message_id date forward_from_message_id forward_signature forward_sender_name forward_date is_automatic_forward edit_date has_protected_content media_group_id author_signature text caption new_chat_title delete_chat_photo group_chat_created supergroup_chat_created channel_chat_created migrate_to_chat_id migrate_from_chat_id connected_website}a
  @fixed []
  @structured [
    from: Type.User,
    sender_chat: Type.Chat,
    chat: Type.Chat,
    forward_from: Type.User,
    forward_from_chat: Type.Chat,
    reply_to_message: Type.Message,
    via_bot: Type.User,
    entities: Type.MessageEntity,
    animation: Type.Animation,
    audio: Type.Audio,
    document: Type.Document,
    photo: Type.PhotoSize,
    sticker: Type.Sticker,
    video: Type.Video,
    video_note: Type.VideoNote,
    voice: Type.Voice,
    caption_entities: Type.MessageEntity,
    contact: Type.Contact,
    dice: Type.Dice,
    game: Type.Game,
    poll: Type.Poll,
    venue: Type.Venue,
    location: Type.Location,
    new_chat_members: Type.User,
    left_chat_member: Type.User,
    new_chat_photo: Type.PhotoSize,
    message_auto_delete_timer_changed: Type.MessageAutoDeleteTimerChanged,
    pinned_message: Type.Message,
    invoice: Type.Invoice,
    successful_payment: Type.SuccessfulPayment,
    passport_data: Type.PassportData,
    proximity_alert_triggered: Type.ProximityAlertTriggered,
    video_chat_scheduled: Type.VideoChatScheduled,
    video_chat_started: Type.VideoChatStarted,
    video_chat_ended: Type.VideoChatEnded,
    video_chat_participants_invited: Type.VideoChatParticipantsInvited,
    web_app_data: Type.WebAppData,
    reply_markup: Type.InlineKeyboardMarkup
  ]

  use Model, api_type: Type.Message, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.MessageAutoDeleteTimerChanged do
  @scalars ~w{message_auto_delete_time}a
  @fixed []
  @structured []

  use Model,
    api_type: Type.MessageAutoDeleteTimerChanged,
    members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.MessageEntity do
  @scalars ~w{type offset length url language}a
  @fixed []
  @structured [user: Type.User]

  use Model, api_type: Type.MessageEntity, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.MessageId do
  @scalars ~w{message_id}a
  @fixed []
  @structured []

  use Model, api_type: Type.MessageId, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.OrderInfo do
  @scalars ~w{name phone_number email}a
  @fixed []
  @structured [shipping_address: Type.ShippingAddress]

  use Model, api_type: Type.OrderInfo, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.PassportData do
  @scalars ~w{}a
  @fixed []
  @structured [data: Type.EncryptedPassportElement, credentials: Type.EncryptedCredentials]

  use Model, api_type: Type.PassportData, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.PassportElementErrorDataField do
  @scalars ~w{type field_name data_hash message}a
  @fixed [source: "data"]
  @structured []

  use Model,
    api_type: Type.PassportElementErrorDataField,
    members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.PassportElementErrorFile do
  @scalars ~w{type file_hash message}a
  @fixed [source: "file"]
  @structured []

  use Model, api_type: Type.PassportElementErrorFile, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.PassportElementErrorFiles do
  @scalars ~w{type file_hashes message}a
  @fixed [source: "files"]
  @structured []

  use Model, api_type: Type.PassportElementErrorFiles, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.PassportElementErrorFrontSide do
  @scalars ~w{type file_hash message}a
  @fixed [source: "front_side"]
  @structured []

  use Model,
    api_type: Type.PassportElementErrorFrontSide,
    members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.PassportElementErrorReverseSide do
  @scalars ~w{type file_hash message}a
  @fixed [source: "reverse_side"]
  @structured []

  use Model,
    api_type: Type.PassportElementErrorReverseSide,
    members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.PassportElementErrorSelfie do
  @scalars ~w{type file_hash message}a
  @fixed [source: "selfie"]
  @structured []

  use Model, api_type: Type.PassportElementErrorSelfie, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.PassportElementErrorTranslationFile do
  @scalars ~w{type file_hash message}a
  @fixed [source: "translation_file"]
  @structured []

  use Model,
    api_type: Type.PassportElementErrorTranslationFile,
    members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.PassportElementErrorTranslationFiles do
  @scalars ~w{type file_hashes message}a
  @fixed [source: "translation_files"]
  @structured []

  use Model,
    api_type: Type.PassportElementErrorTranslationFiles,
    members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.PassportElementErrorUnspecified do
  @scalars ~w{type element_hash message}a
  @fixed [source: "unspecified"]
  @structured []

  use Model,
    api_type: Type.PassportElementErrorUnspecified,
    members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.PassportFile do
  @scalars ~w{file_id file_unique_id file_size file_date}a
  @fixed []
  @structured []

  use Model, api_type: Type.PassportFile, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.PhotoSize do
  @scalars ~w{file_id file_unique_id width height file_size}a
  @fixed []
  @structured []

  use Model, api_type: Type.PhotoSize, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.Poll do
  @scalars ~w{id question total_voter_count is_closed is_anonymous type allows_multiple_answers correct_option_id explanation open_period close_date}a
  @fixed []
  @structured [options: Type.PollOption, explanation_entities: Type.MessageEntity]

  use Model, api_type: Type.Poll, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.PollAnswer do
  @scalars ~w{poll_id option_ids}a
  @fixed []
  @structured [user: Type.User]

  use Model, api_type: Type.PollAnswer, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.PollOption do
  @scalars ~w{text voter_count}a
  @fixed []
  @structured []

  use Model, api_type: Type.PollOption, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.PreCheckoutQuery do
  @scalars ~w{id currency total_amount invoice_payload shipping_option_id}a
  @fixed []
  @structured [from: Type.User, order_info: Type.OrderInfo]

  use Model, api_type: Type.PreCheckoutQuery, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.ProximityAlertTriggered do
  @scalars ~w{distance}a
  @fixed []
  @structured [traveler: Type.User, watcher: Type.User]

  use Model, api_type: Type.ProximityAlertTriggered, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.ReplyKeyboardMarkup do
  @scalars ~w{resize_keyboard one_time_keyboard input_field_placeholder selective}a
  @fixed []
  @structured [keyboard: Type.KeyboardButton]

  use Model, api_type: Type.ReplyKeyboardMarkup, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.ReplyKeyboardRemove do
  @scalars ~w{remove_keyboard selective}a
  @fixed []
  @structured []

  use Model, api_type: Type.ReplyKeyboardRemove, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.ResponseParameters do
  @scalars ~w{migrate_to_chat_id retry_after}a
  @fixed []
  @structured []

  use Model, api_type: Type.ResponseParameters, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.SentWebAppMessage do
  @scalars ~w{inline_message_id}a
  @fixed []
  @structured []

  use Model, api_type: Type.SentWebAppMessage, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.ShippingAddress do
  @scalars ~w{country_code state city street_line1 street_line2 post_code}a
  @fixed []
  @structured []

  use Model, api_type: Type.ShippingAddress, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.ShippingOption do
  @scalars ~w{id title}a
  @fixed []
  @structured [prices: Type.LabeledPrice]

  use Model, api_type: Type.ShippingOption, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.ShippingQuery do
  @scalars ~w{id invoice_payload}a
  @fixed []
  @structured [from: Type.User, shipping_address: Type.ShippingAddress]

  use Model, api_type: Type.ShippingQuery, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.Sticker do
  @scalars ~w{file_id file_unique_id width height is_animated is_video emoji set_name file_size}a
  @fixed []
  @structured [thumb: Type.PhotoSize, mask_position: Type.MaskPosition]

  use Model, api_type: Type.Sticker, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.StickerSet do
  @scalars ~w{name title is_animated is_video contains_masks}a
  @fixed []
  @structured [stickers: Type.Sticker, thumb: Type.PhotoSize]

  use Model, api_type: Type.StickerSet, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.SuccessfulPayment do
  @scalars ~w{currency total_amount invoice_payload shipping_option_id telegram_payment_charge_id provider_payment_charge_id}a
  @fixed []
  @structured [order_info: Type.OrderInfo]

  use Model, api_type: Type.SuccessfulPayment, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.Update do
  @scalars ~w{update_id}a
  @fixed []
  @structured [
    message: Type.Message,
    edited_message: Type.Message,
    channel_post: Type.Message,
    edited_channel_post: Type.Message,
    inline_query: Type.InlineQuery,
    chosen_inline_result: Type.ChosenInlineResult,
    callback_query: Type.CallbackQuery,
    shipping_query: Type.ShippingQuery,
    pre_checkout_query: Type.PreCheckoutQuery,
    poll: Type.Poll,
    poll_answer: Type.PollAnswer,
    my_chat_member: Type.ChatMemberUpdated,
    chat_member: Type.ChatMemberUpdated,
    chat_join_request: Type.ChatJoinRequest
  ]

  use Model, api_type: Type.Update, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.User do
  @scalars ~w{id is_bot first_name last_name username language_code can_join_groups can_read_all_group_messages supports_inline_queries}a
  @fixed []
  @structured []

  use Model, api_type: Type.User, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.UserProfilePhotos do
  @scalars ~w{total_count}a
  @fixed []
  @structured [photos: Type.PhotoSize]

  use Model, api_type: Type.UserProfilePhotos, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.Venue do
  @scalars ~w{title address foursquare_id foursquare_type google_place_id google_place_type}a
  @fixed []
  @structured [location: Type.Location]

  use Model, api_type: Type.Venue, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.Video do
  @scalars ~w{file_id file_unique_id width height duration file_name mime_type file_size}a
  @fixed []
  @structured [thumb: Type.PhotoSize]

  use Model, api_type: Type.Video, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.VideoChatEnded do
  @scalars ~w{duration}a
  @fixed []
  @structured []

  use Model, api_type: Type.VideoChatEnded, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.VideoChatParticipantsInvited do
  @scalars ~w{}a
  @fixed []
  @structured [users: Type.User]

  use Model,
    api_type: Type.VideoChatParticipantsInvited,
    members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.VideoChatScheduled do
  @scalars ~w{start_date}a
  @fixed []
  @structured []

  use Model, api_type: Type.VideoChatScheduled, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.VideoChatStarted do
  @scalars ~w{}a
  @fixed []
  @structured []

  use Model, api_type: Type.VideoChatStarted, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.VideoNote do
  @scalars ~w{file_id file_unique_id length duration file_size}a
  @fixed []
  @structured [thumb: Type.PhotoSize]

  use Model, api_type: Type.VideoNote, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.Voice do
  @scalars ~w{file_id file_unique_id duration mime_type file_size}a
  @fixed []
  @structured []

  use Model, api_type: Type.Voice, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.WebAppData do
  @scalars ~w{data button_text}a
  @fixed []
  @structured []

  use Model, api_type: Type.WebAppData, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.WebAppInfo do
  @scalars ~w{url}a
  @fixed []
  @structured []

  use Model, api_type: Type.WebAppInfo, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Model.WebhookInfo do
  @scalars ~w{url has_custom_certificate pending_update_count ip_address last_error_date last_error_message last_synchronization_error_date max_connections allowed_updates}a
  @fixed []
  @structured []

  use Model, api_type: Type.WebhookInfo, members: @scalars ++ @fixed ++ @structured
end

defmodule Cablegram.Models do
  models =
    Path.join(__DIR__, "models.ex")
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(fn line ->
      # NOTE it's important that the following line does NOT match this regex:
      case Regex.run(~r{defmodule (Cablegram\.Model\.\w+)}, line) do
        nil -> nil
        [_, module] -> String.to_existing_atom("Elixir.#{module}")
      end
    end)
    |> Enum.filter(& &1)

  @models models

  def all, do: @models
end
