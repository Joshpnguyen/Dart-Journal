import 'package:dart_journal/src_export.dart';
import 'package:flutter/material.dart';

class AddEntry extends StatefulWidget {
  const AddEntry({Key? key}) : super(key: key);

  @override
  _AddEntryState createState() => _AddEntryState();
}

class _AddEntryState extends State<AddEntry> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        endDrawer: drawer(),
        body: newEntryForm(context, _formKey));
  }
}

Widget backButton(BuildContext context) {
  return Builder(builder: (BuildContext context) {
    return IconButton(
        onPressed: () => {Navigator.pop(context)},
        icon: Icon(Icons.arrow_back_ios));
  });
}

Widget newEntryForm(BuildContext context, GlobalKey<FormState> formKey) {
  return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            textField('Title'),
            SizedBox(
              height: 10,
            ),
            textField('Body'),
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
                onSaved: (value) {}),
            buttonRow(context, formKey),
          ],
        ),
      ));
}

// create text fields for Title and Body
Widget textField(String title) {
  return TextFormField(
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
Widget buttonRow(BuildContext context, GlobalKey<FormState> key) {
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
              if (key.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('New journal entry added.')));
                Navigator.pop(context);
              }
            },
            child: Text(
              'Save',
              style: TextStyle(fontSize: 18),
            ),
          )),
    ],
  );
}
