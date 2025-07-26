import 'package:flutter/material.dart';

import '../eventStore.dart';
import '../localization/localization.dart';


Future<bool?> acceptDialog(BuildContext context, String message) async {
  return await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.black87,
        title: const Text('Info', style: TextStyle(color: Colors.white)),
        content: Text(message, style: const TextStyle(color: Colors.white)),
        actions: <Widget>[
          TextButton(
            child: Text(
                Localization.localizationData[config.language]['messageScreen']
                    ['back'],
                style: const TextStyle(color: Colors.white)),
            onPressed: () {
              Navigator.of(context).pop(false); // Return false for cancel
            },
          ),
          TextButton(
            child: Text(
                Localization.localizationData[config.language]['messageScreen']
                    ['accept'],
                style: const TextStyle(color: Colors.white)),
            onPressed: () {
              Navigator.of(context).pop(true); // Return true for accept
            },
          ),
        ],
      );
    },
  );
}
