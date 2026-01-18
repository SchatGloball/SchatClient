import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schat2/SettingsService/languageSwitcher.dart';
import 'package:schat2/SettingsService/notificatioSwitcher.dart';
import 'package:schat2/SettingsService/pickBackground.dart';
import 'package:schat2/SettingsService/serverPick.dart';
import 'package:schat2/SettingsService/themeSwitcher.dart';
import 'package:schat2/theme/themeProvider.dart';
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
    setState(() {
      config.accentColor = color;
      pickerColor = color;
    });
  }

refreshData()
{
  setState(() {
    
  });
}

  @override
  void initState() {
    super.initState();

  }

 @override
  void dispose() {
    super.dispose();
  }



  updateApp() async {
    Map res = await config.server.chatApi.updateApp();
    if (res.keys.contains('Error')) {
      infoDialog(context, res['Error']);
      return;
    }
    String? directoryPath = await FilePicker.platform.getDirectoryPath();
    File file = File('$directoryPath/${res['name']}');
    await file.writeAsBytes(res['data']);
  }

  @override
  Widget build(BuildContext context) {
    return 
    LayoutBuilder(
      builder: (context, constraints) {
        final screenSize = MediaQuery.of(context).size;
                double size = screenSize.width > screenSize.height?config.maxHeightWidescreen:0.95;

        return
    Stack(
      children: [
        Image.asset(
          'assets/${config.backgroundAsset}',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          appBar: AppBar(
          ),
          body: Center(child: SizedBox(
            width: MediaQuery.of(context).size.width * size,
            child: ListView(
            padding: const EdgeInsets.all(10),
            children: [
              Column(
                children: [
                  InkWell(child: 
                  Container(
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: MediaQuery.of(context).size.width* 0.05),
                        decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(config.containerRadius)), child: Center(child:  
                        Text(getLocalizedString('colorsPick'), style: Theme.of(context).textTheme.titleLarge,)),),
                        onTap: (){ pickColor(context);},
                        )
                  ,
                  const Padding(
                    padding: EdgeInsetsGeometry.symmetric(vertical: 2),
                  ),
              
                  InkWell(child: 
                  Container(
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: MediaQuery.of(context).size.width* 0.05),
                        decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(config.containerRadius)), child: Center(child:  
                        Text(getLocalizedString('pickBackground'), style: Theme.of(context).textTheme.titleLarge,)),),
                        onTap: ()async{  await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                PickBackground(),
                          ),
                        );
                        setState(() {});},
                        ),
                  
                  const Padding(
                    padding: EdgeInsetsGeometry.symmetric(vertical: 2),
                  ),
                  InkWell(child: 
                  Container(
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: MediaQuery.of(context).size.width* 0.05),
                        decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(config.containerRadius)), child: Center(child:  
                        Text(getLocalizedString('addLocalPass'), style: Theme.of(context).textTheme.titleLarge,)),),
                        onTap: ()async{  await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const AddLocalPass(),
                          ),
                        );},
                        ),
                        const Padding(
                    padding: EdgeInsetsGeometry.symmetric(vertical: 2),
                  ),
                  InkWell(child: 
                  Container(
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: MediaQuery.of(context).size.width* 0.05),
                        decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(config.containerRadius)), child: Center(child:  
                        Text(getLocalizedString('selectServer'), style: Theme.of(context).textTheme.titleLarge,)),),
                        onTap: ()async{   await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>  const ServerPick()));},
                        ),
                        const Padding(
                    padding: EdgeInsetsGeometry.symmetric(vertical: 2),
                  ),
                  
              LanguageSwitcher(updateParent: refreshData,),
              const Padding(
                    padding: EdgeInsetsGeometry.symmetric(vertical: 2),
                  ),
              ThemeSwitcher(updateParent: refreshData,),
               const Padding(
                    padding: EdgeInsetsGeometry.symmetric(vertical: 2),
                  ),
              NotificationSwitcher(),
                                     
              
                  const Padding(
                    padding: EdgeInsetsGeometry.symmetric(vertical: 2),
                  ),
                 
                  const Padding(
                    padding: EdgeInsetsGeometry.symmetric(vertical: 2),
                  ),
                ],
              ),

              Text(
                'Версия приложения: ${Env.version}\nДата сборки: 01.12.2025',
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
          ),) 
          
          ,
        ),
      ],
    );
  }
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
                  final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
                  config.accentColor = pickerColor;
                  themeProvider.updateAccentColor(pickerColor);
                  await storage.setConfig();
                  Navigator.of(context).pop();
                  setState(() {});
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
