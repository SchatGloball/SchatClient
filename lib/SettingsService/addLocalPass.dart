import 'package:flutter/material.dart';
import '../eventStore.dart';
import '../localization/localization.dart';


class AddLocalPass extends StatefulWidget {
  const AddLocalPass({super.key});

  @override
  State<AddLocalPass> createState() => _AddLocalPass();
}

class _AddLocalPass extends State<AddLocalPass> {
  @override
  void initState() {
    super.initState();
  }
String pass = '';
bool validPass = false;

  passValidate() {
    if(pass.isEmpty)
    {
      setState(() {
        validPass = true;
      });
      return;
    }
    if(pass.length<4||pass.length>7||pass.split('').first =='0')
      {
        setState(() {
          validPass = false;
        });
        return;
      }
    int check = int.tryParse(pass)??-12;
    if(check == -12)
      {
        setState(() {
          validPass = false;
        });
      }
    else
      {
        setState(() {
          validPass = true;
        });
      }

  }



  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        'assets/${config.backgroundAsset}',
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        appBar: AppBar(
          leading: BackButton(
              color: Colors.white54,
              onPressed: (){
                Navigator.of(context).pop();}
          ),
          backgroundColor: config.accentColor,
          automaticallyImplyLeading: false,
          title:  Text('Schat', style: Theme.of(context).textTheme.titleLarge,),
        ),
        backgroundColor: Colors.transparent,
        body: Center(
            child: Container(
              width: MediaQuery.of(context).size.width / 1.3,
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(10),
                //color: Colors.yellow,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      style: Theme.of(context).textTheme.titleLarge,
                      onChanged: (String value) {
                        pass = value;
                        passValidate();
                      },
                      decoration: InputDecoration(
                        labelStyle: Theme.of(context).textTheme.titleSmall,
                        labelText: Localization.localizationData[config.language]
                        ['addLocalPass']['localPass'],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    padding: const EdgeInsets.only(top: 8),
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.white70),
                        ),
                        onPressed: validPass
    ?()async {
                          config.localPass = pass;
                      await   storage.setConfig();
                          showMyDialog(context, Localization.localizationData[config.language]
                          ['addLocalPass']['success']);
                        }: null,
                        child: Text(Localization.localizationData[config.language]
                        ['addLocalPass']['add'])),
                  ),
                ],
              ),
            )),
      )
    ]);
  }

  showMyDialog(BuildContext context, text) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
              text,
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}