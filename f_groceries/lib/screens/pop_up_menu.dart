import 'package:flutter/material.dart';

class PopUpMenu extends StatelessWidget {
  void showMenuSelection(String value) {
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
      icon: Icon(Icons.more_vert),
      onSelected: showMenuSelection,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
                value: 'Edit',
                child: ListTile(
                    title: Text('Edit'))),
            const PopupMenuItem<String>(
                value: 'Delete',
                child: ListTile(
                    title: Text('Delete')))
          ],
    );
  }
}