// pages/home_page.dart
import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/book_service.dart';
import 'book_details_page.dart';
import 'add_book_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Book> books = [];

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  void _loadBooks() async {
    List<Book> loadedBooks = await BookService.getBooks();
    setState(() {
      books = loadedBooks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Lists'),
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.white,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            confirmDismiss: (direction) async {
              return await showDeleteConfirmationDialog(context);
            },
            onDismissed: (direction) {
              _deleteBook(index);
            },
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: CircleAvatar(
                child: Text((index + 1).toString()),
              ),
              title: Text(
                books[index].title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                books[index].author,
                style: TextStyle(fontSize: 14),
              ),
              onTap: () {
                _navigateToBookDetails(books[index]);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddBook(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<bool?> showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this book?'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Delete', style: TextStyle(color: Colors.white)),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Cancel', style: TextStyle(color: Colors.white)),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }

  void _navigateToBookDetails(Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailsPage(book: book),
      ),
    );
  }

  void _navigateToAddBook(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddBookPage(),
      ),
    ).then((result) {
      // Callback when returning from AddBookPage
      if (result != null && result is Book) {
        _addBook(result);
      }
    });
  }

  void _addBook(Book newBook) {
    setState(() {
      books.add(newBook);
      _saveBooks(); // Save updated data after adding a new book
    });
  }

  void _deleteBook(int index) {
    setState(() {
      books.removeAt(index);
      _saveBooks();
    });
  }

  void _saveBooks() {
    // Save the updated data to the book_data.json file
    BookService.saveBooks(books);
  }
}
