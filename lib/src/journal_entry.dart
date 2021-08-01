class JournalEntry {
  String? title;
  String? body;
  DateTime? dateTime;
  int? rating;

  JournalEntry({this.title, this.body, this.dateTime, this.rating});

  String toString() {
    return 'Title: $title, Body: $body, Rating: $rating, Date: $dateTime';
  }

  String stringDate() {
    return '$dateTime';
  }
}
