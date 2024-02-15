import 'package:hive/hive.dart';

part 'books_database.g.dart';

@HiveType(typeId: 1)
class BooksDatabase extends HiveObject {
  @HiveField(0)
  final String? title;

  @HiveField(1)
  final String? subtitle;

  @HiveField(2)
  final List<String>? authors;

  @HiveField(3)
  final String? publisher;

  @HiveField(4)
  final String? publishDate;

  @HiveField(5)
  final int? pageCount;

  @HiveField(6)
  final String? thumbnailUrl;

  BooksDatabase(
      {this.title,
      this.subtitle,
      this.authors,
      this.publisher,
      this.publishDate,
      this.pageCount,
      this.thumbnailUrl});
}
