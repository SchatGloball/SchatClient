import 'package:flutter/material.dart';
import 'package:schat2/eventStore.dart';


class ThemeSwitcher extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool>? onChanged;
 final VoidCallback updateParent;
  const ThemeSwitcher({
    super.key,
    required this.updateParent,
    this.initialValue = false,
    this.onChanged,
  });

  @override
  State<ThemeSwitcher> createState() => _CompactThemeSwitcherState();
}

class _CompactThemeSwitcherState extends State<ThemeSwitcher> {
  

  void _toggleTheme(bool isDark) async {
    if (config.isDarkTheme != isDark) {
      setState(() {
        config.isDarkTheme = isDark;
      });
      await storage.setConfig();
      if (widget.onChanged != null) {
        widget.onChanged!(config.isDarkTheme);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(config.containerRadius),
        color: Colors.black54,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
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
                getLocalizedString('theme'),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          )),
          Expanded(
          child:
          InkWell(
            onTap: () => _toggleTheme(true),
            child:  Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                color: config.isDarkTheme ? Colors.white70 : Colors.black54,
                borderRadius: BorderRadius.circular(config.containerRadius),
              ),
              child: Center(
                child: Text(
                  getLocalizedString('dark'),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            )),
          ),
          Expanded(
          child:
          InkWell(
            onTap: () => _toggleTheme(false),
            child:  Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                color: !config.isDarkTheme ? Colors.white70 : Colors.black54,
                borderRadius: BorderRadius.circular(config.containerRadius),
              ),
              child: Center(
                child: Text(
                  getLocalizedString('light'),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }
}