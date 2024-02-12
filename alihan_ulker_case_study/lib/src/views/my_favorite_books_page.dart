import 'package:alihan_ulker_case_study/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyFavoriteBooksPage extends StatefulWidget {
  const MyFavoriteBooksPage({Key? key}) : super(key: key);

  @override
  MyFavoriteBooksPageState createState() => MyFavoriteBooksPageState();
}

class MyFavoriteBooksPageState extends State<MyFavoriteBooksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Favori Kitaplarım",
            style: TextStyle(color: AppColors.white, fontSize: 32.0),
          ),
          actions: [
            IconButton(
              onPressed: () {},
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
                    child: SearchBar(
                      leading: const Icon(
                        Icons.search,
                        color: AppColors.white,
                      ),
                      shape: MaterialStateProperty.all(
                          const ContinuousRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      )),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      side: MaterialStateProperty.all(
                        const BorderSide(
                          color: AppColors.white,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: () {},
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
              child: Center(
                child: SvgPicture.asset(
                  "assets/svg/book.svg",
                  width: 100.0,
                  height: 100.0,
                ),
              ),
            )
          ],
        ));
  }
}
