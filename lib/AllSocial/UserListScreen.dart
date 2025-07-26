import 'package:flutter/material.dart';
import 'package:schat2/user/userScreen.dart';
import '../eventStore.dart';


class UserListPage extends StatefulWidget {
  late List<String> userList;
  UserListPage({super.key, required this.userList});

  @override
  State<UserListPage> createState() => _UserListPage(userList: userList);
}

class _UserListPage extends State<UserListPage> {

  _UserListPage({required this.userList});
  @override
  void initState() {
    super.initState();
  }

  late List<String> userList;

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/${config.backgroundAsset}',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: config.accentColor,
              leading: BackButton(onPressed: () {
                Navigator.of(context).pop();
              }),
              automaticallyImplyLeading: false,
              title: Text('users'),
            ),
          body: ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  return InkWell(child: Container(
                    color: Colors.black45,
                    padding: const EdgeInsetsGeometry.all(3), child: Text(userList[index], style: Theme.of(context).textTheme.titleLarge,), ), onTap: ()async{
                    if(userGlobal.userName!=userList[index])
                      {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>  UserPage(userName: userList[index])));
                      }

                  },);
                },
              )
        )
      ],
    );
  }
}
