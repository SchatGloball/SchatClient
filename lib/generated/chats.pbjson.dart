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

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

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
    {'1': 'chat', '3': 2, '4': 1, '5': 11, '6': '.ChatDto', '10': 'chat'},
  ],
};

/// Descriptor for `SearchRequestDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchRequestDtoDescriptor = $convert.base64Decode(
    'ChBTZWFyY2hSZXF1ZXN0RHRvEiQKDXNlYXJjaFJlcXVlc3QYASABKAlSDXNlYXJjaFJlcXVlc3'
    'QSHAoEY2hhdBgCIAEoCzIILkNoYXREdG9SBGNoYXQ=');

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

@$core.Deprecated('Use listChatsDtoDescriptor instead')
const ListChatsDto$json = {
  '1': 'ListChatsDto',
  '2': [
    {'1': 'chats', '3': 1, '4': 3, '5': 11, '6': '.ChatDto', '10': 'chats'},
  ],
};

/// Descriptor for `ListChatsDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listChatsDtoDescriptor = $convert.base64Decode(
    'CgxMaXN0Q2hhdHNEdG8SHgoFY2hhdHMYASADKAsyCC5DaGF0RHRvUgVjaGF0cw==');

@$core.Deprecated('Use chatDtoDescriptor instead')
const ChatDto$json = {
  '1': 'ChatDto',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'author_id', '3': 3, '4': 1, '5': 9, '10': 'authorId'},
    {'1': 'members', '3': 6, '4': 3, '5': 11, '6': '.MemberDto', '10': 'members'},
    {'1': 'messages', '3': 4, '4': 3, '5': 11, '6': '.MessageDto', '10': 'messages'},
    {'1': 'image', '3': 7, '4': 1, '5': 12, '10': 'image'},
    {'1': 'chat_image', '3': 5, '4': 1, '5': 9, '9': 0, '10': 'chatImage'},
  ],
  '8': [
    {'1': 'optional_chat'},
  ],
};

/// Descriptor for `ChatDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatDtoDescriptor = $convert.base64Decode(
    'CgdDaGF0RHRvEg4KAmlkGAEgASgFUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEhsKCWF1dGhvcl'
    '9pZBgDIAEoCVIIYXV0aG9ySWQSJAoHbWVtYmVycxgGIAMoCzIKLk1lbWJlckR0b1IHbWVtYmVy'
    'cxInCghtZXNzYWdlcxgEIAMoCzILLk1lc3NhZ2VEdG9SCG1lc3NhZ2VzEhQKBWltYWdlGAcgAS'
    'gMUgVpbWFnZRIfCgpjaGF0X2ltYWdlGAUgASgJSABSCWNoYXRJbWFnZUIPCg1vcHRpb25hbF9j'
    'aGF0');

@$core.Deprecated('Use messageDtoDescriptor instead')
const MessageDto$json = {
  '1': 'MessageDto',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'body', '3': 2, '4': 1, '5': 9, '10': 'body'},
    {'1': 'author_id', '3': 3, '4': 1, '5': 5, '10': 'authorId'},
    {'1': 'chat_id', '3': 4, '4': 1, '5': 5, '10': 'chatId'},
    {'1': 'author_name', '3': 5, '4': 1, '5': 9, '10': 'authorName'},
    {'1': 'delivered', '3': 6, '4': 1, '5': 8, '10': 'delivered'},
    {'1': 'data', '3': 7, '4': 3, '5': 12, '10': 'data'},
    {'1': 'content', '3': 8, '4': 3, '5': 9, '10': 'content'},
    {'1': 'sticker_content', '3': 9, '4': 1, '5': 5, '10': 'stickerContent'},
    {'1': 'reaction', '3': 11, '4': 3, '5': 11, '6': '.ReactionMessageDto', '10': 'reaction'},
    {'1': 'forwarded', '3': 12, '4': 1, '5': 8, '10': 'forwarded'},
    {'1': 'originalAuthor', '3': 13, '4': 1, '5': 9, '10': 'originalAuthor'},
    {'1': 'originalDate', '3': 14, '4': 1, '5': 9, '10': 'originalDate'},
    {'1': 'date_message', '3': 10, '4': 1, '5': 9, '9': 0, '10': 'dateMessage'},
  ],
  '8': [
    {'1': 'optional_message'},
  ],
};

/// Descriptor for `MessageDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messageDtoDescriptor = $convert.base64Decode(
    'CgpNZXNzYWdlRHRvEg4KAmlkGAEgASgFUgJpZBISCgRib2R5GAIgASgJUgRib2R5EhsKCWF1dG'
    'hvcl9pZBgDIAEoBVIIYXV0aG9ySWQSFwoHY2hhdF9pZBgEIAEoBVIGY2hhdElkEh8KC2F1dGhv'
    'cl9uYW1lGAUgASgJUgphdXRob3JOYW1lEhwKCWRlbGl2ZXJlZBgGIAEoCFIJZGVsaXZlcmVkEh'
    'IKBGRhdGEYByADKAxSBGRhdGESGAoHY29udGVudBgIIAMoCVIHY29udGVudBInCg9zdGlja2Vy'
    'X2NvbnRlbnQYCSABKAVSDnN0aWNrZXJDb250ZW50Ei8KCHJlYWN0aW9uGAsgAygLMhMuUmVhY3'
    'Rpb25NZXNzYWdlRHRvUghyZWFjdGlvbhIcCglmb3J3YXJkZWQYDCABKAhSCWZvcndhcmRlZBIm'
    'Cg5vcmlnaW5hbEF1dGhvchgNIAEoCVIOb3JpZ2luYWxBdXRob3ISIgoMb3JpZ2luYWxEYXRlGA'
    '4gASgJUgxvcmlnaW5hbERhdGUSIwoMZGF0ZV9tZXNzYWdlGAogASgJSABSC2RhdGVNZXNzYWdl'
    'QhIKEG9wdGlvbmFsX21lc3NhZ2U=');

@$core.Deprecated('Use reactionMessageDtoDescriptor instead')
const ReactionMessageDto$json = {
  '1': 'ReactionMessageDto',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'body', '3': 2, '4': 1, '5': 9, '10': 'body'},
    {'1': 'author_id', '3': 3, '4': 1, '5': 5, '10': 'authorId'},
    {'1': 'author_name', '3': 4, '4': 1, '5': 9, '10': 'authorName'},
    {'1': 'messageId', '3': 5, '4': 1, '5': 5, '10': 'messageId'},
    {'1': 'sticker_content', '3': 6, '4': 1, '5': 5, '10': 'stickerContent'},
    {'1': 'dateReaction', '3': 7, '4': 1, '5': 9, '9': 0, '10': 'dateReaction'},
  ],
  '8': [
    {'1': 'optional_message'},
  ],
};

/// Descriptor for `ReactionMessageDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reactionMessageDtoDescriptor = $convert.base64Decode(
    'ChJSZWFjdGlvbk1lc3NhZ2VEdG8SDgoCaWQYASABKAVSAmlkEhIKBGJvZHkYAiABKAlSBGJvZH'
    'kSGwoJYXV0aG9yX2lkGAMgASgFUghhdXRob3JJZBIfCgthdXRob3JfbmFtZRgEIAEoCVIKYXV0'
    'aG9yTmFtZRIcCgltZXNzYWdlSWQYBSABKAVSCW1lc3NhZ2VJZBInCg9zdGlja2VyX2NvbnRlbn'
    'QYBiABKAVSDnN0aWNrZXJDb250ZW50EiQKDGRhdGVSZWFjdGlvbhgHIAEoCUgAUgxkYXRlUmVh'
    'Y3Rpb25CEgoQb3B0aW9uYWxfbWVzc2FnZQ==');

@$core.Deprecated('Use responseDtoDescriptor instead')
const ResponseDto$json = {
  '1': 'ResponseDto',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ResponseDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List responseDtoDescriptor = $convert.base64Decode(
    'CgtSZXNwb25zZUR0bxIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use updateDTODescriptor instead')
const UpdateDTO$json = {
  '1': 'UpdateDTO',
  '2': [
    {'1': 'chat', '3': 1, '4': 1, '5': 11, '6': '.ChatDto', '10': 'chat'},
  ],
};

/// Descriptor for `UpdateDTO`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateDTODescriptor = $convert.base64Decode(
    'CglVcGRhdGVEVE8SHAoEY2hhdBgBIAEoCzIILkNoYXREdG9SBGNoYXQ=');

@$core.Deprecated('Use updateAppReqDescriptor instead')
const UpdateAppReq$json = {
  '1': 'UpdateAppReq',
  '2': [
    {'1': 'version', '3': 1, '4': 1, '5': 5, '10': 'version'},
    {'1': 'platform', '3': 2, '4': 1, '5': 9, '10': 'platform'},
  ],
};

/// Descriptor for `UpdateAppReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAppReqDescriptor = $convert.base64Decode(
    'CgxVcGRhdGVBcHBSZXESGAoHdmVyc2lvbhgBIAEoBVIHdmVyc2lvbhIaCghwbGF0Zm9ybRgCIA'
    'EoCVIIcGxhdGZvcm0=');

@$core.Deprecated('Use updateAppResDescriptor instead')
const UpdateAppRes$json = {
  '1': 'UpdateAppRes',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'data', '3': 2, '4': 1, '5': 12, '10': 'data'},
  ],
};

/// Descriptor for `UpdateAppRes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAppResDescriptor = $convert.base64Decode(
    'CgxVcGRhdGVBcHBSZXMSEgoEbmFtZRgBIAEoCVIEbmFtZRISCgRkYXRhGAIgASgMUgRkYXRh');

