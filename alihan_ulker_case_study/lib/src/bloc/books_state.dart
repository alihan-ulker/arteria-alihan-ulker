part of 'books_bloc.dart';

abstract class BooksState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BooksInitialState extends BooksState {}

class BooksLoadingState extends BooksState {}

class BooksLoadedState extends BooksState {
  final List<BookServiceResponse> books;

  BooksLoadedState(this.books);

  @override
  List<Object?> get props => [books];
}

class BooksErrorState extends BooksState {
  final String message;

  BooksErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
