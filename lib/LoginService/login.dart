import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../AllChatService/allChat.dart';
import '../RegistrationService/registration.dart';
import '../SettingsService/settingsScreen.dart';
import '../eventStore.dart';
import '../localization/localization.dart';
import '../main.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  @override
  void initState() {
    super.initState();
  }

  String userEmail = '';
  String userPassword = '';

  bool validEmail = true;
  bool validPass = false;

  emailValidate() {
    setState(() {
      validEmail = EmailValidator.validate(userEmail);
    });
  }

  login() async {
    Map tokens = await userApi.userLogin(userEmail, userPassword);

    if (tokens.keys.first == 'Error') {
      showMyDialog(context, tokens['Error'].toString());
    } else {
      userGlobal.setTokens(tokens['accessToken'], tokens['refreshToken']);
      showMyDialog(
          context,
          Localization.localizationData[config.language]['loginScreen']
              ['loginSuccess']);
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
              Text(
                  Localization.localizationData[config.language]['loginScreen']
                      ['title'],
                  style: Theme.of(context).textTheme.titleMedium),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: TextField(
                  style: Theme.of(context).textTheme.titleLarge,
                  onChanged: (String value) {
                    userEmail = value;
                    emailValidate();
                  },
                  decoration: InputDecoration(
                    labelStyle: Theme.of(context).textTheme.titleSmall,
                    labelText: Localization.localizationData[config.language]
                        ['loginScreen']['login'],
                  ),
                ),
              ),
              Column(
                children: [
                  if (!validEmail)
                    Text(
                      Localization.localizationData[config.language]
                          ['loginScreen']['emailValidate'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red),
                    )
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: TextField(
                  style: Theme.of(context).textTheme.titleLarge,
                  onChanged: (String value) {
                    userPassword = value;
                    if (userPassword.length <= 5) {
                      setState(() {
                        validPass = false;
                      });
                    } else {
                      setState(() {
                        validPass = true;
                      });
                    }
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    labelStyle: Theme.of(context).textTheme.titleSmall,
                    labelText: Localization.localizationData[config.language]
                        ['loginScreen']['password'],
                  ),
                ),
              ),
              Column(
                children: [
                  if (!validPass)
                    Text(
                      Localization.localizationData[config.language]
                          ['loginScreen']['passwordValidate'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red),
                    )
                ],
              ),
              Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  padding: const EdgeInsets.only(top: 16),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.white70),
                      ),
                      onPressed: validEmail && validPass
                          ? () async {
                              login();
                            }
                          : null,
                      child: Text(Localization.localizationData[config.language]
                          ['loginScreen']['goButton']))),
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                padding: const EdgeInsets.only(top: 8),
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.white70),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const RegistrationPage()));
                    },
                    child: Text(Localization.localizationData[config.language]
                        ['loginScreen']['registrationButton'])),
              ),
            ],
          ),
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const SettingsPage()));
          },
          backgroundColor: Colors.black54,
          child: Icon(
            Icons.settings_outlined,
            color: config.accentColor,
          ),
        ),
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
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  InitialApp(checkLocalPass: false,)));
                },
              ),
            ],
          );
        });
  }
}
