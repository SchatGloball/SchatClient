
import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:grpc/grpc.dart';



import '../eventStore.dart';
import '../generated/call.pb.dart';
import '../generated/call.pbgrpc.dart';



class CallService
{

   late dynamic channel;
  late CallRpcClient stubCall;
  
 
  bool _isDisposed = false;
  
  
  
  CallService(String serverAddress, int portServer, {required bool isWeb}) {
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
         //idleTimeout: Duration(seconds: 10), // Увеличено
         // connectionTimeout: Duration(seconds: 5), // Увеличено
          codecRegistry: CodecRegistry(codecs: [GzipCodec()]),
          // Экспоненциальная задержка для повторных попыток
          backoffStrategy:  (last) => Duration(seconds: last == null ? 5 : last.inSeconds * 2),
          keepAlive: ClientKeepAliveOptions(
            pingInterval: Duration(seconds: 240), // Уменьшено с 2 минут
            timeout: Duration(seconds: 10), // Увеличено
            permitWithoutCalls: true,
          ),
          
        ),
      
      );
    }
    stubCall = CallRpcClient(channel);
  }

  void updateApi(String serverAddress, int portServer) {
    // Закрыть старое соединение перед созданием нового
    dispose();
    _initializeChannel(serverAddress, portServer, config.isWeb);
  }
  void dispose() {
    _isDisposed = true;
    listenServerEvent.cancel(); 
  }


  late ResponseStream<UpdateDTO> updateEvent;


  Future <String> createCall(List<UserDto> members, bool video)
  async
  {
    try{
      Map<String, String> metadata = {'access_token': config.server.accessToken};
      UpdateDTO call = UpdateDTO();
      call.users.addAll(members);
      call.video = video;
      call.room='one';
      var res = await stubCall.createGroupCall(call, options: CallOptions(metadata: metadata));
      return res.message;
    }
    catch(e)
    {
      return e.toString();
    }
  }

  listenCall()async
  {
    Map<String, String> metadata = {'access_token': config.server.accessToken};
    final request = RequestDto(); // создаем экземпляр запроса
    updateEvent = stubCall.listenCall(request, options: CallOptions(metadata: metadata)); // отправляем запрос и получаем стрим
  }

  Stream<UpdateDTO> enterToRoom(Stream<RequestDto> request)async*
  {
    Map<String, String> metadata = {'access_token': config.server.accessToken};
    ResponseStream<UpdateDTO> res = stubCall.enterToRoom(request, options: CallOptions(metadata: metadata));
    yield*  res;
  }

exitCall(String room)async
{
ResponseDto res = await stubCall.exitToRoom(RequestDto(room: room, callData: CallDto(soundData: [], videoData: [])), options: CallOptions(metadata: {'access_token': config.server.accessToken}));
return res.message;
}
  





}