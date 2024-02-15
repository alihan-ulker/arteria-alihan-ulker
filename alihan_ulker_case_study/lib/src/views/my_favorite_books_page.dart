import 'package:alihan_ulker_case_study/core/utils/app_colors.dart';
import 'package:alihan_ulker_case_study/src/widgets/favorite_books_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class MyFavoriteBooksPage extends StatefulWidget {
  const MyFavoriteBooksPage({Key? key}) : super(key: key);

  @override
  MyFavoriteBooksPageState createState() => MyFavoriteBooksPageState();
}

class MyFavoriteBooksPageState extends State<MyFavoriteBooksPage> {
  late Box favoriteBooksBox;
  List<dynamic> favoriteBooks = [];

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future loadFavorites() async {
    var box = await Hive.openBox('favoriteBooks');
    setState(() {
      favoriteBooks = box.values.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favoriler",
          style: TextStyle(
            color: AppColors.white,
          ),
        ),
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: AppColors.white),
        actions: [
          IconButton(
            onPressed: () {
              if (favoriteBooks.isNotEmpty) {
                confirmDeleteAll();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('The favorites list is already empty.'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            icon: const Icon(
              Icons.delete_forever_outlined,
              size: 32.0,
            ),
            color: AppColors.favoriteButtonColor,
          ),
        ],
      ),
      body: favoriteBooks.isEmpty
          ? const Center(
              child: Text(
              "No favorite book.",
              style: TextStyle(
                color: AppColors.white,
              ),
            ))
          : ListView.builder(
              itemCount: favoriteBooks.length,
              itemBuilder: (context, index) {
                final book = favoriteBooks[index];
                return GestureDetector(
                  //Kitap uzerine uzun basildiginda silmek icin cikan uyari
                  onLongPress: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Delete Book'),
                          content: Text(
                              '${book['title']} should it be removed from favorites?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {
                                await deleteFavoriteBook(book['id'], index);
                                Navigator.of(context).pop();
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: BookListItem(
                    title: book['title'],
                    subtitle: book['subtitle'],
                    authors: book['authors']?.cast<String>(),
                    publisher: book['publisher'],
                    publishDate: book['publishDate'],
                    pageCount: book['pageCount'],
                    thumbnailUrl: book['thumbnailUrl'],
                    isFavorite: true,
                  ),
                );
              },
            ),
    );
  }

  //Favoriler kismindan bir kitap silmek icin
  Future deleteFavoriteBook(String? bookId, int index) async {
    var box = await Hive.openBox('favoriteBooks');
    if (bookId != null) {
      await box.delete(bookId);

      setState(() {
        favoriteBooks.removeAt(index);
      });
    }
  }

  //Favoriler kisminda tum kitaplari silmek icin
  Future deleteAllFavorites() async {
    Box box;
    if (Hive.isBoxOpen('favoriteBooks')) {
      box = Hive.box('favoriteBooks');
    } else {
      box = await Hive.openBox('favoriteBooks');
    }
    await box.clear();
    loadFavorites();
  }

  //Tum kitaplari favoriler kismindan silmeden once cikan uyari
  Future confirmDeleteAll() async {
    bool confirm = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Delete All Favorites"),
              content: const Text(
                  "Are you sure you want to delete all your favorite books?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text("Delete"),
                ),
              ],
            );
          },
        ) ??
        false;

    if (confirm) {
      deleteAllFavorites();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
