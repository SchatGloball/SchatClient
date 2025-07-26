//
//  Generated code. Do not modify.
//  source: call.proto
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

enum RequestDto_OptionalData {
  callData, 
  notSet
}

class RequestDto extends $pb.GeneratedMessage {
  factory RequestDto({
    $core.String? room,
    CallDto? callData,
  }) {
    final result = create();
    if (room != null) result.room = room;
    if (callData != null) result.callData = callData;
    return result;
  }

  RequestDto._();

  factory RequestDto.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory RequestDto.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, RequestDto_OptionalData> _RequestDto_OptionalDataByTag = {
    2 : RequestDto_OptionalData.callData,
    0 : RequestDto_OptionalData.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RequestDto', createEmptyInstance: create)
    ..oo(0, [2])
    ..aOS(1, _omitFieldNames ? '' : 'room')
    ..aOM<CallDto>(2, _omitFieldNames ? '' : 'callData', protoName: 'callData', subBuilder: CallDto.create)
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

  RequestDto_OptionalData whichOptionalData() => _RequestDto_OptionalDataByTag[$_whichOneof(0)]!;
  void clearOptionalData() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get room => $_getSZ(0);
  @$pb.TagNumber(1)
  set room($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRoom() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoom() => $_clearField(1);

  @$pb.TagNumber(2)
  CallDto get callData => $_getN(1);
  @$pb.TagNumber(2)
  set callData(CallDto value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasCallData() => $_has(1);
  @$pb.TagNumber(2)
  void clearCallData() => $_clearField(2);
  @$pb.TagNumber(2)
  CallDto ensureCallData() => $_ensure(1);
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

enum UpdateDTO_OptionalData {
  callData, 
  notSet
}

class UpdateDTO extends $pb.GeneratedMessage {
  factory UpdateDTO({
    $core.Iterable<UserDto>? users,
    $core.bool? video,
    $core.bool? exitCall,
    $core.String? room,
    CallDto? callData,
  }) {
    final result = create();
    if (users != null) result.users.addAll(users);
    if (video != null) result.video = video;
    if (exitCall != null) result.exitCall = exitCall;
    if (room != null) result.room = room;
    if (callData != null) result.callData = callData;
    return result;
  }

  UpdateDTO._();

  factory UpdateDTO.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory UpdateDTO.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, UpdateDTO_OptionalData> _UpdateDTO_OptionalDataByTag = {
    5 : UpdateDTO_OptionalData.callData,
    0 : UpdateDTO_OptionalData.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateDTO', createEmptyInstance: create)
    ..oo(0, [5])
    ..pc<UserDto>(1, _omitFieldNames ? '' : 'users', $pb.PbFieldType.PM, subBuilder: UserDto.create)
    ..aOB(2, _omitFieldNames ? '' : 'video')
    ..aOB(3, _omitFieldNames ? '' : 'exitCall', protoName: 'exitCall')
    ..aOS(4, _omitFieldNames ? '' : 'room')
    ..aOM<CallDto>(5, _omitFieldNames ? '' : 'callData', protoName: 'callData', subBuilder: CallDto.create)
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

  UpdateDTO_OptionalData whichOptionalData() => _UpdateDTO_OptionalDataByTag[$_whichOneof(0)]!;
  void clearOptionalData() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $pb.PbList<UserDto> get users => $_getList(0);

  @$pb.TagNumber(2)
  $core.bool get video => $_getBF(1);
  @$pb.TagNumber(2)
  set video($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasVideo() => $_has(1);
  @$pb.TagNumber(2)
  void clearVideo() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get exitCall => $_getBF(2);
  @$pb.TagNumber(3)
  set exitCall($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasExitCall() => $_has(2);
  @$pb.TagNumber(3)
  void clearExitCall() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get room => $_getSZ(3);
  @$pb.TagNumber(4)
  set room($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRoom() => $_has(3);
  @$pb.TagNumber(4)
  void clearRoom() => $_clearField(4);

  @$pb.TagNumber(5)
  CallDto get callData => $_getN(4);
  @$pb.TagNumber(5)
  set callData(CallDto value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasCallData() => $_has(4);
  @$pb.TagNumber(5)
  void clearCallData() => $_clearField(5);
  @$pb.TagNumber(5)
  CallDto ensureCallData() => $_ensure(4);
}

class UserDto extends $pb.GeneratedMessage {
  factory UserDto({
    $core.String? username,
    $core.String? imageAvatar,
  }) {
    final result = create();
    if (username != null) result.username = username;
    if (imageAvatar != null) result.imageAvatar = imageAvatar;
    return result;
  }

  UserDto._();

  factory UserDto.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory UserDto.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UserDto', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'username')
    ..aOS(2, _omitFieldNames ? '' : 'imageAvatar')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserDto clone() => UserDto()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserDto copyWith(void Function(UserDto) updates) => super.copyWith((message) => updates(message as UserDto)) as UserDto;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserDto create() => UserDto._();
  @$core.override
  UserDto createEmptyInstance() => create();
  static $pb.PbList<UserDto> createRepeated() => $pb.PbList<UserDto>();
  @$core.pragma('dart2js:noInline')
  static UserDto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserDto>(create);
  static UserDto? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get username => $_getSZ(0);
  @$pb.TagNumber(1)
  set username($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUsername() => $_has(0);
  @$pb.TagNumber(1)
  void clearUsername() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get imageAvatar => $_getSZ(1);
  @$pb.TagNumber(2)
  set imageAvatar($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasImageAvatar() => $_has(1);
  @$pb.TagNumber(2)
  void clearImageAvatar() => $_clearField(2);
}

class CallDto extends $pb.GeneratedMessage {
  factory CallDto({
    $core.List<$core.int>? soundData,
    $core.List<$core.int>? videoData,
  }) {
    final result = create();
    if (soundData != null) result.soundData = soundData;
    if (videoData != null) result.videoData = videoData;
    return result;
  }

  CallDto._();

  factory CallDto.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory CallDto.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CallDto', createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'soundData', $pb.PbFieldType.OY, protoName: 'soundData')
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'videoData', $pb.PbFieldType.OY, protoName: 'videoData')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CallDto clone() => CallDto()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CallDto copyWith(void Function(CallDto) updates) => super.copyWith((message) => updates(message as CallDto)) as CallDto;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CallDto create() => CallDto._();
  @$core.override
  CallDto createEmptyInstance() => create();
  static $pb.PbList<CallDto> createRepeated() => $pb.PbList<CallDto>();
  @$core.pragma('dart2js:noInline')
  static CallDto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CallDto>(create);
  static CallDto? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get soundData => $_getN(0);
  @$pb.TagNumber(1)
  set soundData($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSoundData() => $_has(0);
  @$pb.TagNumber(1)
  void clearSoundData() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get videoData => $_getN(1);
  @$pb.TagNumber(2)
  set videoData($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasVideoData() => $_has(1);
  @$pb.TagNumber(2)
  void clearVideoData() => $_clearField(2);
}


const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
