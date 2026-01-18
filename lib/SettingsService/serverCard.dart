import 'package:flutter/material.dart';
import 'package:schat2/DataClasses/server.dart';
import 'package:schat2/eventStore.dart';

class ServerCard extends StatelessWidget {
  final BackendServer server;
  final void Function(BackendServer server) editServer;
  final void Function(BackendServer server) removeServer;
final void Function(BackendServer server) selectServer;
  const ServerCard({
    Key? key,
    required this.server,
    required this.editServer,
    required this.removeServer,
    required this.selectServer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Card(
        color: server.name == config.server.name?config.accentColor:Colors.black26,
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.offline_share,
                    color: server.version > 0 ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                    server.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  IconButton(
                    onPressed: () => editServer(server),
                    icon: Icon(
                      Icons.edit,
                    
                    ),
                  ),
                  IconButton(
                    onPressed: () => removeServer(server),
                    icon: Icon(
                      Icons.delete,
                      
                    ),
                  ),
                  IconButton(
                    onPressed: () => selectServer(server),
                    icon: Icon(
                      Icons.on_device_training,
                      
                    ),
                  ),
                ],
              ),
              const Divider(height: 5.0),
              Row(
                children: [
                  Text(
                    'Address:',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  Text(
                    server.address,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              const Divider(height: 5.0),
              Row(
                children: [
                  Text(
                    'Port:',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  Text(
                    '${server.port}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              const Divider(height: 5.0),
              Row(
                children: [
                  Text(
                    'Version:',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  Text(
                    server.version.toString(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}