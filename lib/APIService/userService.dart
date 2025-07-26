import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_or_grpcweb.dart';


import '../DataClasses/file.dart';
import '../env.dart';
import '../eventStore.dart';
import '../generated/auth.pbgrpc.dart';


class UserService {
  UserService(String serverAddress, int portServer) {
    if (config.isWeb) {
      stub = AuthRpcClient(GrpcOrGrpcWebClientChannel.toSingleEndpoint(
          host: serverAddress, port: portServer, transportSecure: false));
    } else {
      stub = AuthRpcClient(ClientChannel(serverAddress,
          port: portServer,
          options: const ChannelOptions(
              credentials: ChannelCredentials.insecure())));
    }
  }

  updateApi(String serverAddress, int portServer) {
    if (config.isWeb) {
      stub = AuthRpcClient(GrpcOrGrpcWebClientChannel.toSingleEndpoint(
          host: serverAddress, port: portServer, transportSecure: false));
    } else {
      stub = AuthRpcClient(ClientChannel(serverAddress,
          port: portServer,
          options: const ChannelOptions(
              credentials: ChannelCredentials.insecure())));
    }
  }

  AuthRpcClient stub = AuthRpcClient(ClientChannel(Env.defaultServer,
      port: Env.defaultPort,
      options:
          const ChannelOptions(credentials: ChannelCredentials.insecure())));

  refreshToken(String refreshToken) async {
    try {
      var res = await stub.refreshToken(TokensDto(refreshToken: refreshToken));
      Map tokens = {
        'accessToken': res.accessToken,
        'refreshToken': res.refreshToken
      };
      return tokens;
    } catch (e) {
      return {'Error': e.toString()};
    }
  }

  userLogin(String userEmail, String userPassword) async {
    try {
      var res =
          await stub.signIn(UserDto(email: userEmail, password: userPassword));
      Map tokens = {
        'accessToken': res.accessToken,
        'refreshToken': res.refreshToken
      };
      return tokens;
    } catch (e) {
      return {'Error': e.toString()};
    }
  }

  userRegistration(
      String userName, String userEmail, String userPassword) async {
    try {
      var res = await stub.signUp(UserDto(
          username: userName, email: userEmail, password: userPassword));
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
      Map<String, String> metadata = {'access_token': userGlobal.accessToken};
      ListUsersDto res = await stub.findUser(FindDto(key: userName),
          options: CallOptions(metadata: metadata));
      return {'users': res.users};
    } catch (e) {
      return {'Error': e.toString()};
    }
  }

  fetchUser() async {
    try {

      Map<String, String> metadata = {'access_token': userGlobal.accessToken};
      UserDto res = await stub.fetchUser(RequestDto(),
          options: CallOptions(metadata: metadata));
      return {'user': res};
    } catch (e) {
      return {'Error': e.toString()};
    }
  }

  uploadAvatar(FileData file) async {
    Map<String, String> metadata = {'access_token': userGlobal.accessToken};
    if (!Env.image.contains(file.extension)) {
      return {'Error': 'wrong file type'};
    }
    var res = await stub.putAvatar(FileDto(data: file.data),
        options: CallOptions(metadata: metadata));
    return {'link': res};
  }
}
