class BookServiceResponse {
  final String? id;
  final String? title;
  final String? subtitle;
  final List<String>? authors;
  final String? publisher;
  final String? publishDate;
  final int? pageCount;
  final String? thumbnailUrl;

  BookServiceResponse(
      {this.id,
      this.title,
      this.subtitle,
      this.authors,
      this.publisher,
      this.publishDate,
      this.pageCount,
      this.thumbnailUrl});

  factory BookServiceResponse.fromJson(Map<String, dynamic> json) {
    return BookServiceResponse(
      id: json['id'] ?? '',
      title: json['volumeInfo']['title'] ?? '',
      subtitle: json['volumeInfo']['subtitle'] ?? '',
      authors: List<String>.from(json['volumeInfo']['authors'] ?? []),
      publisher: json['volumeInfo']['publisher'] ?? '',
      publishDate: json['volumeInfo']['publishedDate'] ?? '',
      pageCount: json['volumeInfo']['pageCount'] ?? 0,
      thumbnailUrl: json['volumeInfo']['imageLinks'] != null
          ? json['volumeInfo']['imageLinks']['thumbnail']
          : null,
    );
  }
}
