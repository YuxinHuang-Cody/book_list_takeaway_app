// models/book.dart

class Book {
  String title;
  String author;
  int publicationYear;

  Book({required this.title, required this.author, required this.publicationYear});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'publicationYear': publicationYear,
    };
  }
}
