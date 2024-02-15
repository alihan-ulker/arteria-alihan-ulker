part of 'books_bloc.dart';

abstract class BooksEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class BooksSearchEvent extends BooksEvent {
  final String query;

  BooksSearchEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class ClearSearchEvent extends BooksEvent {}
