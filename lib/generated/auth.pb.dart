// This is a generated file - do not edit.
//
// Generated from auth.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class ListUsersDto extends $pb.GeneratedMessage {
  factory ListUsersDto({
    $core.Iterable<UserDto>? users,
  }) {
    final result = create();
    if (users != null) result.users.addAll(users);
    return result;
  }

  ListUsersDto._();

  factory ListUsersDto.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListUsersDto.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListUsersDto',
      createEmptyInstance: create)
    ..pPM<UserDto>(1, _omitFieldNames ? '' : 'users',
        subBuilder: UserDto.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUsersDto clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUsersDto copyWith(void Function(ListUsersDto) updates) =>
      super.copyWith((message) => updates(message as ListUsersDto))
          as ListUsersDto;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListUsersDto create() => ListUsersDto._();
  @$core.override
  ListUsersDto createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListUsersDto getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListUsersDto>(create);
  static ListUsersDto? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<UserDto> get users => $_getList(0);
}

class FindDto extends $pb.GeneratedMessage {
  factory FindDto({
    $core.String? key,
  }) {
    final result = create();
    if (key != null) result.key = key;
    return result;
  }

  FindDto._();

  factory FindDto.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FindDto.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FindDto',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'key')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FindDto clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FindDto copyWith(void Function(FindDto) updates) =>
      super.copyWith((message) => updates(message as FindDto)) as FindDto;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FindDto create() => FindDto._();
  @$core.override
  FindDto createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FindDto getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FindDto>(create);
  static FindDto? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => $_clearField(1);
}

enum UserDto_OptionalPassword { password, imageAvatar, notSet }

class UserDto extends $pb.GeneratedMessage {
  factory UserDto({
    $core.int? id,
    $core.String? username,
    $core.String? email,
    $core.bool? isBot,
    $core.String? password,
    $core.String? imageAvatar,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (username != null) result.username = username;
    if (email != null) result.email = email;
    if (isBot != null) result.isBot = isBot;
    if (password != null) result.password = password;
    if (imageAvatar != null) result.imageAvatar = imageAvatar;
    return result;
  }

  UserDto._();

  factory UserDto.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserDto.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, UserDto_OptionalPassword>
      _UserDto_OptionalPasswordByTag = {
    5: UserDto_OptionalPassword.password,
    6: UserDto_OptionalPassword.imageAvatar,
    0: UserDto_OptionalPassword.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserDto',
      createEmptyInstance: create)
    ..oo(0, [5, 6])
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'username')
    ..aOS(3, _omitFieldNames ? '' : 'email')
    ..aOB(4, _omitFieldNames ? '' : 'isBot')
    ..aOS(5, _omitFieldNames ? '' : 'password')
    ..aOS(6, _omitFieldNames ? '' : 'imageAvatar')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserDto clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserDto copyWith(void Function(UserDto) updates) =>
      super.copyWith((message) => updates(message as UserDto)) as UserDto;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserDto create() => UserDto._();
  @$core.override
  UserDto createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UserDto getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserDto>(create);
  static UserDto? _defaultInstance;

  @$pb.TagNumber(5)
  @$pb.TagNumber(6)
  UserDto_OptionalPassword whichOptionalPassword() =>
      _UserDto_OptionalPasswordByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(5)
  @$pb.TagNumber(6)
  void clearOptionalPassword() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get username => $_getSZ(1);
  @$pb.TagNumber(2)
  set username($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUsername() => $_has(1);
  @$pb.TagNumber(2)
  void clearUsername() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get email => $_getSZ(2);
  @$pb.TagNumber(3)
  set email($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEmail() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmail() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get isBot => $_getBF(3);
  @$pb.TagNumber(4)
  set isBot($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasIsBot() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsBot() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get password => $_getSZ(4);
  @$pb.TagNumber(5)
  set password($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPassword() => $_has(4);
  @$pb.TagNumber(5)
  void clearPassword() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get imageAvatar => $_getSZ(5);
  @$pb.TagNumber(6)
  set imageAvatar($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasImageAvatar() => $_has(5);
  @$pb.TagNumber(6)
  void clearImageAvatar() => $_clearField(6);
}

class TokensDto extends $pb.GeneratedMessage {
  factory TokensDto({
    $core.String? accessToken,
    $core.String? refreshToken,
  }) {
    final result = create();
    if (accessToken != null) result.accessToken = accessToken;
    if (refreshToken != null) result.refreshToken = refreshToken;
    return result;
  }

  TokensDto._();

  factory TokensDto.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TokensDto.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TokensDto',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accessToken')
    ..aOS(2, _omitFieldNames ? '' : 'refreshToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TokensDto clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TokensDto copyWith(void Function(TokensDto) updates) =>
      super.copyWith((message) => updates(message as TokensDto)) as TokensDto;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TokensDto create() => TokensDto._();
  @$core.override
  TokensDto createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TokensDto getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TokensDto>(create);
  static TokensDto? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accessToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set accessToken($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccessToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccessToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get refreshToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set refreshToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRefreshToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearRefreshToken() => $_clearField(2);
}

class RequestDto extends $pb.GeneratedMessage {
  factory RequestDto() => create();

  RequestDto._();

  factory RequestDto.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RequestDto.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RequestDto',
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestDto clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestDto copyWith(void Function(RequestDto) updates) =>
      super.copyWith((message) => updates(message as RequestDto)) as RequestDto;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestDto create() => RequestDto._();
  @$core.override
  RequestDto createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RequestDto getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RequestDto>(create);
  static RequestDto? _defaultInstance;
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

  factory ResponseDto.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ResponseDto.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ResponseDto',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResponseDto clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResponseDto copyWith(void Function(ResponseDto) updates) =>
      super.copyWith((message) => updates(message as ResponseDto))
          as ResponseDto;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResponseDto create() => ResponseDto._();
  @$core.override
  ResponseDto createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ResponseDto getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ResponseDto>(create);
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

class FileDto extends $pb.GeneratedMessage {
  factory FileDto({
    $core.List<$core.int>? data,
  }) {
    final result = create();
    if (data != null) result.data = data;
    return result;
  }

  FileDto._();

  factory FileDto.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FileDto.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FileDto',
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FileDto clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FileDto copyWith(void Function(FileDto) updates) =>
      super.copyWith((message) => updates(message as FileDto)) as FileDto;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FileDto create() => FileDto._();
  @$core.override
  FileDto createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FileDto getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FileDto>(create);
  static FileDto? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get data => $_getN(0);
  @$pb.TagNumber(1)
  set data($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => $_clearField(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
