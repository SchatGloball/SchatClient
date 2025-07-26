//
//  Generated code. Do not modify.
//  source: chats.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class RequestDto extends $pb.GeneratedMessage {
  factory RequestDto() => create();

  RequestDto._();

  factory RequestDto.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory RequestDto.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RequestDto', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestDto clone() => RequestDto()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestDto copyWith(void Function(RequestDto) updates) => super.copyWith((message) => updates(message as RequestDto)) as RequestDto;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestDto create() => RequestDto._();
  @$core.override
  RequestDto createEmptyInstance() => create();
  static $pb.PbList<RequestDto> createRepeated() => $pb.PbList<RequestDto>();
  @$core.pragma('dart2js:noInline')
  static RequestDto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestDto>(create);
  static RequestDto? _defaultInstance;
}

class SearchRequestDto extends $pb.GeneratedMessage {
  factory SearchRequestDto({
    $core.String? searchRequest,
    ChatDto? chat,
  }) {
    final result = create();
    if (searchRequest != null) result.searchRequest = searchRequest;
    if (chat != null) result.chat = chat;
    return result;
  }

  SearchRequestDto._();

  factory SearchRequestDto.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory SearchRequestDto.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SearchRequestDto', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'searchRequest', protoName: 'searchRequest')
    ..aOM<ChatDto>(2, _omitFieldNames ? '' : 'chat', subBuilder: ChatDto.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchRequestDto clone() => SearchRequestDto()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchRequestDto copyWith(void Function(SearchRequestDto) updates) => super.copyWith((message) => updates(message as SearchRequestDto)) as SearchRequestDto;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchRequestDto create() => SearchRequestDto._();
  @$core.override
  SearchRequestDto createEmptyInstance() => create();
  static $pb.PbList<SearchRequestDto> createRepeated() => $pb.PbList<SearchRequestDto>();
  @$core.pragma('dart2js:noInline')
  static SearchRequestDto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchRequestDto>(create);
  static SearchRequestDto? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get searchRequest => $_getSZ(0);
  @$pb.TagNumber(1)
  set searchRequest($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSearchRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearSearchRequest() => $_clearField(1);

  @$pb.TagNumber(2)
  ChatDto get chat => $_getN(1);
  @$pb.TagNumber(2)
  set chat(ChatDto value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasChat() => $_has(1);
  @$pb.TagNumber(2)
  void clearChat() => $_clearField(2);
  @$pb.TagNumber(2)
  ChatDto ensureChat() => $_ensure(1);
}

enum MemberDto_OptionalMember {
  memberImage, 
  notSet
}

class MemberDto extends $pb.GeneratedMessage {
  factory MemberDto({
    $core.String? memberUsername,
    $core.String? memberImage,
  }) {
    final result = create();
    if (memberUsername != null) result.memberUsername = memberUsername;
    if (memberImage != null) result.memberImage = memberImage;
    return result;
  }

  MemberDto._();

  factory MemberDto.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory MemberDto.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, MemberDto_OptionalMember> _MemberDto_OptionalMemberByTag = {
    2 : MemberDto_OptionalMember.memberImage,
    0 : MemberDto_OptionalMember.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MemberDto', createEmptyInstance: create)
    ..oo(0, [2])
    ..aOS(1, _omitFieldNames ? '' : 'memberUsername')
    ..aOS(2, _omitFieldNames ? '' : 'memberImage')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MemberDto clone() => MemberDto()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MemberDto copyWith(void Function(MemberDto) updates) => super.copyWith((message) => updates(message as MemberDto)) as MemberDto;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MemberDto create() => MemberDto._();
  @$core.override
  MemberDto createEmptyInstance() => create();
  static $pb.PbList<MemberDto> createRepeated() => $pb.PbList<MemberDto>();
  @$core.pragma('dart2js:noInline')
  static MemberDto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MemberDto>(create);
  static MemberDto? _defaultInstance;

  MemberDto_OptionalMember whichOptionalMember() => _MemberDto_OptionalMemberByTag[$_whichOneof(0)]!;
  void clearOptionalMember() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get memberUsername => $_getSZ(0);
  @$pb.TagNumber(1)
  set memberUsername($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMemberUsername() => $_has(0);
  @$pb.TagNumber(1)
  void clearMemberUsername() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get memberImage => $_getSZ(1);
  @$pb.TagNumber(2)
  set memberImage($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMemberImage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMemberImage() => $_clearField(2);
}

class ListChatsDto extends $pb.GeneratedMessage {
  factory ListChatsDto({
    $core.Iterable<ChatDto>? chats,
  }) {
    final result = create();
    if (chats != null) result.chats.addAll(chats);
    return result;
  }

  ListChatsDto._();

  factory ListChatsDto.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ListChatsDto.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListChatsDto', createEmptyInstance: create)
    ..pc<ChatDto>(1, _omitFieldNames ? '' : 'chats', $pb.PbFieldType.PM, subBuilder: ChatDto.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListChatsDto clone() => ListChatsDto()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListChatsDto copyWith(void Function(ListChatsDto) updates) => super.copyWith((message) => updates(message as ListChatsDto)) as ListChatsDto;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListChatsDto create() => ListChatsDto._();
  @$core.override
  ListChatsDto createEmptyInstance() => create();
  static $pb.PbList<ListChatsDto> createRepeated() => $pb.PbList<ListChatsDto>();
  @$core.pragma('dart2js:noInline')
  static ListChatsDto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListChatsDto>(create);
  static ListChatsDto? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<ChatDto> get chats => $_getList(0);
}

enum ChatDto_OptionalChat {
  chatImage, 
  notSet
}

class ChatDto extends $pb.GeneratedMessage {
  factory ChatDto({
    $core.int? id,
    $core.String? name,
    $core.String? authorId,
    $core.Iterable<MessageDto>? messages,
    $core.String? chatImage,
    $core.Iterable<MemberDto>? members,
    $core.List<$core.int>? image,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (authorId != null) result.authorId = authorId;
    if (messages != null) result.messages.addAll(messages);
    if (chatImage != null) result.chatImage = chatImage;
    if (members != null) result.members.addAll(members);
    if (image != null) result.image = image;
    return result;
  }

  ChatDto._();

  factory ChatDto.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ChatDto.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, ChatDto_OptionalChat> _ChatDto_OptionalChatByTag = {
    5 : ChatDto_OptionalChat.chatImage,
    0 : ChatDto_OptionalChat.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChatDto', createEmptyInstance: create)
    ..oo(0, [5])
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'authorId')
    ..pc<MessageDto>(4, _omitFieldNames ? '' : 'messages', $pb.PbFieldType.PM, subBuilder: MessageDto.create)
    ..aOS(5, _omitFieldNames ? '' : 'chatImage')
    ..pc<MemberDto>(6, _omitFieldNames ? '' : 'members', $pb.PbFieldType.PM, subBuilder: MemberDto.create)
    ..a<$core.List<$core.int>>(7, _omitFieldNames ? '' : 'image', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatDto clone() => ChatDto()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatDto copyWith(void Function(ChatDto) updates) => super.copyWith((message) => updates(message as ChatDto)) as ChatDto;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatDto create() => ChatDto._();
  @$core.override
  ChatDto createEmptyInstance() => create();
  static $pb.PbList<ChatDto> createRepeated() => $pb.PbList<ChatDto>();
  @$core.pragma('dart2js:noInline')
  static ChatDto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChatDto>(create);
  static ChatDto? _defaultInstance;

  ChatDto_OptionalChat whichOptionalChat() => _ChatDto_OptionalChatByTag[$_whichOneof(0)]!;
  void clearOptionalChat() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get authorId => $_getSZ(2);
  @$pb.TagNumber(3)
  set authorId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAuthorId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAuthorId() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<MessageDto> get messages => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get chatImage => $_getSZ(4);
  @$pb.TagNumber(5)
  set chatImage($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasChatImage() => $_has(4);
  @$pb.TagNumber(5)
  void clearChatImage() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<MemberDto> get members => $_getList(5);

  @$pb.TagNumber(7)
  $core.List<$core.int> get image => $_getN(6);
  @$pb.TagNumber(7)
  set image($core.List<$core.int> value) => $_setBytes(6, value);
  @$pb.TagNumber(7)
  $core.bool hasImage() => $_has(6);
  @$pb.TagNumber(7)
  void clearImage() => $_clearField(7);
}

enum MessageDto_OptionalMessage {
  dateMessage, 
  notSet
}

class MessageDto extends $pb.GeneratedMessage {
  factory MessageDto({
    $core.int? id,
    $core.String? body,
    $core.int? authorId,
    $core.int? chatId,
    $core.String? authorName,
    $core.bool? delivered,
    $core.Iterable<$core.List<$core.int>>? data,
    $core.Iterable<$core.String>? content,
    $core.int? stickerContent,
    $core.String? dateMessage,
    $core.Iterable<ReactionMessageDto>? reaction,
    $core.bool? forwarded,
    $core.String? originalAuthor,
    $core.String? originalDate,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (body != null) result.body = body;
    if (authorId != null) result.authorId = authorId;
    if (chatId != null) result.chatId = chatId;
    if (authorName != null) result.authorName = authorName;
    if (delivered != null) result.delivered = delivered;
    if (data != null) result.data.addAll(data);
    if (content != null) result.content.addAll(content);
    if (stickerContent != null) result.stickerContent = stickerContent;
    if (dateMessage != null) result.dateMessage = dateMessage;
    if (reaction != null) result.reaction.addAll(reaction);
    if (forwarded != null) result.forwarded = forwarded;
    if (originalAuthor != null) result.originalAuthor = originalAuthor;
    if (originalDate != null) result.originalDate = originalDate;
    return result;
  }

  MessageDto._();

  factory MessageDto.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory MessageDto.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, MessageDto_OptionalMessage> _MessageDto_OptionalMessageByTag = {
    10 : MessageDto_OptionalMessage.dateMessage,
    0 : MessageDto_OptionalMessage.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MessageDto', createEmptyInstance: create)
    ..oo(0, [10])
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'body')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'authorId', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'chatId', $pb.PbFieldType.O3)
    ..aOS(5, _omitFieldNames ? '' : 'authorName')
    ..aOB(6, _omitFieldNames ? '' : 'delivered')
    ..p<$core.List<$core.int>>(7, _omitFieldNames ? '' : 'data', $pb.PbFieldType.PY)
    ..pPS(8, _omitFieldNames ? '' : 'content')
    ..a<$core.int>(9, _omitFieldNames ? '' : 'stickerContent', $pb.PbFieldType.O3)
    ..aOS(10, _omitFieldNames ? '' : 'dateMessage')
    ..pc<ReactionMessageDto>(11, _omitFieldNames ? '' : 'reaction', $pb.PbFieldType.PM, subBuilder: ReactionMessageDto.create)
    ..aOB(12, _omitFieldNames ? '' : 'forwarded')
    ..aOS(13, _omitFieldNames ? '' : 'originalAuthor', protoName: 'originalAuthor')
    ..aOS(14, _omitFieldNames ? '' : 'originalDate', protoName: 'originalDate')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MessageDto clone() => MessageDto()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MessageDto copyWith(void Function(MessageDto) updates) => super.copyWith((message) => updates(message as MessageDto)) as MessageDto;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MessageDto create() => MessageDto._();
  @$core.override
  MessageDto createEmptyInstance() => create();
  static $pb.PbList<MessageDto> createRepeated() => $pb.PbList<MessageDto>();
  @$core.pragma('dart2js:noInline')
  static MessageDto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MessageDto>(create);
  static MessageDto? _defaultInstance;

  MessageDto_OptionalMessage whichOptionalMessage() => _MessageDto_OptionalMessageByTag[$_whichOneof(0)]!;
  void clearOptionalMessage() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get body => $_getSZ(1);
  @$pb.TagNumber(2)
  set body($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBody() => $_has(1);
  @$pb.TagNumber(2)
  void clearBody() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get authorId => $_getIZ(2);
  @$pb.TagNumber(3)
  set authorId($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAuthorId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAuthorId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get chatId => $_getIZ(3);
  @$pb.TagNumber(4)
  set chatId($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasChatId() => $_has(3);
  @$pb.TagNumber(4)
  void clearChatId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get authorName => $_getSZ(4);
  @$pb.TagNumber(5)
  set authorName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAuthorName() => $_has(4);
  @$pb.TagNumber(5)
  void clearAuthorName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get delivered => $_getBF(5);
  @$pb.TagNumber(6)
  set delivered($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDelivered() => $_has(5);
  @$pb.TagNumber(6)
  void clearDelivered() => $_clearField(6);

  @$pb.TagNumber(7)
  $pb.PbList<$core.List<$core.int>> get data => $_getList(6);

  @$pb.TagNumber(8)
  $pb.PbList<$core.String> get content => $_getList(7);

  @$pb.TagNumber(9)
  $core.int get stickerContent => $_getIZ(8);
  @$pb.TagNumber(9)
  set stickerContent($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasStickerContent() => $_has(8);
  @$pb.TagNumber(9)
  void clearStickerContent() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get dateMessage => $_getSZ(9);
  @$pb.TagNumber(10)
  set dateMessage($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasDateMessage() => $_has(9);
  @$pb.TagNumber(10)
  void clearDateMessage() => $_clearField(10);

  @$pb.TagNumber(11)
  $pb.PbList<ReactionMessageDto> get reaction => $_getList(10);

  @$pb.TagNumber(12)
  $core.bool get forwarded => $_getBF(11);
  @$pb.TagNumber(12)
  set forwarded($core.bool value) => $_setBool(11, value);
  @$pb.TagNumber(12)
  $core.bool hasForwarded() => $_has(11);
  @$pb.TagNumber(12)
  void clearForwarded() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get originalAuthor => $_getSZ(12);
  @$pb.TagNumber(13)
  set originalAuthor($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasOriginalAuthor() => $_has(12);
  @$pb.TagNumber(13)
  void clearOriginalAuthor() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get originalDate => $_getSZ(13);
  @$pb.TagNumber(14)
  set originalDate($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasOriginalDate() => $_has(13);
  @$pb.TagNumber(14)
  void clearOriginalDate() => $_clearField(14);
}

enum ReactionMessageDto_OptionalMessage {
  dateReaction, 
  notSet
}

class ReactionMessageDto extends $pb.GeneratedMessage {
  factory ReactionMessageDto({
    $core.int? id,
    $core.String? body,
    $core.int? authorId,
    $core.String? authorName,
    $core.int? messageId,
    $core.int? stickerContent,
    $core.String? dateReaction,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (body != null) result.body = body;
    if (authorId != null) result.authorId = authorId;
    if (authorName != null) result.authorName = authorName;
    if (messageId != null) result.messageId = messageId;
    if (stickerContent != null) result.stickerContent = stickerContent;
    if (dateReaction != null) result.dateReaction = dateReaction;
    return result;
  }

  ReactionMessageDto._();

  factory ReactionMessageDto.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ReactionMessageDto.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, ReactionMessageDto_OptionalMessage> _ReactionMessageDto_OptionalMessageByTag = {
    7 : ReactionMessageDto_OptionalMessage.dateReaction,
    0 : ReactionMessageDto_OptionalMessage.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ReactionMessageDto', createEmptyInstance: create)
    ..oo(0, [7])
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'body')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'authorId', $pb.PbFieldType.O3)
    ..aOS(4, _omitFieldNames ? '' : 'authorName')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'messageId', $pb.PbFieldType.O3, protoName: 'messageId')
    ..a<$core.int>(6, _omitFieldNames ? '' : 'stickerContent', $pb.PbFieldType.O3)
    ..aOS(7, _omitFieldNames ? '' : 'dateReaction', protoName: 'dateReaction')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReactionMessageDto clone() => ReactionMessageDto()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReactionMessageDto copyWith(void Function(ReactionMessageDto) updates) => super.copyWith((message) => updates(message as ReactionMessageDto)) as ReactionMessageDto;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReactionMessageDto create() => ReactionMessageDto._();
  @$core.override
  ReactionMessageDto createEmptyInstance() => create();
  static $pb.PbList<ReactionMessageDto> createRepeated() => $pb.PbList<ReactionMessageDto>();
  @$core.pragma('dart2js:noInline')
  static ReactionMessageDto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReactionMessageDto>(create);
  static ReactionMessageDto? _defaultInstance;

  ReactionMessageDto_OptionalMessage whichOptionalMessage() => _ReactionMessageDto_OptionalMessageByTag[$_whichOneof(0)]!;
  void clearOptionalMessage() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get body => $_getSZ(1);
  @$pb.TagNumber(2)
  set body($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBody() => $_has(1);
  @$pb.TagNumber(2)
  void clearBody() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get authorId => $_getIZ(2);
  @$pb.TagNumber(3)
  set authorId($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAuthorId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAuthorId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get authorName => $_getSZ(3);
  @$pb.TagNumber(4)
  set authorName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAuthorName() => $_has(3);
  @$pb.TagNumber(4)
  void clearAuthorName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get messageId => $_getIZ(4);
  @$pb.TagNumber(5)
  set messageId($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMessageId() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessageId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get stickerContent => $_getIZ(5);
  @$pb.TagNumber(6)
  set stickerContent($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasStickerContent() => $_has(5);
  @$pb.TagNumber(6)
  void clearStickerContent() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get dateReaction => $_getSZ(6);
  @$pb.TagNumber(7)
  set dateReaction($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDateReaction() => $_has(6);
  @$pb.TagNumber(7)
  void clearDateReaction() => $_clearField(7);
}

class ResponseDto extends $pb.GeneratedMessage {
  factory ResponseDto({
    $core.String? message,
  }) {
    final result = create();
    if (message != null) result.message = message;
    return result;
  }

  ResponseDto._();

  factory ResponseDto.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ResponseDto.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ResponseDto', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResponseDto clone() => ResponseDto()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResponseDto copyWith(void Function(ResponseDto) updates) => super.copyWith((message) => updates(message as ResponseDto)) as ResponseDto;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResponseDto create() => ResponseDto._();
  @$core.override
  ResponseDto createEmptyInstance() => create();
  static $pb.PbList<ResponseDto> createRepeated() => $pb.PbList<ResponseDto>();
  @$core.pragma('dart2js:noInline')
  static ResponseDto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResponseDto>(create);
  static ResponseDto? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => $_clearField(1);
}

class UpdateDTO extends $pb.GeneratedMessage {
  factory UpdateDTO({
    ChatDto? chat,
  }) {
    final result = create();
    if (chat != null) result.chat = chat;
    return result;
  }

  UpdateDTO._();

  factory UpdateDTO.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory UpdateDTO.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateDTO', createEmptyInstance: create)
    ..aOM<ChatDto>(1, _omitFieldNames ? '' : 'chat', subBuilder: ChatDto.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateDTO clone() => UpdateDTO()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateDTO copyWith(void Function(UpdateDTO) updates) => super.copyWith((message) => updates(message as UpdateDTO)) as UpdateDTO;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateDTO create() => UpdateDTO._();
  @$core.override
  UpdateDTO createEmptyInstance() => create();
  static $pb.PbList<UpdateDTO> createRepeated() => $pb.PbList<UpdateDTO>();
  @$core.pragma('dart2js:noInline')
  static UpdateDTO getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateDTO>(create);
  static UpdateDTO? _defaultInstance;

  @$pb.TagNumber(1)
  ChatDto get chat => $_getN(0);
  @$pb.TagNumber(1)
  set chat(ChatDto value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasChat() => $_has(0);
  @$pb.TagNumber(1)
  void clearChat() => $_clearField(1);
  @$pb.TagNumber(1)
  ChatDto ensureChat() => $_ensure(0);
}

class UpdateAppReq extends $pb.GeneratedMessage {
  factory UpdateAppReq({
    $core.int? version,
    $core.String? platform,
  }) {
    final result = create();
    if (version != null) result.version = version;
    if (platform != null) result.platform = platform;
    return result;
  }

  UpdateAppReq._();

  factory UpdateAppReq.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory UpdateAppReq.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateAppReq', createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'version', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'platform')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateAppReq clone() => UpdateAppReq()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateAppReq copyWith(void Function(UpdateAppReq) updates) => super.copyWith((message) => updates(message as UpdateAppReq)) as UpdateAppReq;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateAppReq create() => UpdateAppReq._();
  @$core.override
  UpdateAppReq createEmptyInstance() => create();
  static $pb.PbList<UpdateAppReq> createRepeated() => $pb.PbList<UpdateAppReq>();
  @$core.pragma('dart2js:noInline')
  static UpdateAppReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateAppReq>(create);
  static UpdateAppReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get version => $_getIZ(0);
  @$pb.TagNumber(1)
  set version($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersion() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get platform => $_getSZ(1);
  @$pb.TagNumber(2)
  set platform($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPlatform() => $_has(1);
  @$pb.TagNumber(2)
  void clearPlatform() => $_clearField(2);
}

class UpdateAppRes extends $pb.GeneratedMessage {
  factory UpdateAppRes({
    $core.String? name,
    $core.List<$core.int>? data,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (data != null) result.data = data;
    return result;
  }

  UpdateAppRes._();

  factory UpdateAppRes.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory UpdateAppRes.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateAppRes', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateAppRes clone() => UpdateAppRes()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateAppRes copyWith(void Function(UpdateAppRes) updates) => super.copyWith((message) => updates(message as UpdateAppRes)) as UpdateAppRes;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateAppRes create() => UpdateAppRes._();
  @$core.override
  UpdateAppRes createEmptyInstance() => create();
  static $pb.PbList<UpdateAppRes> createRepeated() => $pb.PbList<UpdateAppRes>();
  @$core.pragma('dart2js:noInline')
  static UpdateAppRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateAppRes>(create);
  static UpdateAppRes? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get data => $_getN(1);
  @$pb.TagNumber(2)
  set data($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => $_clearField(2);
}


const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
