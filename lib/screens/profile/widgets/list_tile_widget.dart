import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Widget? trailingWidget;
  final VoidCallback onPressed;

  const ListTileWidget({
    super.key,
    required this.iconData,
    required this.title,
    required this.onPressed,
    this.trailingWidget,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = ThemeData();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: ListTile(
        splashColor: theme.splashColor,
        minTileHeight: 60,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1.5,
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          title,
        ),
        leading: Icon(iconData),
        trailing: trailingWidget,
        onTap: onPressed,
      ),
    );
  }
}