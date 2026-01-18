import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:schat2/eventStore.dart';
import 'package:schat2/localization/localization.dart';

class LanguageSwitcher extends StatefulWidget {
   final VoidCallback updateParent;
  final bool initialValue;
  final ValueChanged<bool>? onChanged;

  const LanguageSwitcher({
    required this.updateParent,
    super.key,
    this.initialValue = false,
    this.onChanged,
  });

  @override
  State<LanguageSwitcher> createState() => _LanguageSwitcher();
}

class _LanguageSwitcher extends State<LanguageSwitcher> {


  @override
  void initState() {
    // FlutterLocalization не поддерживает веб-платформу
    if (!config.isWeb) {
      try {
        localization.init(
          mapLocales: [
            MapLocale('en', AppLocale.EN),
            MapLocale('ru', AppLocale.RU),
          ],
          initLanguageCode: config.language,
        );
        localization.onTranslatedLanguage = _onTranslatedLanguage;
      } catch (e) {
        print('Localization init error: ${e.toString()}');
      }
    }
    super.initState();
  }
void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
}
   @override
  void dispose() {
    if (!config.isWeb) {
      localization.onTranslatedLanguage = null;
    }
    super.dispose();
  }


 void switchLanguage(String selectLanguage)async
 {
  config.language = selectLanguage;
  
  await storage.setConfig();
  if (!config.isWeb) {
    try {
      // Переинициализируем локализацию с новым языком
      localization.init(
        mapLocales: [
          MapLocale('en', AppLocale.EN),
          MapLocale('ru', AppLocale.RU),
        ],
        initLanguageCode: selectLanguage,
      );
    } catch (e) {
      print('Localization reinit error: ${e.toString()}');
    }
  }
  _onTranslatedLanguage(Locale(selectLanguage));
  widget.updateParent();
 }

  // Вспомогательная функция для получения имени языка с поддержкой веб
  String _getLanguageName(String languageCode) {
    if (config.isWeb) {
      // Fallback для веб-платформы
      switch (languageCode) {
        case 'ru':
          return 'Русский';
        case 'en':
          return 'English';
        default:
          return languageCode.toUpperCase();
      }
    } else {
      try {
        return localization.getLanguageName(languageCode: languageCode);
      } catch (e) {
        // Fallback в случае ошибки
        switch (languageCode) {
          case 'ru':
            return 'Русский';
          case 'en':
            return 'English';
          default:
            return languageCode.toUpperCase();
        }
      }
    }
  }

  @override
 Widget build(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 4),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(config.containerRadius),
      color: Colors.black54,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Ярлык "Language"
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(config.containerRadius),
            ),
            child: Center(
              child: Text(
                getLocalizedString('language'),
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        
        // Кнопка русского языка
        Expanded(
          child: InkWell(
            onTap: () => switchLanguage('ru'),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                color: config.language == 'ru' 
                  ? Colors.white60 
                  : Colors.black54,
                borderRadius: BorderRadius.circular(config.containerRadius),
              ),
              child: Center(
                child: Text(
                  _getLanguageName('ru'),
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
        
        // Кнопка английского языка
        Expanded(
          child: InkWell(
            onTap: () => switchLanguage('en'),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                color: config.language == 'en' 
                  ? Colors.white60 
                  : Colors.black54,
                borderRadius: BorderRadius.circular(config.containerRadius),
              ),
              child: Center(
                child: Text(
                  _getLanguageName('en'),
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
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