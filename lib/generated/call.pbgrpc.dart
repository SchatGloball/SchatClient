// This is a generated file - do not edit.
//
// Generated from call.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'call.pb.dart' as $0;

export 'call.pb.dart';

@$pb.GrpcServiceName('CallRpc')
class CallRpcClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  CallRpcClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.ResponseDto> createGroupCall(
    $0.UpdateDTO request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createGroupCall, request, options: options);
  }

  $grpc.ResponseStream<$0.UpdateDTO> listenCall(
    $0.RequestDto request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
        _$listenCall, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseStream<$0.UpdateDTO> enterToRoom(
    $async.Stream<$0.RequestDto> request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(_$enterToRoom, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> exitToRoom(
    $0.RequestDto request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$exitToRoom, request, options: options);
  }

  // method descriptors

  static final _$createGroupCall =
      $grpc.ClientMethod<$0.UpdateDTO, $0.ResponseDto>(
          '/CallRpc/CreateGroupCall',
          ($0.UpdateDTO value) => value.writeToBuffer(),
          $0.ResponseDto.fromBuffer);
  static final _$listenCall = $grpc.ClientMethod<$0.RequestDto, $0.UpdateDTO>(
      '/CallRpc/ListenCall',
      ($0.RequestDto value) => value.writeToBuffer(),
      $0.UpdateDTO.fromBuffer);
  static final _$enterToRoom = $grpc.ClientMethod<$0.RequestDto, $0.UpdateDTO>(
      '/CallRpc/EnterToRoom',
      ($0.RequestDto value) => value.writeToBuffer(),
      $0.UpdateDTO.fromBuffer);
  static final _$exitToRoom = $grpc.ClientMethod<$0.RequestDto, $0.ResponseDto>(
      '/CallRpc/ExitToRoom',
      ($0.RequestDto value) => value.writeToBuffer(),
      $0.ResponseDto.fromBuffer);
}

@$pb.GrpcServiceName('CallRpc')
abstract class CallRpcServiceBase extends $grpc.Service {
  $core.String get $name => 'CallRpc';

  CallRpcServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.UpdateDTO, $0.ResponseDto>(
        'CreateGroupCall',
        createGroupCall_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateDTO.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RequestDto, $0.UpdateDTO>(
        'ListenCall',
        listenCall_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.RequestDto.fromBuffer(value),
        ($0.UpdateDTO value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RequestDto, $0.UpdateDTO>(
        'EnterToRoom',
        enterToRoom,
        true,
        true,
        ($core.List<$core.int> value) => $0.RequestDto.fromBuffer(value),
        ($0.UpdateDTO value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RequestDto, $0.ResponseDto>(
        'ExitToRoom',
        exitToRoom_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RequestDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
  }

  $async.Future<$0.ResponseDto> createGroupCall_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.UpdateDTO> $request) async {
    return createGroupCall($call, await $request);
  }

  $async.Future<$0.ResponseDto> createGroupCall(
      $grpc.ServiceCall call, $0.UpdateDTO request);

  $async.Stream<$0.UpdateDTO> listenCall_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.RequestDto> $request) async* {
    yield* listenCall($call, await $request);
  }

  $async.Stream<$0.UpdateDTO> listenCall(
      $grpc.ServiceCall call, $0.RequestDto request);

  $async.Stream<$0.UpdateDTO> enterToRoom(
      $grpc.ServiceCall call, $async.Stream<$0.RequestDto> request);

  $async.Future<$0.ResponseDto> exitToRoom_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.RequestDto> $request) async {
    return exitToRoom($call, await $request);
  }

  $async.Future<$0.ResponseDto> exitToRoom(
      $grpc.ServiceCall call, $0.RequestDto request);
}
