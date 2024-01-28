// pages/add_book_page.dart
import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/book_service.dart';

class AddBookPage extends StatefulWidget {
  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _publicationYearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _authorController,
              decoration: InputDecoration(labelText: 'Author'),
            ),
            TextField(
              controller: _publicationYearController,
              decoration: InputDecoration(labelText: 'Publication Year'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _submitBook(context);
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitBook(BuildContext context) {
    String title = _titleController.text.trim();
    String author = _authorController.text.trim();
    String publicationYear = _publicationYearController.text.trim();

    if (title.isNotEmpty && author.isNotEmpty && publicationYear.isNotEmpty) {
      // Convert publicationYear to int
      int year = int.tryParse(publicationYear) ?? 0;

      Book newBook = Book(title: title, author: author, publicationYear: year);
      Navigator.pop(context, newBook); // Pass the new book back to HomePage
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Title, Author, and Publication Year cannot be empty.'),
        duration: Duration(seconds: 2),
      ));
    }
  }
}
