import 'package:dart_journal/src_export.dart';

class Journal {
  List<JournalEntry> listOfEntries = [];

  Journal({required this.listOfEntries});

  void addEntry(entry) {
    if (entry != null) {
      listOfEntries.add(entry);
    }
  }
}
