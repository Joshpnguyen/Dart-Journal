import 'package:dart_journal/src_export.dart';
import 'package:flutter/material.dart';

class AddEntry extends StatefulWidget {
  const AddEntry({Key? key}) : super(key: key);

  @override
  _AddEntryState createState() => _AddEntryState();
}

class _AddEntryState extends State<AddEntry> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final journalEntryData = JournalEntry();

  void changeTheme() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: backButton(context),
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
        endDrawer: EndDrawer(),
        body: newEntryForm(context, _formKey, journalEntryData));
  }
}

Widget backButton(BuildContext context) {
  return Builder(builder: (BuildContext context) {
    return IconButton(
        onPressed: () => {Navigator.pop(context)},
        icon: Icon(Icons.arrow_back_ios));
  });
}

Widget newEntryForm(
    BuildContext context, GlobalKey<FormState> formKey, JournalEntry entry) {
  return SingleChildScrollView(
    child: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              textField('Title', entry),
              SizedBox(
                height: 10,
              ),
              textField('Body', entry),
              SizedBox(
                height: 10,
              ),
              DropdownRatingFormField(
                  maxRating: 4,
                  validator: (input) {
                    if (input == null) {
                      return 'Please choose a rating.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    entry.rating = value;
                  }),
              buttonRow(context, formKey, entry),
            ],
          ),
        )),
  );
}

// create text fields for Title and Body
Widget textField(String title, JournalEntry entry) {
  return TextFormField(
    onSaved: (value) {
      if (title == 'Title') {
        entry.title = value;
      } else {
        entry.body = value;
      }
    },
    validator: (input) {
      if (input == null || input.isEmpty) {
        return 'Please enter some text';
      } else {
        return null;
      }
    },
    decoration: InputDecoration(labelText: title, border: OutlineInputBorder()),
  );
}

// Row widget for Cancel and Save buttons
Widget buttonRow(
    BuildContext context, GlobalKey<FormState> key, JournalEntry entryData) {
  // actions taken on Save button press
  void saveButtonFunction() async {
    if (key.currentState!.validate()) {
      key.currentState!.save();
      String sqlCode = await rootBundle.loadString(
          SQL_DATABASE_CREATION); // load SQL database creation code in a string
      String sqlInsertCOde = await rootBundle.loadString(SQL_INSERT);

      // create/open database
      final Database database = await openDatabase('journal.db', version: 1,
          onCreate: (Database db, int version) async {
        await db.execute(sqlCode);
      });

      // insert journal data into database
      await database.transaction((txn) async {
        await txn.rawInsert(sqlInsertCOde, [
          entryData.title,
          entryData.body,
          entryData.rating,
          entryData.dateTime
        ]);
      });

      print(entryData);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('New journal entry added.')));
    }
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      SizedBox(
          width: 110,
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.grey)),
            onPressed: () => {Navigator.pop(context)},
            child: Text(
              'Cancel',
              style: TextStyle(fontSize: 18),
            ),
          )),
      SizedBox(
          width: 110,
          child: ElevatedButton(
            onPressed: () {
              entryData.dateTime = '${DateTime.now()}';
              saveButtonFunction();
              Navigator.of(context).pop();
            },
            child: Text(
              'Save',
              style: TextStyle(fontSize: 18),
            ),
          )),
    ],
  );
}
