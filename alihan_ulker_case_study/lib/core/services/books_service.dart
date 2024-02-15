import 'dart:convert';
import 'dart:io';

import 'package:alihan_ulker_case_study/core/models/book_service_response.dart';
import 'package:http/http.dart' as http;

class BooksService {
  Future<List<BookServiceResponse>> searchBooks(String query) async {
    const String apiKey = 'AIzaSyDfhb5ZNZMmxCCKof4RxbBOjJUdS8Ozz-I';
    final String url =
        'https://www.googleapis.com/books/v1/volumes?q=$query&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<BookServiceResponse> books = [];
        for (var item in data['items']) {
          books.add(BookServiceResponse.fromJson(item));
        }
        return books;
      } else {
        throw HttpException('HTTP Error: ${response.statusCode}');
      }
    } on SocketException {
      throw const SocketException('No internet connection');
    } on HttpException catch (e) {
      throw HttpException('HTTP Error: ${e.message}');
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}
