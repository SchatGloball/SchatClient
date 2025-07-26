import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';

import '../eventStore.dart';





class WebPreview extends StatelessWidget {
  WebPreview({
    super.key,
    required this.link
  });

  late String link;


  @override
  Widget build(BuildContext context) {
    return
    config.isWeb?
        ElevatedButton(onPressed: (){}, child: Text(link))
        // InkWell(
        //   onTap: (){},
        //   child:
        //   Container(
        //       padding: const EdgeInsets.all(5),
        //       child:  Text(link)
        //   ),
        // )

        :
      Container(
          padding: const EdgeInsets.all(5),
          child: AnyLinkPreview(
            link: link,
            displayDirection: UIDirection.uiDirectionVertical,
            showMultimedia: true,
            bodyMaxLines: 8,
            bodyTextOverflow: TextOverflow.ellipsis,
            titleStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            bodyStyle: const TextStyle(color: Colors.grey, fontSize: 12),
          )
      );
  }
}