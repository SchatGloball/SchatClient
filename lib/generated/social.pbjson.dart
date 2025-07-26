// This is a generated file - do not edit.
//
// Generated from social.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use requestPostsDtoDescriptor instead')
const RequestPostsDto$json = {
  '1': 'RequestPostsDto',
  '2': [
    {'1': 'offset', '3': 1, '4': 1, '5': 5, '10': 'offset'},
    {'1': 'channel', '3': 2, '4': 1, '5': 11, '6': '.ChannelDto', '10': 'channel'},
  ],
};

/// Descriptor for `RequestPostsDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestPostsDtoDescriptor = $convert.base64Decode(
    'Cg9SZXF1ZXN0UG9zdHNEdG8SFgoGb2Zmc2V0GAEgASgFUgZvZmZzZXQSJQoHY2hhbm5lbBgCIA'
    'EoCzILLkNoYW5uZWxEdG9SB2NoYW5uZWw=');

@$core.Deprecated('Use requestDtoDescriptor instead')
const RequestDto$json = {
  '1': 'RequestDto',
};

/// Descriptor for `RequestDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestDtoDescriptor = $convert.base64Decode(
    'CgpSZXF1ZXN0RHRv');

@$core.Deprecated('Use searchRequestDtoDescriptor instead')
const SearchRequestDto$json = {
  '1': 'SearchRequestDto',
  '2': [
    {'1': 'searchRequest', '3': 1, '4': 1, '5': 9, '10': 'searchRequest'},
  ],
};

/// Descriptor for `SearchRequestDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchRequestDtoDescriptor = $convert.base64Decode(
    'ChBTZWFyY2hSZXF1ZXN0RHRvEiQKDXNlYXJjaFJlcXVlc3QYASABKAlSDXNlYXJjaFJlcXVlc3'
    'Q=');

@$core.Deprecated('Use memberDtoDescriptor instead')
const MemberDto$json = {
  '1': 'MemberDto',
  '2': [
    {'1': 'member_username', '3': 1, '4': 1, '5': 9, '10': 'memberUsername'},
    {'1': 'member_image', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'memberImage'},
  ],
  '8': [
    {'1': 'optional_member'},
  ],
};

/// Descriptor for `MemberDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List memberDtoDescriptor = $convert.base64Decode(
    'CglNZW1iZXJEdG8SJwoPbWVtYmVyX3VzZXJuYW1lGAEgASgJUg5tZW1iZXJVc2VybmFtZRIjCg'
    'xtZW1iZXJfaW1hZ2UYAiABKAlIAFILbWVtYmVySW1hZ2VCEQoPb3B0aW9uYWxfbWVtYmVy');

@$core.Deprecated('Use listChannelsDtoDescriptor instead')
const ListChannelsDto$json = {
  '1': 'ListChannelsDto',
  '2': [
    {'1': 'channels', '3': 1, '4': 3, '5': 11, '6': '.ChannelDto', '10': 'channels'},
  ],
};

/// Descriptor for `ListChannelsDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listChannelsDtoDescriptor = $convert.base64Decode(
    'Cg9MaXN0Q2hhbm5lbHNEdG8SJwoIY2hhbm5lbHMYASADKAsyCy5DaGFubmVsRHRvUghjaGFubm'
    'Vscw==');

@$core.Deprecated('Use listPostsDtoDescriptor instead')
const ListPostsDto$json = {
  '1': 'ListPostsDto',
  '2': [
    {'1': 'posts', '3': 1, '4': 3, '5': 11, '6': '.PostDto', '10': 'posts'},
  ],
};

/// Descriptor for `ListPostsDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPostsDtoDescriptor = $convert.base64Decode(
    'CgxMaXN0UG9zdHNEdG8SHgoFcG9zdHMYASADKAsyCC5Qb3N0RHRvUgVwb3N0cw==');

@$core.Deprecated('Use channelDtoDescriptor instead')
const ChannelDto$json = {
  '1': 'ChannelDto',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'author_id', '3': 3, '4': 1, '5': 5, '10': 'authorId'},
    {'1': 'members', '3': 6, '4': 3, '5': 11, '6': '.MemberDto', '10': 'members'},
    {'1': 'posts', '3': 4, '4': 3, '5': 11, '6': '.PostDto', '10': 'posts'},
    {'1': 'image', '3': 7, '4': 1, '5': 12, '10': 'image'},
    {'1': 'tags', '3': 8, '4': 3, '5': 9, '10': 'tags'},
    {'1': 'topik', '3': 9, '4': 3, '5': 9, '10': 'topik'},
    {'1': 'channel_image', '3': 5, '4': 1, '5': 9, '9': 0, '10': 'channelImage'},
  ],
  '8': [
    {'1': 'optional_chat'},
  ],
};

/// Descriptor for `ChannelDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelDtoDescriptor = $convert.base64Decode(
    'CgpDaGFubmVsRHRvEg4KAmlkGAEgASgFUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEhsKCWF1dG'
    'hvcl9pZBgDIAEoBVIIYXV0aG9ySWQSJAoHbWVtYmVycxgGIAMoCzIKLk1lbWJlckR0b1IHbWVt'
    'YmVycxIeCgVwb3N0cxgEIAMoCzIILlBvc3REdG9SBXBvc3RzEhQKBWltYWdlGAcgASgMUgVpbW'
    'FnZRISCgR0YWdzGAggAygJUgR0YWdzEhQKBXRvcGlrGAkgAygJUgV0b3BpaxIlCg1jaGFubmVs'
    'X2ltYWdlGAUgASgJSABSDGNoYW5uZWxJbWFnZUIPCg1vcHRpb25hbF9jaGF0');

@$core.Deprecated('Use postDtoDescriptor instead')
const PostDto$json = {
  '1': 'PostDto',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'body', '3': 2, '4': 1, '5': 9, '10': 'body'},
    {'1': 'author_id', '3': 3, '4': 1, '5': 5, '10': 'authorId'},
    {'1': 'channel_id', '3': 4, '4': 1, '5': 5, '10': 'channelId'},
    {'1': 'author_name', '3': 5, '4': 1, '5': 9, '10': 'authorName'},
    {'1': 'likes', '3': 6, '4': 3, '5': 9, '10': 'likes'},
    {'1': 'data', '3': 7, '4': 3, '5': 12, '10': 'data'},
    {'1': 'content', '3': 8, '4': 3, '5': 9, '10': 'content'},
    {'1': 'sticker_content', '3': 9, '4': 1, '5': 5, '10': 'stickerContent'},
    {'1': 'comments', '3': 11, '4': 3, '5': 11, '6': '.CommentDto', '10': 'comments'},
    {'1': 'tags', '3': 12, '4': 3, '5': 9, '10': 'tags'},
    {'1': 'topik', '3': 13, '4': 1, '5': 9, '10': 'topik'},
    {'1': 'date_post', '3': 10, '4': 1, '5': 9, '9': 0, '10': 'datePost'},
  ],
  '8': [
    {'1': 'optional_message'},
  ],
};

/// Descriptor for `PostDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List postDtoDescriptor = $convert.base64Decode(
    'CgdQb3N0RHRvEg4KAmlkGAEgASgFUgJpZBISCgRib2R5GAIgASgJUgRib2R5EhsKCWF1dGhvcl'
    '9pZBgDIAEoBVIIYXV0aG9ySWQSHQoKY2hhbm5lbF9pZBgEIAEoBVIJY2hhbm5lbElkEh8KC2F1'
    'dGhvcl9uYW1lGAUgASgJUgphdXRob3JOYW1lEhQKBWxpa2VzGAYgAygJUgVsaWtlcxISCgRkYX'
    'RhGAcgAygMUgRkYXRhEhgKB2NvbnRlbnQYCCADKAlSB2NvbnRlbnQSJwoPc3RpY2tlcl9jb250'
    'ZW50GAkgASgFUg5zdGlja2VyQ29udGVudBInCghjb21tZW50cxgLIAMoCzILLkNvbW1lbnREdG'
    '9SCGNvbW1lbnRzEhIKBHRhZ3MYDCADKAlSBHRhZ3MSFAoFdG9waWsYDSABKAlSBXRvcGlrEh0K'
    'CWRhdGVfcG9zdBgKIAEoCUgAUghkYXRlUG9zdEISChBvcHRpb25hbF9tZXNzYWdl');

@$core.Deprecated('Use commentDtoDescriptor instead')
const CommentDto$json = {
  '1': 'CommentDto',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'body', '3': 2, '4': 1, '5': 9, '10': 'body'},
    {'1': 'author_id', '3': 3, '4': 1, '5': 5, '10': 'authorId'},
    {'1': 'post_id', '3': 4, '4': 1, '5': 5, '10': 'postId'},
    {'1': 'author_name', '3': 5, '4': 1, '5': 9, '10': 'authorName'},
    {'1': 'data', '3': 6, '4': 3, '5': 12, '10': 'data'},
    {'1': 'content', '3': 7, '4': 3, '5': 9, '10': 'content'},
    {'1': 'sticker_content', '3': 8, '4': 1, '5': 5, '10': 'stickerContent'},
    {'1': 'likes', '3': 9, '4': 3, '5': 9, '10': 'likes'},
    {'1': 'date_comment', '3': 10, '4': 1, '5': 9, '10': 'dateComment'},
  ],
};

/// Descriptor for `CommentDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commentDtoDescriptor = $convert.base64Decode(
    'CgpDb21tZW50RHRvEg4KAmlkGAEgASgFUgJpZBISCgRib2R5GAIgASgJUgRib2R5EhsKCWF1dG'
    'hvcl9pZBgDIAEoBVIIYXV0aG9ySWQSFwoHcG9zdF9pZBgEIAEoBVIGcG9zdElkEh8KC2F1dGhv'
    'cl9uYW1lGAUgASgJUgphdXRob3JOYW1lEhIKBGRhdGEYBiADKAxSBGRhdGESGAoHY29udGVudB'
    'gHIAMoCVIHY29udGVudBInCg9zdGlja2VyX2NvbnRlbnQYCCABKAVSDnN0aWNrZXJDb250ZW50'
    'EhQKBWxpa2VzGAkgAygJUgVsaWtlcxIhCgxkYXRlX2NvbW1lbnQYCiABKAlSC2RhdGVDb21tZW'
    '50');

@$core.Deprecated('Use responseDtoDescriptor instead')
const ResponseDto$json = {
  '1': 'ResponseDto',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ResponseDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List responseDtoDescriptor = $convert.base64Decode(
    'CgtSZXNwb25zZUR0bxIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKA'
    'lSB21lc3NhZ2U=');

