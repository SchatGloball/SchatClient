
import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:schat2/DataClasses/Post.dart';
import 'package:schat2/DataClasses/file.dart';

import '../DataClasses/Group.dart';
import '../env.dart';
import '../eventStore.dart';
import '../generated/social.pbgrpc.dart';

class SocialService
{

  dynamic channel = ClientChannel(Env.defaultServer,
      port: Env.defaultPort,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()));

  SocialService(String serverAddress, int portServer)
  {

    if(config.isWeb)
    {
      channel = GrpcOrGrpcWebClientChannel.toSingleEndpoint(
          host: serverAddress, port: portServer, transportSecure: false);
    }
    else{
      channel = ClientChannel(serverAddress,
          port: portServer,
          options: const ChannelOptions(credentials: ChannelCredentials.insecure()));
    }
    stubSocial = SocialRpcClient(channel);
  }

  SocialRpcClient stubSocial = SocialRpcClient(ClientChannel(Env.defaultServer,
      port: Env.defaultPort,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure())));


  updateApi(String serverAddress, int portServer)
  {
    if(config.isWeb)
    {
      channel = GrpcOrGrpcWebClientChannel.toSingleEndpoint(
          host: serverAddress, port: portServer, transportSecure: false);
    }
    else{
      channel = ClientChannel(serverAddress,
          port: portServer,
          options: const ChannelOptions(credentials: ChannelCredentials.insecure()));
    }
    stubSocial = SocialRpcClient(channel);
  }




  Future <ResponseDto> createPost(PostData post, List<FileData> files)async
{
  try {
    Map<String, String> metadata = {'access_token': userGlobal.accessToken};
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
  Map<String, String> metadata = {'access_token': userGlobal.accessToken};
  RequestPostsDto req = RequestPostsDto(offset: offset, channel: ChannelDto(authorId: userId));
  ListPostsDto res = await stubSocial.fetchUserPosts(req, options: CallOptions(metadata: metadata));
  return res.posts;
}

  Future<ResponseDto> createGroup(Group group, FileData file)async
  {
    Map<String, String> metadata = {'access_token': userGlobal.accessToken};
    ChannelDto req = ChannelDto(id: group.id, name: group.name, authorId: userGlobal.id, posts: [], channelImage: '', members: [], image: file.data, tags: group.tags, topik: group.topik);
    ResponseDto res = await stubSocial.createChanel(req, options: CallOptions(metadata: metadata));
    return res;
  }

  Future<ListChannelsDto> getUserGroups(int offset)async
  {
    Map<String, String> metadata = {'access_token': userGlobal.accessToken};
    ListChannelsDto res = await stubSocial.fetchUserChannels(RequestDto(), options: CallOptions(metadata: metadata));
    return res;
  }
  Future<List<PostDto>> getChannelPosts(Group group, int offset)async
  {
    Map<String, String> metadata = {'access_token': userGlobal.accessToken};
    RequestPostsDto req = RequestPostsDto(offset: offset, channel: ChannelDto(authorId: group.authorId, id: group.id, topik: group.topik));
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

    ResponseDto res = await stubSocial.createComment(comment, options: CallOptions(metadata: {'access_token': userGlobal.accessToken}));
    return res;
  }

  Future<ResponseDto> likeComment(CommentDto comment)async
  {
    ResponseDto res = await stubSocial.likeComment(comment, options: CallOptions(metadata: {'access_token': userGlobal.accessToken}));
    return res;
  }
  Future<ResponseDto> likePost(PostDto post)async
  {
    ResponseDto res = await stubSocial.likePost(post, options: CallOptions(metadata: {'access_token': userGlobal.accessToken}));
    return res;
  }


  Future<ResponseDto> addMemberGroup(ChannelDto group)async
  {
    ResponseDto res = await stubSocial.addUserChannel(group, options: CallOptions(metadata: {'access_token': userGlobal.accessToken}));
    return res;
  }
  Future<PostDto> getOnePost(int postId)async
  {
    PostDto res = await stubSocial.fetchOnePost(PostDto(id: postId), options: CallOptions(metadata: {'access_token': userGlobal.accessToken}));
    return res;
  }
  Future<ResponseDto> editGroup(Group group, FileData file)async
  {
    ResponseDto res = await stubSocial.editChanel(ChannelDto(id: group.id, name: group.name, tags: group.tags, topik: group.topik, image: file.data, channelImage: file.name), options: CallOptions(metadata: {'access_token': userGlobal.accessToken}));
    return res;
  }
  Future<ListChannelsDto> getCoolGroups()async
  {
    Map<String, String> metadata = {'access_token': userGlobal.accessToken};
    ListChannelsDto res = await stubSocial.fetchAllChannels(RequestDto(), options: CallOptions(metadata: metadata));
    return res;
  }

}