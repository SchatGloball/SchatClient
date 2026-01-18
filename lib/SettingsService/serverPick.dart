import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schat2/DataClasses/configuration.dart';
import 'package:schat2/DataClasses/server.dart';
import 'package:schat2/SettingsService/serverCard.dart';
import 'package:schat2/allWidgets/acceptDialog.dart';
import 'package:schat2/allWidgets/infoDialog.dart';
import 'package:schat2/main.dart';
import '../eventStore.dart';
import '../localization/localization.dart';

class ServerPick extends StatefulWidget {
  const ServerPick({super.key});

  @override
  State<ServerPick> createState() => _ServerPick();
}

class _ServerPick extends State<ServerPick> {
  List<BackendServer> servers = [];
  bool checkUnicalName = false;
  @override
  void initState() {
    super.initState();

    getServers();
  }

  getServers() async {
    servers.clear();
    Map res = await storage.getAppConfig();
    for (Map s in res['servers']) {
      BackendServer server = BackendServer(s['port'], s['address'], '', s['name'], isWeb: false);
      await server.checkServerVersion();
      servers.add(
        server
      );
    }
    setState(() {});
  }

  void editServer(BackendServer server)
  {
addServerDialog(context, server, true);
  }

  removeServer(BackendServer server)
  {
    if(servers.length >2||server.name == config.server.name)
    {
infoDialog(context, 'Remove?');
    }
    else{
deleteServerDialog(context, server);
    }
    
  }

  selectServer(BackendServer server)async
  {
    bool? check =  await acceptDialog(context, 'message');
    
      
    if(check == true)
    {
      await storage.selectServer(server.name);
    }
    Map c = await storage.getAppConfig();
    config = Configuration(c, isWeb: config.isWeb);
    allChats.clear();
    Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => InitialApp(checkLocalPass: false),
          ));
  }

  @override
  Widget build(BuildContext context) {
    return
     LayoutBuilder(
      builder: (context, constraints) {
        final screenSize = MediaQuery.of(context).size;
        double size = screenSize.width > screenSize.height?config.maxHeightWidescreen:0.95;
    return Stack(
      children: [
        Image.asset(
          'assets/${config.backgroundAsset}',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            automaticallyImplyLeading: false,
          ),
          body:
          
          Center(child: SizedBox(
             width: MediaQuery.of(context).size.width * size,
            child: ListView.builder(
            itemCount: servers.length,
            itemBuilder: (context, index) {
              return ServerCard(server: servers[index], editServer: editServer, removeServer: removeServer, selectServer: selectServer,);
            },
          ),
          ),)
           ,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black54,
            onPressed: () async {
              setState(() {
                checkUnicalName = false;
              });
              addServerDialog(
                context,
                BackendServer(
                  config.isWeb ? 4401 : 4400,
                  'localhost',
                  '',
                  'newServer',
                  isWeb: config.isWeb ? true : false
                ),
                false
              );
            },
            child: Icon(Icons.add),
          ),
        ),
      ],
    );});
  }

  void addServerDialog(BuildContext context, BackendServer server, bool isEdit) {
    showDialog(
      barrierColor: Colors.white12,
      context: context,
      builder: (BuildContext context) {
        String oldNameServer = server.name;
        editSelect()
        {
         return oldNameServer == config.server.name?true:false;
        }
        final TextEditingController nameController = TextEditingController(
          text: server.name,
        );
        final TextEditingController addressController = TextEditingController(
          text: server.address,
        );
        final TextEditingController portController = TextEditingController(
          text: server.port.toString(),
        );
        return StatefulBuilder(
          builder: (context, setState) {
           bool isEditSelectServer = editSelect();
            return AlertDialog(
              backgroundColor: Colors.black87,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    onChanged: (value) {
                      setState(() {
                        checkUnicalName = false;
                      });
                      server.name = value;
                    },
                    decoration: InputDecoration(
                      labelStyle: Theme.of(context).textTheme.titleLarge,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      labelText: 'Name',
                    ),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Padding(
                    padding: EdgeInsetsGeometry.symmetric(vertical: 5),
                  ),
                  if (checkUnicalName)
                    Text(
                      'Имя должно быть уникальным',
                      style: TextStyle(color: Colors.red),
                    ),
                  TextField(
                    controller: addressController,
                    onChanged: (value) {
                      server.address = value;
                    },
                    decoration: InputDecoration(
                      labelStyle: Theme.of(context).textTheme.titleLarge,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      labelText:
                          Localization.localizationData[config
                              .language]['settingsScreen']['exampleServer'],
                    ),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Padding(
                    padding: EdgeInsetsGeometry.symmetric(vertical: 5),
                  ),
                  TextField(
                    controller: portController,
                    onChanged: (value) {
                      server.port = int.tryParse(value) ?? 4400;
                    },
                    keyboardType: const TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                      labelStyle: Theme.of(context).textTheme.titleLarge,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      labelText: 'port',
                    ),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () async {
                    if(isEdit)
                    {
             
await storage.editServer(server, oldNameServer);
if(isEditSelectServer)
{
      await storage.selectServer(server.name);  
    Map c = await storage.getAppConfig();
    config = Configuration(c, isWeb: config.isWeb);
    allChats.clear();
    Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => InitialApp(checkLocalPass: false),
          ));
}
                    }
                    else
                    {
for (BackendServer s in servers) {
                      if (server.name == s.name) {
                        setState(() {
                          checkUnicalName = true;
                        });
                        return;
                      }
                    }

                    await storage.setServer(server);
                    }
                     await getServers();
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  deleteServerDialog(BuildContext context, BackendServer server) {
    showDialog(
      barrierColor: Colors.white12,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black87,
          content: Text(
            Localization.localizationData[config
                .language]['settingsScreen']['deleteServer'],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () async {
                await storage.deleteServer(server);
                await getServers();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
