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

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use requestDtoDescriptor instead')
const RequestDto$json = {
  '1': 'RequestDto',
  '2': [
    {'1': 'room', '3': 1, '4': 1, '5': 9, '10': 'room'},
    {'1': 'callData', '3': 2, '4': 1, '5': 11, '6': '.CallDto', '9': 0, '10': 'callData'},
  ],
  '8': [
    {'1': 'optionalData'},
  ],
};

/// Descriptor for `RequestDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestDtoDescriptor = $convert.base64Decode(
    'CgpSZXF1ZXN0RHRvEhIKBHJvb20YASABKAlSBHJvb20SJgoIY2FsbERhdGEYAiABKAsyCC5DYW'
    'xsRHRvSABSCGNhbGxEYXRhQg4KDG9wdGlvbmFsRGF0YQ==');

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
    {'1': 'users', '3': 1, '4': 3, '5': 11, '6': '.UserDto', '10': 'users'},
    {'1': 'video', '3': 2, '4': 1, '5': 8, '10': 'video'},
    {'1': 'exitCall', '3': 3, '4': 1, '5': 8, '10': 'exitCall'},
    {'1': 'room', '3': 4, '4': 1, '5': 9, '10': 'room'},
    {'1': 'callData', '3': 5, '4': 1, '5': 11, '6': '.CallDto', '9': 0, '10': 'callData'},
  ],
  '8': [
    {'1': 'optionalData'},
  ],
};

/// Descriptor for `UpdateDTO`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateDTODescriptor = $convert.base64Decode(
    'CglVcGRhdGVEVE8SHgoFdXNlcnMYASADKAsyCC5Vc2VyRHRvUgV1c2VycxIUCgV2aWRlbxgCIA'
    'EoCFIFdmlkZW8SGgoIZXhpdENhbGwYAyABKAhSCGV4aXRDYWxsEhIKBHJvb20YBCABKAlSBHJv'
    'b20SJgoIY2FsbERhdGEYBSABKAsyCC5DYWxsRHRvSABSCGNhbGxEYXRhQg4KDG9wdGlvbmFsRG'
    'F0YQ==');

@$core.Deprecated('Use userDtoDescriptor instead')
const UserDto$json = {
  '1': 'UserDto',
  '2': [
    {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
    {'1': 'image_avatar', '3': 2, '4': 1, '5': 9, '10': 'imageAvatar'},
  ],
};

/// Descriptor for `UserDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDtoDescriptor = $convert.base64Decode(
    'CgdVc2VyRHRvEhoKCHVzZXJuYW1lGAEgASgJUgh1c2VybmFtZRIhCgxpbWFnZV9hdmF0YXIYAi'
    'ABKAlSC2ltYWdlQXZhdGFy');

@$core.Deprecated('Use callDtoDescriptor instead')
const CallDto$json = {
  '1': 'CallDto',
  '2': [
    {'1': 'soundData', '3': 1, '4': 1, '5': 12, '10': 'soundData'},
    {'1': 'videoData', '3': 2, '4': 1, '5': 12, '10': 'videoData'},
  ],
};

/// Descriptor for `CallDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List callDtoDescriptor = $convert.base64Decode(
    'CgdDYWxsRHRvEhwKCXNvdW5kRGF0YRgBIAEoDFIJc291bmREYXRhEhwKCXZpZGVvRGF0YRgCIA'
    'EoDFIJdmlkZW9EYXRh');

