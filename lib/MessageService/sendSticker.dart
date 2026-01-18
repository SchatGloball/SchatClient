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
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Column(
            children: [
              IconButton(
                onPressed: () {
                  updateParent();
                },
                icon: Icon(Icons.highlight_remove),
              ),
              IconButton(
                onPressed: () {
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
                icon: Icon(Icons.skip_next),
              ),
            ],
          ),
          Expanded(
            child: SizedBox(
              height: 100,
              child: Scrollbar(
                controller: stickerScrollController,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: stickerScrollController,
                  itemCount: config.stickersAssets[selectStickerPack].length,
                  itemBuilder: (context, indexTwo) {
                    return InkWell(
                      onTap: () async {
                        Map send = await config.server.chatApi.sendMessages(
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
