// This is a generated file - do not edit.
//
// Generated from social.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'social.pb.dart' as $0;

export 'social.pb.dart';

@$pb.GrpcServiceName('SocialRpc')
class SocialRpcClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  SocialRpcClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.ListChannelsDto> fetchAllChannels($0.RequestDto request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$fetchAllChannels, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListChannelsDto> fetchUserChannels($0.RequestDto request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$fetchUserChannels, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListPostsDto> fetchUserPosts($0.RequestPostsDto request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$fetchUserPosts, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListPostsDto> fetchChannelPosts($0.RequestPostsDto request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$fetchChannelPosts, request, options: options);
  }

  $grpc.ResponseFuture<$0.PostDto> fetchOnePost($0.PostDto request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$fetchOnePost, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> addUserChannel($0.ChannelDto request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$addUserChannel, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> createChanel($0.ChannelDto request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$createChanel, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> editChanel($0.ChannelDto request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$editChanel, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> deleteChanel($0.ChannelDto request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$deleteChanel, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> createPost($0.PostDto request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$createPost, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> deletePost($0.PostDto request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$deletePost, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> createComment($0.CommentDto request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$createComment, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> deleteComment($0.CommentDto request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$deleteComment, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> likePost($0.PostDto request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$likePost, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> likeComment($0.CommentDto request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$likeComment, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListChannelsDto> searchChannel($0.SearchRequestDto request, {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$searchChannel, request, options: options);
  }

    // method descriptors

  static final _$fetchAllChannels = $grpc.ClientMethod<$0.RequestDto, $0.ListChannelsDto>(
      '/SocialRpc/FetchAllChannels',
      ($0.RequestDto value) => value.writeToBuffer(),
      $0.ListChannelsDto.fromBuffer);
  static final _$fetchUserChannels = $grpc.ClientMethod<$0.RequestDto, $0.ListChannelsDto>(
      '/SocialRpc/FetchUserChannels',
      ($0.RequestDto value) => value.writeToBuffer(),
      $0.ListChannelsDto.fromBuffer);
  static final _$fetchUserPosts = $grpc.ClientMethod<$0.RequestPostsDto, $0.ListPostsDto>(
      '/SocialRpc/FetchUserPosts',
      ($0.RequestPostsDto value) => value.writeToBuffer(),
      $0.ListPostsDto.fromBuffer);
  static final _$fetchChannelPosts = $grpc.ClientMethod<$0.RequestPostsDto, $0.ListPostsDto>(
      '/SocialRpc/FetchChannelPosts',
      ($0.RequestPostsDto value) => value.writeToBuffer(),
      $0.ListPostsDto.fromBuffer);
  static final _$fetchOnePost = $grpc.ClientMethod<$0.PostDto, $0.PostDto>(
      '/SocialRpc/FetchOnePost',
      ($0.PostDto value) => value.writeToBuffer(),
      $0.PostDto.fromBuffer);
  static final _$addUserChannel = $grpc.ClientMethod<$0.ChannelDto, $0.ResponseDto>(
      '/SocialRpc/AddUserChannel',
      ($0.ChannelDto value) => value.writeToBuffer(),
      $0.ResponseDto.fromBuffer);
  static final _$createChanel = $grpc.ClientMethod<$0.ChannelDto, $0.ResponseDto>(
      '/SocialRpc/CreateChanel',
      ($0.ChannelDto value) => value.writeToBuffer(),
      $0.ResponseDto.fromBuffer);
  static final _$editChanel = $grpc.ClientMethod<$0.ChannelDto, $0.ResponseDto>(
      '/SocialRpc/EditChanel',
      ($0.ChannelDto value) => value.writeToBuffer(),
      $0.ResponseDto.fromBuffer);
  static final _$deleteChanel = $grpc.ClientMethod<$0.ChannelDto, $0.ResponseDto>(
      '/SocialRpc/DeleteChanel',
      ($0.ChannelDto value) => value.writeToBuffer(),
      $0.ResponseDto.fromBuffer);
  static final _$createPost = $grpc.ClientMethod<$0.PostDto, $0.ResponseDto>(
      '/SocialRpc/CreatePost',
      ($0.PostDto value) => value.writeToBuffer(),
      $0.ResponseDto.fromBuffer);
  static final _$deletePost = $grpc.ClientMethod<$0.PostDto, $0.ResponseDto>(
      '/SocialRpc/DeletePost',
      ($0.PostDto value) => value.writeToBuffer(),
      $0.ResponseDto.fromBuffer);
  static final _$createComment = $grpc.ClientMethod<$0.CommentDto, $0.ResponseDto>(
      '/SocialRpc/CreateComment',
      ($0.CommentDto value) => value.writeToBuffer(),
      $0.ResponseDto.fromBuffer);
  static final _$deleteComment = $grpc.ClientMethod<$0.CommentDto, $0.ResponseDto>(
      '/SocialRpc/DeleteComment',
      ($0.CommentDto value) => value.writeToBuffer(),
      $0.ResponseDto.fromBuffer);
  static final _$likePost = $grpc.ClientMethod<$0.PostDto, $0.ResponseDto>(
      '/SocialRpc/LikePost',
      ($0.PostDto value) => value.writeToBuffer(),
      $0.ResponseDto.fromBuffer);
  static final _$likeComment = $grpc.ClientMethod<$0.CommentDto, $0.ResponseDto>(
      '/SocialRpc/LikeComment',
      ($0.CommentDto value) => value.writeToBuffer(),
      $0.ResponseDto.fromBuffer);
  static final _$searchChannel = $grpc.ClientMethod<$0.SearchRequestDto, $0.ListChannelsDto>(
      '/SocialRpc/SearchChannel',
      ($0.SearchRequestDto value) => value.writeToBuffer(),
      $0.ListChannelsDto.fromBuffer);
}

@$pb.GrpcServiceName('SocialRpc')
abstract class SocialRpcServiceBase extends $grpc.Service {
  $core.String get $name => 'SocialRpc';

  SocialRpcServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.RequestDto, $0.ListChannelsDto>(
        'FetchAllChannels',
        fetchAllChannels_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RequestDto.fromBuffer(value),
        ($0.ListChannelsDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RequestDto, $0.ListChannelsDto>(
        'FetchUserChannels',
        fetchUserChannels_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RequestDto.fromBuffer(value),
        ($0.ListChannelsDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RequestPostsDto, $0.ListPostsDto>(
        'FetchUserPosts',
        fetchUserPosts_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RequestPostsDto.fromBuffer(value),
        ($0.ListPostsDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RequestPostsDto, $0.ListPostsDto>(
        'FetchChannelPosts',
        fetchChannelPosts_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RequestPostsDto.fromBuffer(value),
        ($0.ListPostsDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PostDto, $0.PostDto>(
        'FetchOnePost',
        fetchOnePost_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PostDto.fromBuffer(value),
        ($0.PostDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ChannelDto, $0.ResponseDto>(
        'AddUserChannel',
        addUserChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ChannelDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ChannelDto, $0.ResponseDto>(
        'CreateChanel',
        createChanel_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ChannelDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ChannelDto, $0.ResponseDto>(
        'EditChanel',
        editChanel_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ChannelDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ChannelDto, $0.ResponseDto>(
        'DeleteChanel',
        deleteChanel_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ChannelDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PostDto, $0.ResponseDto>(
        'CreatePost',
        createPost_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PostDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PostDto, $0.ResponseDto>(
        'DeletePost',
        deletePost_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PostDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CommentDto, $0.ResponseDto>(
        'CreateComment',
        createComment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CommentDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CommentDto, $0.ResponseDto>(
        'DeleteComment',
        deleteComment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CommentDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PostDto, $0.ResponseDto>(
        'LikePost',
        likePost_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PostDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CommentDto, $0.ResponseDto>(
        'LikeComment',
        likeComment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CommentDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SearchRequestDto, $0.ListChannelsDto>(
        'SearchChannel',
        searchChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SearchRequestDto.fromBuffer(value),
        ($0.ListChannelsDto value) => value.writeToBuffer()));
  }

  $async.Future<$0.ListChannelsDto> fetchAllChannels_Pre($grpc.ServiceCall $call, $async.Future<$0.RequestDto> $request) async {
    return fetchAllChannels($call, await $request);
  }

  $async.Future<$0.ListChannelsDto> fetchAllChannels($grpc.ServiceCall call, $0.RequestDto request);

  $async.Future<$0.ListChannelsDto> fetchUserChannels_Pre($grpc.ServiceCall $call, $async.Future<$0.RequestDto> $request) async {
    return fetchUserChannels($call, await $request);
  }

  $async.Future<$0.ListChannelsDto> fetchUserChannels($grpc.ServiceCall call, $0.RequestDto request);

  $async.Future<$0.ListPostsDto> fetchUserPosts_Pre($grpc.ServiceCall $call, $async.Future<$0.RequestPostsDto> $request) async {
    return fetchUserPosts($call, await $request);
  }

  $async.Future<$0.ListPostsDto> fetchUserPosts($grpc.ServiceCall call, $0.RequestPostsDto request);

  $async.Future<$0.ListPostsDto> fetchChannelPosts_Pre($grpc.ServiceCall $call, $async.Future<$0.RequestPostsDto> $request) async {
    return fetchChannelPosts($call, await $request);
  }

  $async.Future<$0.ListPostsDto> fetchChannelPosts($grpc.ServiceCall call, $0.RequestPostsDto request);

  $async.Future<$0.PostDto> fetchOnePost_Pre($grpc.ServiceCall $call, $async.Future<$0.PostDto> $request) async {
    return fetchOnePost($call, await $request);
  }

  $async.Future<$0.PostDto> fetchOnePost($grpc.ServiceCall call, $0.PostDto request);

  $async.Future<$0.ResponseDto> addUserChannel_Pre($grpc.ServiceCall $call, $async.Future<$0.ChannelDto> $request) async {
    return addUserChannel($call, await $request);
  }

  $async.Future<$0.ResponseDto> addUserChannel($grpc.ServiceCall call, $0.ChannelDto request);

  $async.Future<$0.ResponseDto> createChanel_Pre($grpc.ServiceCall $call, $async.Future<$0.ChannelDto> $request) async {
    return createChanel($call, await $request);
  }

  $async.Future<$0.ResponseDto> createChanel($grpc.ServiceCall call, $0.ChannelDto request);

  $async.Future<$0.ResponseDto> editChanel_Pre($grpc.ServiceCall $call, $async.Future<$0.ChannelDto> $request) async {
    return editChanel($call, await $request);
  }

  $async.Future<$0.ResponseDto> editChanel($grpc.ServiceCall call, $0.ChannelDto request);

  $async.Future<$0.ResponseDto> deleteChanel_Pre($grpc.ServiceCall $call, $async.Future<$0.ChannelDto> $request) async {
    return deleteChanel($call, await $request);
  }

  $async.Future<$0.ResponseDto> deleteChanel($grpc.ServiceCall call, $0.ChannelDto request);

  $async.Future<$0.ResponseDto> createPost_Pre($grpc.ServiceCall $call, $async.Future<$0.PostDto> $request) async {
    return createPost($call, await $request);
  }

  $async.Future<$0.ResponseDto> createPost($grpc.ServiceCall call, $0.PostDto request);

  $async.Future<$0.ResponseDto> deletePost_Pre($grpc.ServiceCall $call, $async.Future<$0.PostDto> $request) async {
    return deletePost($call, await $request);
  }

  $async.Future<$0.ResponseDto> deletePost($grpc.ServiceCall call, $0.PostDto request);

  $async.Future<$0.ResponseDto> createComment_Pre($grpc.ServiceCall $call, $async.Future<$0.CommentDto> $request) async {
    return createComment($call, await $request);
  }

  $async.Future<$0.ResponseDto> createComment($grpc.ServiceCall call, $0.CommentDto request);

  $async.Future<$0.ResponseDto> deleteComment_Pre($grpc.ServiceCall $call, $async.Future<$0.CommentDto> $request) async {
    return deleteComment($call, await $request);
  }

  $async.Future<$0.ResponseDto> deleteComment($grpc.ServiceCall call, $0.CommentDto request);

  $async.Future<$0.ResponseDto> likePost_Pre($grpc.ServiceCall $call, $async.Future<$0.PostDto> $request) async {
    return likePost($call, await $request);
  }

  $async.Future<$0.ResponseDto> likePost($grpc.ServiceCall call, $0.PostDto request);

  $async.Future<$0.ResponseDto> likeComment_Pre($grpc.ServiceCall $call, $async.Future<$0.CommentDto> $request) async {
    return likeComment($call, await $request);
  }

  $async.Future<$0.ResponseDto> likeComment($grpc.ServiceCall call, $0.CommentDto request);

  $async.Future<$0.ListChannelsDto> searchChannel_Pre($grpc.ServiceCall $call, $async.Future<$0.SearchRequestDto> $request) async {
    return searchChannel($call, await $request);
  }

  $async.Future<$0.ListChannelsDto> searchChannel($grpc.ServiceCall call, $0.SearchRequestDto request);

}
