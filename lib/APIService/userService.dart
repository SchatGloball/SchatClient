import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_or_grpcweb.dart';


import '../DataClasses/file.dart';
import '../env.dart';
import '../eventStore.dart';
import '../generated/auth.pbgrpc.dart';


class UserService {
 late dynamic channel;
  late AuthRpcClient stub;
  
  
  
  UserService(String serverAddress, int portServer, {required bool isWeb}) {
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
    stub = AuthRpcClient(channel);
  }


 Future<Map>  refreshToken(String refreshToken) async {
    try {
     final TokensDto res = await stub.refreshToken(TokensDto(refreshToken: refreshToken));
      return {
        'success': true,
        'accessToken': res.accessToken,
        'refreshToken': res.refreshToken
      };
    } catch (e) {
      return {
        'success': false,
        'Error': e.toString()
        };
    }
  }

  Future<Map> userLogin(String userEmail, String userPassword) async {
    try {
      var res =
          await stub.signIn(UserDto(email: userEmail, password: userPassword));
      Map tokens = {
        'success':true,
        'accessToken': res.accessToken,
        'refreshToken': res.refreshToken
      };
      return tokens;
    } catch (e) {
      return {'Error': e.toString(), 'success':false};
    }
  }

  userRegistration(
      String userName, String userEmail, String userPassword) async {
    try {
      var res = await stub.signUp(UserDto(
          username: userName, email: userEmail, password: userPassword, isBot: false));
      Map tokens = {
        'accessToken': res.accessToken,
        'refreshToken': res.refreshToken
      };
      return tokens;
    } catch (e) {
      return {'Error': e.toString()};
    }
  }

  searchUser(String userName) async {
    try {
      Map<String, String> metadata = {'access_token': config.server.accessToken};
      ListUsersDto res = await stub.findUser(FindDto(key: userName),
          options: CallOptions(metadata: metadata));
      return {'users': res.users};
    } catch (e) {
      return {'Error': e.toString()};
    }
  }

  Future<UserDto> fetchUser() async {
    try {

      Map<String, String> metadata = {'access_token': config.server.accessToken};
      UserDto res = await stub.fetchUser(RequestDto(),
          options: CallOptions(metadata: metadata));
      return res;
    } catch (e) {
      return UserDto(id: -1, username: e.toString());
    }
  }

  uploadAvatar(FileData file) async {
    Map<String, String> metadata = {'access_token': config.server.accessToken};
    if (!Env.image.contains(file.extension)) {
      return {'Error': 'wrong file type'};
    }
    final ResponseDto res = await stub.putAvatar(FileDto(data: file.data),
        options: CallOptions(metadata: metadata));
    return {'link': res};
  }
 Future<int> serverInfo()async
  {
    try{
      ResponseDto version = await stub.serverInfo(RequestDto(), options: CallOptions(metadata: {'access_token': ''}));
      return int.tryParse(version.message)??0;
    }
    catch(e)
    {
      print(e);
      return 0;
    }
  
  
  }
}
