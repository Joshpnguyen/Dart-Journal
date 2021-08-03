import 'package:dart_journal/src_export.dart';
import 'package:flutter/material.dart';

class EndDrawer extends StatefulWidget {
  // const EndDrawer({Key? key}) : super(key: key);

  @override
  _EndDrawerState createState() => _EndDrawerState();
}

class _EndDrawerState extends State<EndDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        ListTile(
            contentPadding: EdgeInsets.only(top: 15, left: 15, bottom: 0),
            leading: Text('Settings',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600))),
        Divider(
          thickness: 0.0,
          color: Colors.grey,
        ),
        SwitchListTile(
            title: Text('Dark Mode'),
            value: darkMode,
            onChanged: (bool value) async {
              setState(() {
                darkMode = value;
              });
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              prefs.setBool('darkMode', darkMode);
            })
      ],
    ));
  }
}
