import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../eventStore.dart';






// ignore: must_be_immutable
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
       InkWell(
                onTap: () async {
                  final Uri url = Uri.parse(link);
                  if (await launchUrl(
                    url,
                    mode: LaunchMode.externalApplication, // Рекомендуется для внешних ссылок
                    webOnlyWindowName: '_blank', // Это заставляет открывать в новой вкладке
                  )) {                    // Ссылка успешно открыта
                  
                  } else {
                    // Не удалось открыть ссылку
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Не удалось открыть ссылку: $link')),
                    );
                  }
                },
                child: Text(
                  link,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    decoration: TextDecoration.underline, // Для визуализации ссылки
                    color: Colors.blue, // Или другой цвет для ссылки
                  ),
                ),
              )
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
     )
      ;
  }
}