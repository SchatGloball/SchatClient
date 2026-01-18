import 'package:flutter/material.dart';
import 'package:schat2/eventStore.dart';


class NotificationSwitcher extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool>? onChanged;

  const NotificationSwitcher({
    super.key,
    this.initialValue = false,
    this.onChanged,
  });

  @override
  State<NotificationSwitcher> createState() => _NotificationSwitcher();
}

class _NotificationSwitcher extends State<NotificationSwitcher> {


  @override
  void initState() {
  
    super.initState();
   
  }

   @override
  void dispose() {
    super.dispose();
  }


 void switchNotification()async
 {
  setState(() {
     config.notification = !config.notification;
 
  });
await storage.setConfig();
 }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(config.containerRadius), color: Colors.black54,),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(config.containerRadius)), child: 
          Center(child:  Text(getLocalizedString('notification'), style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
          )),))
        ,Expanded(
          child:
          InkWell(child: 
          Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          decoration: BoxDecoration(color: config.notification? Colors.white60:Colors.black54, borderRadius: BorderRadius.circular(config.containerRadius)), child: 
          Center(child:  Text('on', style: Theme.of(context).textTheme.titleMedium,)),),
          onTap: (){
switchNotification();
          },)
          )
        , 
        Expanded(
          child:
        InkWell(child:  Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
         decoration: BoxDecoration(color: !config.notification? Colors.white60:Colors.black54, borderRadius: BorderRadius.circular(config.containerRadius)),
        child: Center(child:  Text('off', style: Theme.of(context).textTheme.titleMedium,)),),
        onTap: (){
            switchNotification();
          },
        ))
      ],),);
  }
}