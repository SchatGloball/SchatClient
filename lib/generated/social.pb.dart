// This is a generated file - do not edit.
//
// Generated from social.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class RequestPostsDto extends $pb.GeneratedMessage {
  factory RequestPostsDto({
    $core.int? offset,
    ChannelDto? channel,
  }) {
    final result = create();
    if (offset != null) result.offset = offset;
    if (channel != null) result.channel = channel;
    return result;
  }

  RequestPostsDto._();

  factory RequestPostsDto.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory RequestPostsDto.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RequestPostsDto', createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..aOM<ChannelDto>(2, _omitFieldNames ? '' : 'channel', subBuilder: ChannelDto.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestPostsDto clone() => RequestPostsDto()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestPostsDto copyWith(void Function(RequestPostsDto) updates) => super.copyWith((message) => updates(message as RequestPostsDto)) as RequestPostsDto;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestPostsDto create() => RequestPostsDto._();
  @$core.override
  RequestPostsDto createEmptyInstance() => create();
  static $pb.PbList<RequestPostsDto> createRepeated() => $pb.PbList<RequestPostsDto>();
  @$core.pragma('dart2js:noInline')
  static RequestPostsDto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestPostsDto>(create);
  static RequestPostsDto? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get offset => $_getIZ(0);
  @$pb.TagNumber(1)
  set offset($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOffset() => $_has(0);
  @$pb.TagNumber(1)
  void clearOffset() => $_clearField(1);

  @$pb.TagNumber(2)
  ChannelDto get channel => $_getN(1);
  @$pb.TagNumber(2)
  set channel(ChannelDto value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasChannel() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannel() => $_clearField(2);
  @$pb.TagNumber(2)
  ChannelDto ensureChannel() => $_ensure(1);
}

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
  }) {
    final result = create();
    if (searchRequest != null) result.searchRequest = searchRequest;
    return result;
  }

  SearchRequestDto._();

  factory SearchRequestDto.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory SearchRequestDto.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SearchRequestDto', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'searchRequest', protoName: 'searchRequest')
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

class ListChannelsDto extends $pb.GeneratedMessage {
  factory ListChannelsDto({
    $core.Iterable<ChannelDto>? channels,
  }) {
    final result = create();
    if (channels != null) result.channels.addAll(channels);
    return result;
  }

  ListChannelsDto._();

  factory ListChannelsDto.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ListChannelsDto.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListChannelsDto', createEmptyInstance: create)
    ..pc<ChannelDto>(1, _omitFieldNames ? '' : 'channels', $pb.PbFieldType.PM, subBuilder: ChannelDto.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListChannelsDto clone() => ListChannelsDto()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListChannelsDto copyWith(void Function(ListChannelsDto) updates) => super.copyWith((message) => updates(message as ListChannelsDto)) as ListChannelsDto;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListChannelsDto create() => ListChannelsDto._();
  @$core.override
  ListChannelsDto createEmptyInstance() => create();
  static $pb.PbList<ListChannelsDto> createRepeated() => $pb.PbList<ListChannelsDto>();
  @$core.pragma('dart2js:noInline')
  static ListChannelsDto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListChannelsDto>(create);
  static ListChannelsDto? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<ChannelDto> get channels => $_getList(0);
}

class ListPostsDto extends $pb.GeneratedMessage {
  factory ListPostsDto({
    $core.Iterable<PostDto>? posts,
  }) {
    final result = create();
    if (posts != null) result.posts.addAll(posts);
    return result;
  }

  ListPostsDto._();

  factory ListPostsDto.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ListPostsDto.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListPostsDto', createEmptyInstance: create)
    ..pc<PostDto>(1, _omitFieldNames ? '' : 'posts', $pb.PbFieldType.PM, subBuilder: PostDto.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPostsDto clone() => ListPostsDto()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPostsDto copyWith(void Function(ListPostsDto) updates) => super.copyWith((message) => updates(message as ListPostsDto)) as ListPostsDto;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListPostsDto create() => ListPostsDto._();
  @$core.override
  ListPostsDto createEmptyInstance() => create();
  static $pb.PbList<ListPostsDto> createRepeated() => $pb.PbList<ListPostsDto>();
  @$core.pragma('dart2js:noInline')
  static ListPostsDto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListPostsDto>(create);
  static ListPostsDto? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<PostDto> get posts => $_getList(0);
}

enum ChannelDto_OptionalChat {
  channelImage, 
  notSet
}

class ChannelDto extends $pb.GeneratedMessage {
  factory ChannelDto({
    $core.int? id,
    $core.String? name,
    $core.int? authorId,
    $core.Iterable<PostDto>? posts,
    $core.String? channelImage,
    $core.Iterable<MemberDto>? members,
    $core.List<$core.int>? image,
    $core.Iterable<$core.String>? tags,
    $core.Iterable<$core.String>? topik,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (authorId != null) result.authorId = authorId;
    if (posts != null) result.posts.addAll(posts);
    if (channelImage != null) result.channelImage = channelImage;
    if (members != null) result.members.addAll(members);
    if (image != null) result.image = image;
    if (tags != null) result.tags.addAll(tags);
    if (topik != null) result.topik.addAll(topik);
    return result;
  }

  ChannelDto._();

  factory ChannelDto.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ChannelDto.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, ChannelDto_OptionalChat> _ChannelDto_OptionalChatByTag = {
    5 : ChannelDto_OptionalChat.channelImage,
    0 : ChannelDto_OptionalChat.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChannelDto', createEmptyInstance: create)
    ..oo(0, [5])
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'authorId', $pb.PbFieldType.O3)
    ..pc<PostDto>(4, _omitFieldNames ? '' : 'posts', $pb.PbFieldType.PM, subBuilder: PostDto.create)
    ..aOS(5, _omitFieldNames ? '' : 'channelImage')
    ..pc<MemberDto>(6, _omitFieldNames ? '' : 'members', $pb.PbFieldType.PM, subBuilder: MemberDto.create)
    ..a<$core.List<$core.int>>(7, _omitFieldNames ? '' : 'image', $pb.PbFieldType.OY)
    ..pPS(8, _omitFieldNames ? '' : 'tags')
    ..pPS(9, _omitFieldNames ? '' : 'topik')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChannelDto clone() => ChannelDto()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChannelDto copyWith(void Function(ChannelDto) updates) => super.copyWith((message) => updates(message as ChannelDto)) as ChannelDto;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChannelDto create() => ChannelDto._();
  @$core.override
  ChannelDto createEmptyInstance() => create();
  static $pb.PbList<ChannelDto> createRepeated() => $pb.PbList<ChannelDto>();
  @$core.pragma('dart2js:noInline')
  static ChannelDto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChannelDto>(create);
  static ChannelDto? _defaultInstance;

  ChannelDto_OptionalChat whichOptionalChat() => _ChannelDto_OptionalChatByTag[$_whichOneof(0)]!;
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
  $core.int get authorId => $_getIZ(2);
  @$pb.TagNumber(3)
  set authorId($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAuthorId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAuthorId() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<PostDto> get posts => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get channelImage => $_getSZ(4);
  @$pb.TagNumber(5)
  set channelImage($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasChannelImage() => $_has(4);
  @$pb.TagNumber(5)
  void clearChannelImage() => $_clearField(5);

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

  @$pb.TagNumber(8)
  $pb.PbList<$core.String> get tags => $_getList(7);

  @$pb.TagNumber(9)
  $pb.PbList<$core.String> get topik => $_getList(8);
}

enum PostDto_OptionalMessage {
  datePost, 
  notSet
}

class PostDto extends $pb.GeneratedMessage {
  factory PostDto({
    $core.int? id,
    $core.String? body,
    $core.int? authorId,
    $core.int? channelId,
    $core.String? authorName,
    $core.Iterable<$core.String>? likes,
    $core.Iterable<$core.List<$core.int>>? data,
    $core.Iterable<$core.String>? content,
    $core.int? stickerContent,
    $core.String? datePost,
    $core.Iterable<CommentDto>? comments,
    $core.Iterable<$core.String>? tags,
    $core.String? topik,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (body != null) result.body = body;
    if (authorId != null) result.authorId = authorId;
    if (channelId != null) result.channelId = channelId;
    if (authorName != null) result.authorName = authorName;
    if (likes != null) result.likes.addAll(likes);
    if (data != null) result.data.addAll(data);
    if (content != null) result.content.addAll(content);
    if (stickerContent != null) result.stickerContent = stickerContent;
    if (datePost != null) result.datePost = datePost;
    if (comments != null) result.comments.addAll(comments);
    if (tags != null) result.tags.addAll(tags);
    if (topik != null) result.topik = topik;
    return result;
  }

  PostDto._();

  factory PostDto.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory PostDto.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, PostDto_OptionalMessage> _PostDto_OptionalMessageByTag = {
    10 : PostDto_OptionalMessage.datePost,
    0 : PostDto_OptionalMessage.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PostDto', createEmptyInstance: create)
    ..oo(0, [10])
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'body')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'authorId', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'channelId', $pb.PbFieldType.O3)
    ..aOS(5, _omitFieldNames ? '' : 'authorName')
    ..pPS(6, _omitFieldNames ? '' : 'likes')
    ..p<$core.List<$core.int>>(7, _omitFieldNames ? '' : 'data', $pb.PbFieldType.PY)
    ..pPS(8, _omitFieldNames ? '' : 'content')
    ..a<$core.int>(9, _omitFieldNames ? '' : 'stickerContent', $pb.PbFieldType.O3)
    ..aOS(10, _omitFieldNames ? '' : 'datePost')
    ..pc<CommentDto>(11, _omitFieldNames ? '' : 'comments', $pb.PbFieldType.PM, subBuilder: CommentDto.create)
    ..pPS(12, _omitFieldNames ? '' : 'tags')
    ..aOS(13, _omitFieldNames ? '' : 'topik')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PostDto clone() => PostDto()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PostDto copyWith(void Function(PostDto) updates) => super.copyWith((message) => updates(message as PostDto)) as PostDto;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PostDto create() => PostDto._();
  @$core.override
  PostDto createEmptyInstance() => create();
  static $pb.PbList<PostDto> createRepeated() => $pb.PbList<PostDto>();
  @$core.pragma('dart2js:noInline')
  static PostDto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PostDto>(create);
  static PostDto? _defaultInstance;

  PostDto_OptionalMessage whichOptionalMessage() => _PostDto_OptionalMessageByTag[$_whichOneof(0)]!;
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
  $core.int get channelId => $_getIZ(3);
  @$pb.TagNumber(4)
  set channelId($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasChannelId() => $_has(3);
  @$pb.TagNumber(4)
  void clearChannelId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get authorName => $_getSZ(4);
  @$pb.TagNumber(5)
  set authorName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAuthorName() => $_has(4);
  @$pb.TagNumber(5)
  void clearAuthorName() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<$core.String> get likes => $_getList(5);

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
  $core.String get datePost => $_getSZ(9);
  @$pb.TagNumber(10)
  set datePost($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasDatePost() => $_has(9);
  @$pb.TagNumber(10)
  void clearDatePost() => $_clearField(10);

  @$pb.TagNumber(11)
  $pb.PbList<CommentDto> get comments => $_getList(10);

  @$pb.TagNumber(12)
  $pb.PbList<$core.String> get tags => $_getList(11);

  @$pb.TagNumber(13)
  $core.String get topik => $_getSZ(12);
  @$pb.TagNumber(13)
  set topik($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasTopik() => $_has(12);
  @$pb.TagNumber(13)
  void clearTopik() => $_clearField(13);
}

class CommentDto extends $pb.GeneratedMessage {
  factory CommentDto({
    $core.int? id,
    $core.String? body,
    $core.int? authorId,
    $core.int? postId,
    $core.String? authorName,
    $core.Iterable<$core.List<$core.int>>? data,
    $core.Iterable<$core.String>? content,
    $core.int? stickerContent,
    $core.Iterable<$core.String>? likes,
    $core.String? dateComment,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (body != null) result.body = body;
    if (authorId != null) result.authorId = authorId;
    if (postId != null) result.postId = postId;
    if (authorName != null) result.authorName = authorName;
    if (data != null) result.data.addAll(data);
    if (content != null) result.content.addAll(content);
    if (stickerContent != null) result.stickerContent = stickerContent;
    if (likes != null) result.likes.addAll(likes);
    if (dateComment != null) result.dateComment = dateComment;
    return result;
  }

  CommentDto._();

  factory CommentDto.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory CommentDto.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CommentDto', createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'body')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'authorId', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'postId', $pb.PbFieldType.O3)
    ..aOS(5, _omitFieldNames ? '' : 'authorName')
    ..p<$core.List<$core.int>>(6, _omitFieldNames ? '' : 'data', $pb.PbFieldType.PY)
    ..pPS(7, _omitFieldNames ? '' : 'content')
    ..a<$core.int>(8, _omitFieldNames ? '' : 'stickerContent', $pb.PbFieldType.O3)
    ..pPS(9, _omitFieldNames ? '' : 'likes')
    ..aOS(10, _omitFieldNames ? '' : 'dateComment')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommentDto clone() => CommentDto()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommentDto copyWith(void Function(CommentDto) updates) => super.copyWith((message) => updates(message as CommentDto)) as CommentDto;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CommentDto create() => CommentDto._();
  @$core.override
  CommentDto createEmptyInstance() => create();
  static $pb.PbList<CommentDto> createRepeated() => $pb.PbList<CommentDto>();
  @$core.pragma('dart2js:noInline')
  static CommentDto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CommentDto>(create);
  static CommentDto? _defaultInstance;

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
  $core.int get postId => $_getIZ(3);
  @$pb.TagNumber(4)
  set postId($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPostId() => $_has(3);
  @$pb.TagNumber(4)
  void clearPostId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get authorName => $_getSZ(4);
  @$pb.TagNumber(5)
  set authorName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAuthorName() => $_has(4);
  @$pb.TagNumber(5)
  void clearAuthorName() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<$core.List<$core.int>> get data => $_getList(5);

  @$pb.TagNumber(7)
  $pb.PbList<$core.String> get content => $_getList(6);

  @$pb.TagNumber(8)
  $core.int get stickerContent => $_getIZ(7);
  @$pb.TagNumber(8)
  set stickerContent($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasStickerContent() => $_has(7);
  @$pb.TagNumber(8)
  void clearStickerContent() => $_clearField(8);

  @$pb.TagNumber(9)
  $pb.PbList<$core.String> get likes => $_getList(8);

  @$pb.TagNumber(10)
  $core.String get dateComment => $_getSZ(9);
  @$pb.TagNumber(10)
  set dateComment($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasDateComment() => $_has(9);
  @$pb.TagNumber(10)
  void clearDateComment() => $_clearField(10);
}

class ResponseDto extends $pb.GeneratedMessage {
  factory ResponseDto({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  ResponseDto._();

  factory ResponseDto.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ResponseDto.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ResponseDto', createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
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
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}


const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
