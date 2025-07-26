import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:schat2/allWidgets/infoDialog.dart';
import '../eventStore.dart';

class SendSticker extends StatefulWidget {
  final VoidCallback updateParent;
  final int chatId;
  SendSticker({super.key, required this.updateParent, required this.chatId});
  @override
  State<SendSticker> createState() =>
      _SendSticker(updateParent: updateParent, chatId: chatId);
}

class _SendSticker extends State<SendSticker> {
  ScrollController stickerScrollController = ScrollController();
  final int chatId;

  final VoidCallback updateParent;
  _SendSticker({required this.updateParent, required this.chatId});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.17 - kToolbarHeight,
      padding: const EdgeInsets.only(left: 4, right: 4),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
            height: MediaQuery.of(context).size.height * 0.17,
            child: InkWell(
              onTap: () {
                updateParent();
              },
              child: Icon(
                Icons.highlight_remove,
                color: config.accentColor,
                size: 40,
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
            height: MediaQuery.of(context).size.height * 0.17,
            child: InkWell(
              onTap: () {
                if (selectStickerPack + 1 < config.stickersAssets.length) {
                  setState(() {
                    ++selectStickerPack;
                  });
                } else {
                  setState(() {
                    selectStickerPack = 0;
                  });
                }
              },
              child: Lottie.asset(
                'assets/${config.stickersAssets[selectStickerPack].first}.json',
              ),
            ),
          ),
          SizedBox(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.44,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Scrollbar(
                controller: stickerScrollController,
                // thickness: 12.0,
                // radius: Radius.circular(8.0),
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: stickerScrollController,
                  itemCount: config.stickersAssets[selectStickerPack].length,
                  itemBuilder: (context, indexTwo) {
                    return InkWell(
                      onTap: () async {
                        Map send = await chatApi.sendMessages(
                          chatId,
                          'sticker${config.stickersAssets[selectStickerPack][indexTwo]}',
                          [],
                          config.stickersAssets[selectStickerPack][indexTwo],
                        );
                        if (send.keys.first == 'Error') {
                          infoDialog(context, send['Error']);
                        } else {
                          updateParent();
                        }
                      },
                      child: Lottie.asset(
                        'assets/${config.stickersAssets[selectStickerPack][indexTwo]}.json',
                      ),
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, // количество виджетов в ряду
                    childAspectRatio: 5 / 5,
                  ),
                  // запрещает прокрутку списка
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
