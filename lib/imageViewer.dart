import 'package:flutter/material.dart';


import 'downloadFile.dart';
import 'eventStore.dart';



class ImageViewerPage extends StatelessWidget {
 ImageViewerPage({
super.key,
required this.image
});

late String image;


@override
Widget build(BuildContext context) {
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
  backgroundColor: config.accentColor,
leading: BackButton(
onPressed: (){

Navigator.of(context).pop();}

),
automaticallyImplyLeading: false,
  actions: [
    IconButton(onPressed: (){
      downloadFile(
      fileExtension: image.split('?X').first.split('.').last,
      url:  image
      );}, icon: const Icon(Icons.save))
  ],
),
backgroundColor: Colors.transparent,
body:
 ListView(
      children: [Column(
  
  children: [
   InteractiveViewer(
  child: Image.network(
    image,
  fit: BoxFit.contain,
  ),
    )
  
  ],
  )])

,)]);
}
}