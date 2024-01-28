// services/book_service.dart
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import '../models/book.dart';
import 'dart:io';

class BookService {

  static Future<List<Book>> getBooks() async {
    final String documentsDirectory = (await getApplicationDocumentsDirectory()).path;
    final String localFilePath = '$documentsDirectory/book_data.json';

    List<dynamic> jsonList;

    // Check if the local file exists
    if (await File(localFilePath).exists()) {
      // Load data from local file
      String localData = await File(localFilePath).readAsString();
      jsonList = json.decode(localData);
    } else {
      // Load data from assets if local file does not exist
      String assetData = await rootBundle.loadString('assets/book_data.json');
      jsonList = json.decode(assetData);
    }

    List<Book> books = jsonList.map((e) {
      return Book(
        title: e['title'],
        author: e['author'],
        publicationYear: e['publicationYear'],
      );
    }).toList();

    return books;
  }

  static Future<void> saveBooks(List<dynamic> books) async {
    // Get the application documents directory
    final String documentsDirectory = (await getApplicationDocumentsDirectory()).path;

    // Construct the file path
    final String filePath = '$documentsDirectory/book_data.json';

    // Convert the list of books to JSON
    String jsonData = json.encode(books);

    // Write the JSON string to the file
    await File(filePath).writeAsString(jsonData);
  }
}
