import 'package:dart_journal/src_export.dart';
import 'package:flutter/material.dart';

class AddEntry extends StatelessWidget {
  const AddEntry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('New Journal Entry'),
        actions: [
          Builder(
              builder: (context) => IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                  ))
        ],
      ),
      endDrawer: drawer(),
      body: Form(child: TextFormField()),
    );
  }
}
