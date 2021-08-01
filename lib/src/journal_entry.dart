class JournalEntry {
  String? title;
  String? body;
  String? dateTime;
  int? rating;

  JournalEntry({this.title, this.body, this.dateTime, this.rating});

  String toString() {
    return 'Title: $title, Body: $body, Rating: $rating, Date: $dateTime';
  }
}
