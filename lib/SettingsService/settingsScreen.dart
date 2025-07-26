import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:schat2/SettingsService/pickBackground.dart';
import '../allWidgets/infoDialog.dart';
import '../env.dart';
import '../eventStore.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../localization/localization.dart';
import 'addLocalPass.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  Color currentColor = config.accentColor;
  Color pickerColor = config.accentColor;
  void changeColor(Color color) {
    setState(() => config.accentColor = color);
  }

  List servers = [];

  @override
  void initState() {
    super.initState();

    getServers();
  }

  getServers() async {
    List res = await storage.getServers();
    setState(() {
      servers = res;
    });
  }

  updateLocalization(String newLocalization) async {
    setState(() {
      config.language = newLocalization;
    });

    await storage.setConfig();
  }

  updateApp() async {
    Map res = await chatApi.updateApp();
    if (res.keys.contains('Error')) {
      infoDialog(context, res['Error']);
      return;
    }
    String? directoryPath = await FilePicker.platform.getDirectoryPath();
    print('$directoryPath/${res['name']}');
    File file = File('$directoryPath/${res['name']}');
    await file.writeAsBytes(res['data']);
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
          appBar: AppBar(
            backgroundColor: config.accentColor,
            leading: BackButton(
              color: Colors.white54,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            automaticallyImplyLeading: false,
          ),
          backgroundColor: Colors.transparent,
          body: ListView(
            padding: const EdgeInsets.all(10),
            children: [
              Container(
                color: Colors.black54,
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        Localization.localizationData[config
                            .language]['settingsScreen']['language'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 10,
                      child: ListView.builder(
                        itemCount: Localization.localizationData.keys
                            .toList()
                            .length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              updateLocalization(
                                Localization.localizationData.keys
                                    .toList()[index],
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  Localization.localizationData.keys
                                      .toList()[index],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (config.language ==
                                    Localization.localizationData.keys
                                        .toList()[index])
                                  const Icon(
                                    Icons.check_box_outlined,
                                    color: Colors.green,
                                  ),
                                if (config.language !=
                                    Localization.localizationData.keys
                                        .toList()[index])
                                  const Icon(
                                    Icons.check_box_outline_blank_outlined,
                                    color: Colors.white,
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    Center(
                      child: Text(
                        Localization.localizationData[config
                            .language]['settingsScreen']['selectServer'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height:
                          (MediaQuery.of(context).size.height / 8) *
                          servers.length,
                      child: Column(
                        children: [
                          SizedBox(
                            height:
                                (MediaQuery.of(context).size.height / 15) *
                                servers.length,
                            child: ListView.builder(
                              itemCount: servers.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  color: Colors.white10,
                                  child: Row(
                                    children: [
                                      Text(
                                        servers[index],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          deleteServerDialog(context, index);
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                      if (index == 0)
                                        const Icon(
                                          Icons.check_box_outlined,
                                          color: Colors.green,
                                        ),
                                      if (index != 0)
                                        IconButton(
                                          onPressed: () async {
                                            await storage.selectServer(index);
                                            await getServers();
                                            connect();
                                          },
                                          icon: const Icon(
                                            Icons
                                                .check_box_outline_blank_outlined,
                                            color: Colors.white,
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              addServerDialog(context);
                            },
                            child: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          Localization.localizationData[config
                              .language]['settingsScreen']['notification'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          child: config.notification
                              ? const Icon(
                                  Icons.check_box_outlined,
                                  color: Colors.green,
                                )
                              : const Icon(
                                  Icons.check_box_outline_blank_outlined,
                                  color: Colors.white,
                                ),
                          onTap: () async {
                            setState(() {
                              config.notification = !config.notification;
                            });
                            await storage.setConfig();
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          Localization.localizationData[config
                              .language]['settingsScreen']['send'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          child: config.sendHotkeyCtrl
                              ? const Icon(
                                  Icons.check_box_outlined,
                                  color: Colors.green,
                                )
                              : const Icon(
                                  Icons.check_box_outline_blank_outlined,
                                  color: Colors.white,
                                ),
                          onTap: () async {
                            setState(() {
                              config.sendHotkeyCtrl = !config.sendHotkeyCtrl;
                            });
                            await storage.setConfig();
                          },
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsetsGeometry.symmetric(vertical: 2),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          pickColor(context);
                        },
                        child: Text(
                          Localization.localizationData[config
                              .language]['settingsScreen']['color'],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsetsGeometry.symmetric(vertical: 2),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  PickBackground(),
                            ),
                          );
                          setState(() {});
                        },
                        child: Text(
                          Localization.localizationData[config
                              .language]['settingsScreen']['pickBackground'],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsetsGeometry.symmetric(vertical: 2),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const AddLocalPass(),
                            ),
                          );
                        },
                        child: Text(
                          Localization.localizationData[config
                              .language]['settingsScreen']['addLocalPass'],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsetsGeometry.symmetric(vertical: 2),
                    ),
                  ],
                ),
              ),

              Text(
                'Версия приложения: ${Env.version}\nДата сборки: 21.07.2025',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Center(
                child: ElevatedButton(
                  child: Text('Проверить наличие обновлений'),
                  onPressed: () {
                    updateApp();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  addServerDialog(BuildContext context) {
    showDialog(
      barrierColor: Colors.white12,
      context: context,
      builder: (BuildContext context) {
        String server = '';
        return AlertDialog(
          backgroundColor: Colors.black87,
          content: TextField(
            onChanged: (value) {
              server = value;
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
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () async {
                await storage.setServer(server);
                await getServers();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  deleteServerDialog(BuildContext context, int index) {
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
                await storage.deleteServer(index);
                await getServers();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  pickColor(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black87,
          actions: <Widget>[
            const Padding(padding: EdgeInsets.symmetric(vertical: 3)),
            ColorPicker(pickerColor: pickerColor, onColorChanged: changeColor),
            Center(
              child: ElevatedButton(
                child: Text(
                  Localization.localizationData[config
                      .language]['settingsScreen']['select'],
                ),
                onPressed: () async {
                  setState(() => currentColor = pickerColor);
                  await storage.setConfig();
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
