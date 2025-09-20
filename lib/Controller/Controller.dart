
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DictionaryState {}

class IntialState extends DictionaryState {}

class SuccessState extends DictionaryState {
  final String word;
  final String meaning;
  final String example;

  SuccessState(this.word, this.meaning, this.example);
}

class LoadingState extends DictionaryState {}

class FailureState extends DictionaryState {
  final String errorMessage;
  FailureState(this.errorMessage);
}

class favoriteWords extends DictionaryState{
  final List<String> words;
  favoriteWords(this.words);
}

// ─────────────────────────────────────────────────────────────────────────────

class DictionaryCubit extends Cubit<DictionaryState> {
  final Dio dio = Dio();
  DictionaryCubit() : super(IntialState());

  Future<void> getWord(String word) async {
    emit(LoadingState());

    try {
      final response = await dio.get(
        "https://api.dictionaryapi.dev/api/v2/entries/en/$word",
      );
      final data = response.data[0];
      final meaning =
          data["meanings"][0]["definitions"][0]["definition"] ??
          "No meaning found";
      final example =
          data["meanings"][0]["definitions"][0]["example"] ??
          "No example available";

      emit(SuccessState(word, meaning, example));
    } catch (e) {
      emit(FailureState("Word not found or error occurred"));
    }
  }
}