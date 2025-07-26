import 'package:flutter/material.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';
import 'appTheme.dart';
import 'eventStore.dart';
import 'main.dart';

class CalcButton extends StatefulWidget {
  const CalcButton({Key? key}) : super(key: key);

  @override
  CalcButtonState createState() => CalcButtonState();
}

class CalcButtonState extends State<CalcButton> {
  double? _currentValue = 0;
  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width >
        MediaQuery.of(context).size.height) {
      config.widescreen = true;
    } else {
      config.widescreen = false;
    }
    var calc = SimpleCalculator(
      value: _currentValue!,
      hideExpression: false,
      hideSurroundingBorder: true,
      autofocus: true,
      onChanged: (key, value, expression) {
        setState(() {
          _currentValue = value ?? 0;
        });
        if(value.toString().split('.').first == config.localPass)
          {

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => MaterialApp(
                          home: InitialApp(checkLocalPass: false,),
                          darkTheme: darkTheme,
                          themeMode: ThemeMode.dark,
                        )),
                        (Route<dynamic> route) => false);


          }
// print(value.toString().split('.').first);
//           print('$key\t$value\t$expression');

      },
      onTappedDisplay: (value, details) {

         // print('$value\t${details.globalPosition}');

      },
      theme: const CalculatorThemeData(
        borderColor: Colors.black,
        borderWidth: 2,
        displayColor: Colors.black,
        displayStyle: TextStyle(fontSize: 80, color: Colors.yellow),
        expressionColor: Colors.indigo,
        expressionStyle: TextStyle(fontSize: 20, color: Colors.white),
        operatorColor: Colors.pink,
        operatorStyle: TextStyle(fontSize: 30, color: Colors.white),
        commandColor: Colors.orange,
        commandStyle: TextStyle(fontSize: 30, color: Colors.white),
        numColor: Colors.grey,
        numStyle: TextStyle(fontSize: 50, color: Colors.white),
        equalColor: Colors.blue,
        equalStyle: TextStyle(fontSize: 50, color: Colors.black),
      ),
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Simple calc'), backgroundColor: Colors.blueAccent,),
      backgroundColor: Colors.blueAccent,
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: calc),
    )
             ;
            }

}