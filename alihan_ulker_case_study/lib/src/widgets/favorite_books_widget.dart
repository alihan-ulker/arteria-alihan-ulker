import 'package:alihan_ulker_case_study/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

//HomePage ve MyFavoriteBooksPage sayfalarinda ortak olarak kullanilir.
class BookListItem extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final List<String>? authors;
  final String? publisher;
  final String? publishDate;
  final int? pageCount;
  final String? thumbnailUrl;
  final bool isFavorite;

  const BookListItem({
    Key? key,
    this.title,
    this.subtitle,
    this.authors,
    this.publisher,
    this.publishDate,
    this.pageCount,
    this.thumbnailUrl,
    required this.isFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: isFavorite
              ? AppColors.favoriteBorderColor
              : AppColors.borderColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Kitap kapagi eksik ise default olarak belirlenen resmi gosterir.
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: thumbnailUrl != null
                  ? Image.network(thumbnailUrl!,
                      width: 100, height: 130, fit: BoxFit.fill)
                  : Image.asset("assets/images/default_book_image.png",
                      width: 100, height: 130, fit: BoxFit.cover),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Kitap ismi eksik ise Bilinmiyor yazacak.
                    Text(
                      title ?? "Bilinmiyor",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(thickness: 1),
                    //Kitap aciklamasi eksik ise gosterilmeyecek.
                    Visibility(
                      visible: subtitle?.isNotEmpty ?? false,
                      child: Text(
                        "Subtitle: $subtitle",
                        style: const TextStyle(
                            color: AppColors.white, fontSize: 12.0),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    //Kitap yazarlari eksik ise gosterilmeyecek.
                    Visibility(
                      visible: authors?.isNotEmpty ?? false,
                      child: Text(
                        "Authors: ${authors?.join(', ')}",
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    //Kitap yayınevi eksik ise gosterilmeyecek.
                    Visibility(
                      visible: publisher?.isNotEmpty ?? false,
                      child: Text(
                        "Publisher: $publisher",
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        //Kitap yayınlanma tarihi eksik ise gosterilmeyecek.
                        Visibility(
                          visible: publishDate?.isNotEmpty ?? false,
                          child: Row(
                            children: [
                              Text(
                                "Published at: $publishDate",
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ),
                        //Kitap sayfa sayisi eksik ise gosterilmeyecek.
                        Visibility(
                          visible: pageCount != 0,
                          child: Text(
                            "Pages: $pageCount",
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
