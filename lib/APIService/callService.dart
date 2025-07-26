import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:grpc/grpc.dart';
import 'package:rxdart/rxdart.dart';

import '../env.dart';
import '../eventStore.dart';
import '../generated/call.pb.dart';
import '../generated/call.pbgrpc.dart';



class CallService
{

  dynamic channel = ClientChannel(Env.defaultServer,
      port: Env.defaultPort,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()));
  BehaviorSubject<UpdateDTO> eventController = BehaviorSubject();
  BehaviorSubject<ResponseDto> inputController = BehaviorSubject();
  BehaviorSubject<UpdateDTO> outputController = BehaviorSubject();
  CallService(String serverAddress, int portServer)
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
    stubCall = CallRpcClient(channel);
  }

  CallRpcClient stubCall = CallRpcClient(ClientChannel(Env.defaultServer,
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
    stubCall = CallRpcClient(channel);
  }


  late ResponseStream<UpdateDTO> updateEvent;


  createCall(List<UserDto> members, bool video)
  async
  {
    try{
      Map<String, String> metadata = {'access_token': userGlobal.accessToken};
      UpdateDTO call = UpdateDTO();
      call.users.addAll(members);
      call.video = video;
      call.room='one';

      var res = await stubCall.createGroupCall(call, options: CallOptions(metadata: metadata));
      return {'status': res.message};

    }
    catch(e)
    {
      return {'Error': e.toString()};
    }
  }

  listenCall()async
  {
    Map<String, String> metadata = {'access_token': userGlobal.accessToken};
    final request = RequestDto(); // создаем экземпляр запроса
    updateEvent = stubCall.listenCall(request, options: CallOptions(metadata: metadata)); // отправляем запрос и получаем стрим
    updateEvent.listen((update) {
      // обрабатываем полученный UpdateDTO
      eventController.add(update);
    },
        onDone: ()async{
          //попытка переподключения через каждые 5 секунд
          return Future.delayed(const Duration(seconds: 5), () => listenCall());
        });
  }

  Stream<UpdateDTO> enterToRoom(Stream<RequestDto> request)async*
  {
    Map<String, String> metadata = {'access_token': userGlobal.accessToken};
    ResponseStream<UpdateDTO> res = stubCall.enterToRoom(request, options: CallOptions(metadata: metadata));
    yield*  res;
  }





}