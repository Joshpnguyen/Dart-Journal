import 'package:dart_journal/src_export.dart';
export 'package:flutter/material.dart';

// Widget for Settings drawer
Widget drawer() {
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
      DarkModeSwitch(),
    ],
  ));
}

// Widget switch for Dark Mode
class DarkModeSwitch extends StatefulWidget {
  const DarkModeSwitch({Key? key}) : super(key: key);

  @override
  _DarkModeSwitchState createState() => _DarkModeSwitchState();
}

class _DarkModeSwitchState extends State<DarkModeSwitch> {
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
        title: Text('Dark Mode'),
        value: darkMode,
        onChanged: (bool value) {
          setState(() {
            print('$value');
            darkMode = value;
          });
        });
  }
}
