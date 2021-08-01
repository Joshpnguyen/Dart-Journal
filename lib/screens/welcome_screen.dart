import 'package:dart_journal/src_export.dart';
import 'package:flutter/material.dart';

class MyWelcomeHomePage extends StatefulWidget {
  const MyWelcomeHomePage(
      {Key? key, required this.title, required this.changeTheme})
      : super(key: key);

  final Function changeTheme;
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyWelcomeHomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: backButton(context),
          centerTitle: true,
          title: Text('Welcome'),
          actions: [
            Builder(
                builder: (context) => IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () => Scaffold.of(context).openEndDrawer(),
                    ))
          ],
        ),
        endDrawer: EndDrawer(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 80,
                width: 80,
                child: FittedBox(
                  child: Icon(
                    Icons.book,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              Text('Journal')
            ],
          ),
        ));
  }
}
