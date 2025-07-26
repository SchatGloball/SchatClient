import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../LoginService/login.dart';
import '../SettingsService/settingsScreen.dart';
import '../eventStore.dart';
import '../localization/localization.dart';


class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPage();
}

class _RegistrationPage extends State<RegistrationPage> {
  @override
  void initState() {
    super.initState();
  }

  String userEmail = '';
  String userName = '';
  String userPassword = '';
  String userRePassword = '';

  bool validEmail = true;
  bool validName = false;
  bool validPass = false;
  bool validRePass = false;

  emailValidate() {
    setState(() {
      validEmail = EmailValidator.validate(userEmail);
    });
  }

  passValidate() {
    if (userPassword.length <= 5) {
      validPass = false;
    } else {
      validPass = true;
    }
    if (userPassword == userRePassword) {
      validRePass = true;
    } else {
      validRePass = false;
    }
    setState(() {});
  }

  registration() async {
    Map tokens =
        await userApi.userRegistration(userName, userEmail, userPassword);
    if (tokens.keys.first == 'Error') {
      showErrorDialog(context, tokens['Error'].toString());
    } else {
      showMyDialog(
          context,
          Localization.localizationData[config.language]['registrationScreen']
              ['registrationSuccess']);
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
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                Localization.localizationData[config.language]
                    ['registrationScreen']['title'],
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: TextField(
                  style: Theme.of(context).textTheme.titleLarge,
                  onChanged: (String value) {
                    userName = value;
                    setState(() {
                      if (userName.length > 2 && !userName.contains(' ')) {
                        validName = true;
                      } else {
                        validName = false;
                      }
                    });
                  },
                  decoration: InputDecoration(
                    labelStyle: Theme.of(context).textTheme.titleSmall,
                    labelText: Localization.localizationData[config.language]
                        ['registrationScreen']['login'],
                  ),
                ),
              ),
              Column(
                children: [
                  if (!validName)
                    Text(
                      Localization.localizationData[config.language]
                          ['registrationScreen']['userNameValidate'],
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
                    userEmail = value;
                    emailValidate();
                  },
                  decoration: InputDecoration(
                    labelStyle: Theme.of(context).textTheme.titleSmall,
                    labelText: Localization.localizationData[config.language]
                        ['registrationScreen']['email'],
                  ),
                ),
              ),
              Column(
                children: [
                  if (!validEmail)
                    Text(
                      Localization.localizationData[config.language]
                          ['registrationScreen']['emailValidate'],
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
                    passValidate();
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    labelStyle: Theme.of(context).textTheme.titleSmall,
                    labelText: Localization.localizationData[config.language]
                        ['registrationScreen']['password'],
                  ),
                ),
              ),
              Column(
                children: [
                  if (!validPass)
                    Text(
                      Localization.localizationData[config.language]
                          ['registrationScreen']['passwordValidate'],
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
                    userRePassword = value;
                    passValidate();
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    labelStyle: Theme.of(context).textTheme.titleSmall,
                    labelText: Localization.localizationData[config.language]
                        ['registrationScreen']['rePassword'],
                  ),
                ),
              ),
              Column(
                children: [
                  if (!validRePass)
                    Text(
                      Localization.localizationData[config.language]
                          ['registrationScreen']['rePasswordValidate'],
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
                    onPressed:
                        validEmail && validName && validPass && validRePass
                            ? () {
                                registration();
                              }
                            : null,
                    child: Text(Localization.localizationData[config.language]
                        ['registrationScreen']['goButton'])),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                padding: const EdgeInsets.only(top: 8),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.white70),
                    ),
                    child: Text(Localization.localizationData[config.language]
                        ['registrationScreen']['back'])),
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
      ),
    ]);
  }
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
              child: Text(Localization.localizationData[config.language]
                  ['registrationScreen']['modalButtonLogin']),
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => const Login()));
              },
            ),
          ],
        );
      });
}

showErrorDialog(BuildContext context, text) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            text,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(Localization.localizationData[config.language]
                  ['registrationScreen']['modalButtonLogin']),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}
