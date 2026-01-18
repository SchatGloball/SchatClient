import 'package:schat2/APIService/callService.dart';
import 'package:schat2/APIService/chatService.dart';
import 'package:schat2/APIService/socialService.dart';
import 'package:schat2/APIService/userService.dart';
import 'package:schat2/DataClasses/UserData.dart';
import 'package:schat2/eventStore.dart';
import 'package:schat2/generated/auth.pbgrpc.dart';

class BackendServer
{
  BackendServer(int newPort, String newAddress, String newRefreshToken, String newName, {required bool isWeb}){
    port=newPort;
    address = newAddress;
    name = newName;
userApi = UserService(address, port, isWeb: isWeb);
chatApi = ChatService(address, port, isWeb: isWeb);
callApi = CallService(address, port, isWeb: isWeb);
socialApi = SocialService(address, port, isWeb: isWeb);
refreshToken = newRefreshToken;
  }
  
 late int port;
  late String address;
  String accessToken = '';
late  String refreshToken;
   late String name;
   late UserService userApi;
late  ChatService chatApi;
late  CallService callApi;
late  SocialService socialApi;
int version = 0;

User userGlobal = User(0, 'name', '', false);
Future<bool>  refreshTokens()async
{
if(refreshToken == '')
{return false;}
Map tokens = await userApi.refreshToken(refreshToken);
if(!tokens['success'])
{return false;}

await setTokens(tokens['accessToken'], tokens['refreshToken'],);

return true;
}

 bool get isActive
{
  if(config.server.address==address && config.server.port == port)
  {
    return true;
  }
  return false;
}

Future<Map> login(String email, String pass)async
{
  Map tokens = await  userApi.userLogin(email, pass);
  if(!tokens['success'])
  {
   return tokens;
  }
 await setTokens(tokens['accessToken'], tokens['refreshToken'],);
return {'success':true};
}

Future<bool> fetchUser()async
{
   UserDto res = await userApi.fetchUser();
   userGlobal = User(res.id, res.username, res.imageAvatar, false);
   return true;
}

Future<bool> setTokens(String newAccessToken, String newRefreshToken)async
{
accessToken = newAccessToken;
refreshToken = newRefreshToken;
await storage.setTokens(refreshToken);
return true;
}
 Future<int> checkServerVersion() async
 {
  version = await userApi.serverInfo();
  return version;
 }

    Map get  jsonData 
   {
return {
  'port': port,
  'address': address,
  'refreshToken': refreshToken,
  'name': name
};
   }
}