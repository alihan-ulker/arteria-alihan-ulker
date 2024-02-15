import 'package:alihan_ulker_case_study/core/utils/app_colors.dart';
import 'package:alihan_ulker_case_study/src/bloc/books_bloc.dart';
import 'package:alihan_ulker_case_study/src/views/my_favorite_books_page.dart';
import 'package:alihan_ulker_case_study/src/widgets/favorite_books_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  bool _showClearButton = false;
  late Box favoriteBooksBox;
  Set<String> favoriteBookIds = {};

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    openBox().then((_) {
      loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Favori Kitaplarım",
            style: TextStyle(
              color: AppColors.white,
              fontSize: 32.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyFavoriteBooksPage(),
                  ),
                ).then((value) => loadFavorites());
              },
              icon: const Icon(
                Icons.favorite,
                size: 32.0,
              ),
              color: AppColors.favoriteButtonColor,
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(color: AppColors.white),
                      cursorColor: AppColors.white,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                          color: AppColors.white,
                        ),
                        suffixIcon: _showClearButton
                            ? IconButton(
                                icon: const Icon(
                                  Icons.clear,
                                  color: AppColors.white,
                                ),
                                onPressed: () {
                                  _searchController.clear();
                                  BlocProvider.of<BooksBloc>(context)
                                      .add(ClearSearchEvent());
                                })
                            : null,
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          borderSide: BorderSide(
                            color: AppColors.borderColor,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          borderSide: BorderSide(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      String searchQuery = _searchController.text.trim();
                      if (searchQuery.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter a word to search for!'),
                            duration: Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      } else if (searchQuery.length > 500) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'The search term is too long. Please enter a term of less than 500 characters.'),
                            duration: Duration(seconds: 3),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      } else {
                        BlocProvider.of<BooksBloc>(context)
                            .add(BooksSearchEvent(searchQuery));
                        FocusScope.of(context).unfocus();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      backgroundColor: AppColors.searchButtonColor,
                    ),
                    child: const Text(
                      "Search",
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<BooksBloc, BooksState>(
                builder: (context, state) {
                  if (state is BooksLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is BooksLoadedState) {
                    return ListView.builder(
                      itemCount: state.books.length,
                      itemBuilder: (context, index) {
                        final book = state.books[index];

                        return GestureDetector(
                          onDoubleTap: () async {
                            await Hive.openBox('favoriteBooks');

                            final Map<String, dynamic> bookData = {};
                            if (book.id != null) {
                              bookData['id'] = book.id;
                            }
                            if (book.title != null) {
                              bookData['title'] = book.title;
                            }
                            if (book.subtitle != null) {
                              bookData['subtitle'] = book.subtitle;
                            }
                            if (book.authors != null) {
                              bookData['authors'] = book.authors;
                            }
                            if (book.publisher != null) {
                              bookData['publisher'] = book.publisher;
                            }
                            if (book.publishDate != null) {
                              bookData['publishDate'] = book.publishDate;
                            }
                            if (book.pageCount != null) {
                              bookData['pageCount'] = book.pageCount;
                            }
                            if (book.thumbnailUrl != null) {
                              bookData['thumbnailUrl'] = book.thumbnailUrl;
                            }

                            await toggleFavoriteBook(bookData);
                            setState(() {});
                          },
                          onLongPress: () async {
                            if (favoriteBookIds.contains(book.id)) {
                              await removeFromFavorites(book.id ?? '');

                              setState(() {});
                            }
                            setState(() {});
                          },
                          child: BookListItem(
                            title: book.title,
                            subtitle: book.subtitle,
                            authors: book.authors,
                            publisher: book.publisher,
                            publishDate: book.publishDate,
                            pageCount: book.pageCount,
                            thumbnailUrl: book.thumbnailUrl,
                            isFavorite: favoriteBookIds.contains(book.id),
                          ),
                        );
                      },
                    );
                  } else if (state is BooksErrorState) {
                    return Center(
                        child: Text('Error: ${state.message}',
                            style: const TextStyle(color: AppColors.white)));
                  } else {
                    return Center(
                      child: SvgPicture.asset(
                        "assets/svg/book.svg",
                        width: 100.0,
                        height: 100.0,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future openBox() async {
    favoriteBooksBox = await Hive.openBox('favoriteBooks');

    favoriteBookIds =
        Set<String>.from(favoriteBooksBox.keys.map((key) => key.toString()));
    setState(() {});
  }

  void loadFavorites() async {
    var box = await Hive.openBox('favoriteBooks');
    var keysSet = Set<String>.from(box.keys.map((key) {
      return key.toString();
    }));
    setState(() {
      favoriteBookIds = keysSet;
    });
  }

  Future toggleFavoriteBook(Map<String, dynamic> bookData) async {
    final bookId = bookData['id'];

    if (!favoriteBookIds.contains(bookId)) {
      await favoriteBooksBox.put(bookId, bookData);
      favoriteBookIds.add(bookId);
    }

    setState(() {});
  }

  Future removeFromFavorites(String bookId) async {
    if (favoriteBookIds.contains(bookId)) {
      await favoriteBooksBox.delete(bookId);
      favoriteBookIds.remove(bookId);
      setState(() {});
    }
  }

  Color getBorderColor(String id) {
    return favoriteBookIds.contains(id)
        ? AppColors.favoriteBorderColor
        : AppColors.borderColor;
  }

  void _onSearchChanged() {
    if (_searchController.text.isNotEmpty && !_showClearButton) {
      setState(() {
        _showClearButton = true;
      });
    } else if (_searchController.text.isEmpty && _showClearButton) {
      setState(() {
        _showClearButton = false;
      });
    }
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }
}
