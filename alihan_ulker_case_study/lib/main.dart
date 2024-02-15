import 'package:alihan_ulker_case_study/core/database/books_database.dart';
import 'package:alihan_ulker_case_study/core/services/books_service.dart';
import 'package:alihan_ulker_case_study/core/utils/app_colors.dart';
import 'package:alihan_ulker_case_study/src/bloc/books_bloc.dart';
import 'package:alihan_ulker_case_study/src/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('favoriteBooks');
  Hive.registerAdapter(BooksDatabaseAdapter());
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
      home: BlocProvider(
        create: (context) => BooksBloc(BooksService()),
        child: const HomePage(),
      ),
    );
  }
}
