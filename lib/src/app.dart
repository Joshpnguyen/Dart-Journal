import 'package:flutter/material.dart';
import 'package:dart_journal/src_export.dart';

bool darkMode = false; // false = light mode, true = dark mode
final ValueNotifier<bool> _darkMode = ValueNotifier<bool>(darkMode);

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode changeTheme() {
    if (darkMode) {
      return ThemeMode.dark;
    }
    return ThemeMode.light;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Journal Entries',
        changeTheme: changeTheme(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title, required this.changeTheme})
      : super(key: key);
  final String title;
  final ThemeMode changeTheme;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          )
        ],
      ),
      endDrawer: EndDrawer(),
      body: Center(child: Text('Work in progress')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          displayAddEntry(context);
        },
        tooltip: 'New jounral entry',
        child: Icon(Icons.add),
      ),
    );
  }

  // go to Add Entry screen
  void displayAddEntry(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddEntry()));
  }

  void rebuild() {
    setState(() {});
  }
}
