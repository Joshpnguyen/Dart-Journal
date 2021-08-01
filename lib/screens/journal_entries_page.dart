import 'package:dart_journal/src_export.dart';
import 'package:flutter/material.dart';

class JournalEntries extends StatefulWidget {
  const JournalEntries({Key? key}) : super(key: key);

  @override
  _JournalEntriesState createState() => _JournalEntriesState();
}

class _JournalEntriesState extends State<JournalEntries> {
  Journal journal = Journal(listOfEntries: []);

  @override
  void initState() {
    super.initState();
    loadJournal();
  }

  void loadJournal() async {
    String sqlCode = await rootBundle.loadString(SQL_DATABASE_CREATION);
    String sqlSelect = await rootBundle.loadString(SQL_SELECT);

    final Database database = await openDatabase('journal.db', version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(sqlCode);
    });

    List<Map> journalRecords = await database.rawQuery(sqlSelect);
    final journalEntries = journalRecords.map((record) {
      return JournalEntry(
          title: record['title'],
          body: record['body'],
          rating: record['rating'],
          dateTime: record['date']);
    }).toList();
    setState(() {
      journal = Journal(listOfEntries: journalEntries);
    });
  }

  @override
  Widget build(BuildContext context) {
    return isDatabaseEmpty(context);
  }

  Widget isDatabaseEmpty(BuildContext context) {
    if (journal.listOfEntries.isEmpty) {
      return SingleChildScrollView(child: Text('Work in progress!'));
    }
    return Column(children: [Text('there are journal entries')]);
  }
}
