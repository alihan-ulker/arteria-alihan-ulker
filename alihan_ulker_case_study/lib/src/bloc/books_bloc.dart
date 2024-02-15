import 'package:alihan_ulker_case_study/core/models/book_service_response.dart';
import 'package:alihan_ulker_case_study/core/services/books_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'books_event.dart';
part 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  final BooksService booksService;

  BooksBloc(this.booksService) : super(BooksInitialState()) {
    on<BooksSearchEvent>((event, emit) async {
      emit(BooksLoadingState());
      try {
        final books = await booksService.searchBooks(event.query);
        emit(BooksLoadedState(books));
      } catch (e) {
        emit(BooksErrorState(e.toString()));
      }
    });
    on<ClearSearchEvent>((event, emit) {
      emit(BooksInitialState());
    });
  }
}
