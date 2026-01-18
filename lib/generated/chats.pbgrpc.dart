// This is a generated file - do not edit.
//
// Generated from chats.proto.

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

import 'chats.pb.dart' as $0;

export 'chats.pb.dart';

@$pb.GrpcServiceName('ChatsRpc')
class ChatsRpcClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  ChatsRpcClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.ListChatsDto> fetchAllChats(
    $0.RequestDto request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$fetchAllChats, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> createChat(
    $0.ChatDto request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createChat, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> editGroupChat(
    $0.ChatDto request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$editGroupChat, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> deleteChat(
    $0.ChatDto request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$deleteChat, request, options: options);
  }

  $grpc.ResponseFuture<$0.ChatDto> fetchChat(
    $0.ChatDto request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$fetchChat, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> sendMessage(
    $0.MessageDto request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$sendMessage, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> deleteMessage(
    $0.MessageDto request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$deleteMessage, request, options: options);
  }

  $grpc.ResponseStream<$0.UpdateDTO> listenEvent(
    $0.RequestDto request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
        _$listenEvent, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$0.UpdateAppRes> updateApp(
    $0.UpdateAppReq request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateApp, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> notification(
    $0.RequestDto request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$notification, request, options: options);
  }

  $grpc.ResponseFuture<$0.ChatDto> searchMessage(
    $0.SearchRequestDto request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$searchMessage, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> forwardMessage(
    $0.ChatDto request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$forwardMessage, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> reactionMessage(
    $0.ReactionMessageDto request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$reactionMessage, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> deleteReactionMessage(
    $0.ReactionMessageDto request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$deleteReactionMessage, request, options: options);
  }

  // method descriptors

  static final _$fetchAllChats =
      $grpc.ClientMethod<$0.RequestDto, $0.ListChatsDto>(
          '/ChatsRpc/FetchAllChats',
          ($0.RequestDto value) => value.writeToBuffer(),
          $0.ListChatsDto.fromBuffer);
  static final _$createChat = $grpc.ClientMethod<$0.ChatDto, $0.ResponseDto>(
      '/ChatsRpc/CreateChat',
      ($0.ChatDto value) => value.writeToBuffer(),
      $0.ResponseDto.fromBuffer);
  static final _$editGroupChat = $grpc.ClientMethod<$0.ChatDto, $0.ResponseDto>(
      '/ChatsRpc/EditGroupChat',
      ($0.ChatDto value) => value.writeToBuffer(),
      $0.ResponseDto.fromBuffer);
  static final _$deleteChat = $grpc.ClientMethod<$0.ChatDto, $0.ResponseDto>(
      '/ChatsRpc/DeleteChat',
      ($0.ChatDto value) => value.writeToBuffer(),
      $0.ResponseDto.fromBuffer);
  static final _$fetchChat = $grpc.ClientMethod<$0.ChatDto, $0.ChatDto>(
      '/ChatsRpc/FetchChat',
      ($0.ChatDto value) => value.writeToBuffer(),
      $0.ChatDto.fromBuffer);
  static final _$sendMessage =
      $grpc.ClientMethod<$0.MessageDto, $0.ResponseDto>(
          '/ChatsRpc/SendMessage',
          ($0.MessageDto value) => value.writeToBuffer(),
          $0.ResponseDto.fromBuffer);
  static final _$deleteMessage =
      $grpc.ClientMethod<$0.MessageDto, $0.ResponseDto>(
          '/ChatsRpc/DeleteMessage',
          ($0.MessageDto value) => value.writeToBuffer(),
          $0.ResponseDto.fromBuffer);
  static final _$listenEvent = $grpc.ClientMethod<$0.RequestDto, $0.UpdateDTO>(
      '/ChatsRpc/ListenEvent',
      ($0.RequestDto value) => value.writeToBuffer(),
      $0.UpdateDTO.fromBuffer);
  static final _$updateApp =
      $grpc.ClientMethod<$0.UpdateAppReq, $0.UpdateAppRes>(
          '/ChatsRpc/UpdateApp',
          ($0.UpdateAppReq value) => value.writeToBuffer(),
          $0.UpdateAppRes.fromBuffer);
  static final _$notification =
      $grpc.ClientMethod<$0.RequestDto, $0.ResponseDto>(
          '/ChatsRpc/Notification',
          ($0.RequestDto value) => value.writeToBuffer(),
          $0.ResponseDto.fromBuffer);
  static final _$searchMessage =
      $grpc.ClientMethod<$0.SearchRequestDto, $0.ChatDto>(
          '/ChatsRpc/SearchMessage',
          ($0.SearchRequestDto value) => value.writeToBuffer(),
          $0.ChatDto.fromBuffer);
  static final _$forwardMessage =
      $grpc.ClientMethod<$0.ChatDto, $0.ResponseDto>(
          '/ChatsRpc/ForwardMessage',
          ($0.ChatDto value) => value.writeToBuffer(),
          $0.ResponseDto.fromBuffer);
  static final _$reactionMessage =
      $grpc.ClientMethod<$0.ReactionMessageDto, $0.ResponseDto>(
          '/ChatsRpc/ReactionMessage',
          ($0.ReactionMessageDto value) => value.writeToBuffer(),
          $0.ResponseDto.fromBuffer);
  static final _$deleteReactionMessage =
      $grpc.ClientMethod<$0.ReactionMessageDto, $0.ResponseDto>(
          '/ChatsRpc/DeleteReactionMessage',
          ($0.ReactionMessageDto value) => value.writeToBuffer(),
          $0.ResponseDto.fromBuffer);
}

@$pb.GrpcServiceName('ChatsRpc')
abstract class ChatsRpcServiceBase extends $grpc.Service {
  $core.String get $name => 'ChatsRpc';

  ChatsRpcServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.RequestDto, $0.ListChatsDto>(
        'FetchAllChats',
        fetchAllChats_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RequestDto.fromBuffer(value),
        ($0.ListChatsDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ChatDto, $0.ResponseDto>(
        'CreateChat',
        createChat_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ChatDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ChatDto, $0.ResponseDto>(
        'EditGroupChat',
        editGroupChat_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ChatDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ChatDto, $0.ResponseDto>(
        'DeleteChat',
        deleteChat_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ChatDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ChatDto, $0.ChatDto>(
        'FetchChat',
        fetchChat_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ChatDto.fromBuffer(value),
        ($0.ChatDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MessageDto, $0.ResponseDto>(
        'SendMessage',
        sendMessage_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.MessageDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MessageDto, $0.ResponseDto>(
        'DeleteMessage',
        deleteMessage_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.MessageDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RequestDto, $0.UpdateDTO>(
        'ListenEvent',
        listenEvent_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.RequestDto.fromBuffer(value),
        ($0.UpdateDTO value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateAppReq, $0.UpdateAppRes>(
        'UpdateApp',
        updateApp_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateAppReq.fromBuffer(value),
        ($0.UpdateAppRes value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RequestDto, $0.ResponseDto>(
        'Notification',
        notification_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RequestDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SearchRequestDto, $0.ChatDto>(
        'SearchMessage',
        searchMessage_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SearchRequestDto.fromBuffer(value),
        ($0.ChatDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ChatDto, $0.ResponseDto>(
        'ForwardMessage',
        forwardMessage_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ChatDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ReactionMessageDto, $0.ResponseDto>(
        'ReactionMessage',
        reactionMessage_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ReactionMessageDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ReactionMessageDto, $0.ResponseDto>(
        'DeleteReactionMessage',
        deleteReactionMessage_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ReactionMessageDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
  }

  $async.Future<$0.ListChatsDto> fetchAllChats_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.RequestDto> $request) async {
    return fetchAllChats($call, await $request);
  }

  $async.Future<$0.ListChatsDto> fetchAllChats(
      $grpc.ServiceCall call, $0.RequestDto request);

  $async.Future<$0.ResponseDto> createChat_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.ChatDto> $request) async {
    return createChat($call, await $request);
  }

  $async.Future<$0.ResponseDto> createChat(
      $grpc.ServiceCall call, $0.ChatDto request);

  $async.Future<$0.ResponseDto> editGroupChat_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.ChatDto> $request) async {
    return editGroupChat($call, await $request);
  }

  $async.Future<$0.ResponseDto> editGroupChat(
      $grpc.ServiceCall call, $0.ChatDto request);

  $async.Future<$0.ResponseDto> deleteChat_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.ChatDto> $request) async {
    return deleteChat($call, await $request);
  }

  $async.Future<$0.ResponseDto> deleteChat(
      $grpc.ServiceCall call, $0.ChatDto request);

  $async.Future<$0.ChatDto> fetchChat_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.ChatDto> $request) async {
    return fetchChat($call, await $request);
  }

  $async.Future<$0.ChatDto> fetchChat(
      $grpc.ServiceCall call, $0.ChatDto request);

  $async.Future<$0.ResponseDto> sendMessage_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.MessageDto> $request) async {
    return sendMessage($call, await $request);
  }

  $async.Future<$0.ResponseDto> sendMessage(
      $grpc.ServiceCall call, $0.MessageDto request);

  $async.Future<$0.ResponseDto> deleteMessage_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.MessageDto> $request) async {
    return deleteMessage($call, await $request);
  }

  $async.Future<$0.ResponseDto> deleteMessage(
      $grpc.ServiceCall call, $0.MessageDto request);

  $async.Stream<$0.UpdateDTO> listenEvent_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.RequestDto> $request) async* {
    yield* listenEvent($call, await $request);
  }

  $async.Stream<$0.UpdateDTO> listenEvent(
      $grpc.ServiceCall call, $0.RequestDto request);

  $async.Future<$0.UpdateAppRes> updateApp_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.UpdateAppReq> $request) async {
    return updateApp($call, await $request);
  }

  $async.Future<$0.UpdateAppRes> updateApp(
      $grpc.ServiceCall call, $0.UpdateAppReq request);

  $async.Future<$0.ResponseDto> notification_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.RequestDto> $request) async {
    return notification($call, await $request);
  }

  $async.Future<$0.ResponseDto> notification(
      $grpc.ServiceCall call, $0.RequestDto request);

  $async.Future<$0.ChatDto> searchMessage_Pre($grpc.ServiceCall $call,
      $async.Future<$0.SearchRequestDto> $request) async {
    return searchMessage($call, await $request);
  }

  $async.Future<$0.ChatDto> searchMessage(
      $grpc.ServiceCall call, $0.SearchRequestDto request);

  $async.Future<$0.ResponseDto> forwardMessage_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.ChatDto> $request) async {
    return forwardMessage($call, await $request);
  }

  $async.Future<$0.ResponseDto> forwardMessage(
      $grpc.ServiceCall call, $0.ChatDto request);

  $async.Future<$0.ResponseDto> reactionMessage_Pre($grpc.ServiceCall $call,
      $async.Future<$0.ReactionMessageDto> $request) async {
    return reactionMessage($call, await $request);
  }

  $async.Future<$0.ResponseDto> reactionMessage(
      $grpc.ServiceCall call, $0.ReactionMessageDto request);

  $async.Future<$0.ResponseDto> deleteReactionMessage_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ReactionMessageDto> $request) async {
    return deleteReactionMessage($call, await $request);
  }

  $async.Future<$0.ResponseDto> deleteReactionMessage(
      $grpc.ServiceCall call, $0.ReactionMessageDto request);
}
