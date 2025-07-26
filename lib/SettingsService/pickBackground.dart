import 'package:flutter/material.dart';

import '../eventStore.dart';

class PickBackground extends StatelessWidget {
  PickBackground({
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
      backgroundColor: Colors.grey,
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
      body: Container(
        padding: const EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - kToolbarHeight,
        child: GridView.builder(
          itemCount: config.backgroundList.length,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
            2, // количество виджетов в ряду
            childAspectRatio: 1.3,
          ),
          shrinkWrap:
          true, // позволяет списку занимать только необходимое пространство
          itemBuilder:
              (BuildContext context, int index) {
            return
              InkWell(
                onTap: ()async{
                  config.backgroundAsset = config.backgroundList[index];
                  await storage.setConfig();
                  Navigator.pop(context);
                },
                child: Image.asset(
                  'assets/${config.backgroundList[index]}',
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              );
          },
        )
        ,
      ),
    );
  }
}