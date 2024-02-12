import 'package:alihan_ulker_case_study/core/utils/app_colors.dart';
import 'package:alihan_ulker_case_study/src/views/my_favorite_books_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.scaffoldBgColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.scaffoldBgColor,
        ),
      ),
      home: const MyFavoriteBooksPage(),
    );
  }
}
