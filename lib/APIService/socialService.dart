
import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:schat2/DataClasses/Post.dart';
import 'package:schat2/DataClasses/file.dart';

import '../DataClasses/Group.dart';
import '../eventStore.dart';
import '../generated/social.pbgrpc.dart';

class SocialService
{

 late dynamic channel;
  late SocialRpcClient stubSocial;
  
  
  
  SocialService(String serverAddress, int portServer, {required bool isWeb}) {
    _initializeChannel(serverAddress, portServer, isWeb);
  }
  
  void _initializeChannel(String serverAddress, int portServer, bool isWeb) {
    if (isWeb) {
      channel = GrpcOrGrpcWebClientChannel.toSingleEndpoint(
        host: serverAddress,
        port: portServer,
        transportSecure: false,
      );
    } else {
      channel = ClientChannel(
        serverAddress,
        port: portServer,
        options: ChannelOptions(
          credentials: ChannelCredentials.insecure(),
          codecRegistry: CodecRegistry(codecs: [GzipCodec()]),
          // Экспоненциальная задержка для повторных попыток
          backoffStrategy:  (last) => Duration(seconds: last == null ? 5 : last.inSeconds * 2),
          keepAlive: ClientKeepAliveOptions(
            pingInterval: Duration(minutes: 60), // Уменьшено с 2 минут
            timeout: Duration(seconds: 20), // Увеличено
            permitWithoutCalls: false,
          ),
        ),
      );
    }
    stubSocial = SocialRpcClient(channel);
  }

  Future <ResponseDto> createPost(PostData post, List<FileData> files)async
{
  try {
    Map<String, String> metadata = {'access_token': config.server.accessToken};
    List<String> typeContent = [];
    PostDto req = PostDto(id: post.id, body: post.body, authorId: post.authorId, channelId: post.channelId, authorName: post.authorName, data: [], likes: [], content: [], comments: [], datePost: post.datePost, tags: post.tags, topik: post.topik, stickerContent: post.stickerContent);
    for (var element in files) {
      typeContent.add(element.name);
      req.data.add(element.data);
    }
    req.content.addAll(typeContent);
    ResponseDto res = await stubSocial.createPost(req,
        options: CallOptions(metadata: metadata));
    return res;
  } catch (e) {
    return ResponseDto(success: false, message: e.toString());
  }
}



  Future<List<PostDto>> getUserPosts(int userId, int offset)async
{
  Map<String, String> metadata = {'access_token': config.server.accessToken};
  RequestPostsDto req = RequestPostsDto(offset: offset, channel: ChannelDto(authorId: userId));
  ListPostsDto res = await stubSocial.fetchUserPosts(req, options: CallOptions(metadata: metadata));
  return res.posts;
}

  Future<ResponseDto> createGroup(Group group, FileData file)async
  {
    Map<String, String> metadata = {'access_token': config.server.accessToken};
    ChannelDto req = ChannelDto(id: group.id, name: group.name, authorId: config.server.userGlobal.id, posts: [], channelImage: '', members: [], image: file.data, tags: group.tags, topik: group.topikList);
    ResponseDto res = await stubSocial.createChanel(req, options: CallOptions(metadata: metadata));
    return res;
  }

  Future<ListChannelsDto> getUserGroups(int offset)async
  {
    Map<String, String> metadata = {'access_token': config.server.accessToken};
    ListChannelsDto res = await stubSocial.fetchUserChannels(RequestDto(), options: CallOptions(metadata: metadata));
    return res;
  }
  Future<List<PostDto>> getChannelPosts(Group group, int offset)async
  {
    Map<String, String> metadata = {'access_token': config.server.accessToken};
    RequestPostsDto req = RequestPostsDto(offset: offset, channel: ChannelDto(authorId: group.authorId, id: group.id, topik: group.topikList));
    ListPostsDto res = await stubSocial.fetchChannelPosts(req, options: CallOptions(metadata: metadata));
    return res.posts;
  }

  Future<ResponseDto> createComment(CommentDto comment, List<FileData> files)async
  {
    for(FileData file in files)
      {
        comment.data.add(file.data);
        comment.content.add(file.name);
      }

    ResponseDto res = await stubSocial.createComment(comment, options: CallOptions(metadata: {'access_token': config.server.accessToken}));
    return res;
  }

  Future<ResponseDto> likeComment(CommentDto comment)async
  {
    ResponseDto res = await stubSocial.likeComment(comment, options: CallOptions(metadata: {'access_token': config.server.accessToken}));
    return res;
  }
  Future<ResponseDto> likePost(PostDto post)async
  {
    ResponseDto res = await stubSocial.likePost(post, options: CallOptions(metadata: {'access_token': config.server.accessToken}));
    return res;
  }


  Future<ResponseDto> addMemberGroup(ChannelDto group)async
  {
    ResponseDto res = await stubSocial.addUserChannel(group, options: CallOptions(metadata: {'access_token': config.server.accessToken}));
    return res;
  }
  Future<PostDto> getOnePost(int postId)async
  {
    PostDto res = await stubSocial.fetchOnePost(PostDto(id: postId), options: CallOptions(metadata: {'access_token': config.server.accessToken}));
    return res;
  }
  Future<ResponseDto> editGroup(Group group, FileData file)async
  {
    ResponseDto res = await stubSocial.editChanel(ChannelDto(id: group.id, name: group.name, tags: group.tags, topik: group.topikList, image: file.data, channelImage: file.name), options: CallOptions(metadata: {'access_token': config.server.accessToken}));
    return res;
  }
  Future<ListChannelsDto> getCoolGroups()async
  {
    Map<String, String> metadata = {'access_token': config.server.accessToken};
    ListChannelsDto res = await stubSocial.fetchAllChannels(RequestDto(), options: CallOptions(metadata: metadata));
    return res;
  }

}