// pages/book_details_page.dart
import 'package:flutter/material.dart';
import '../models/book.dart';

class BookDetailsPage extends StatelessWidget {
  final Book book;

  BookDetailsPage({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              book.title,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Author:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              book.author,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Publication Year:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              book.publicationYear.toString(),
              style: TextStyle(fontSize: 18),
            ),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
