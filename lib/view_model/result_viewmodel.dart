import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marksheet_generator/model/result.dart';
import 'package:marksheet_generator/state/result_state.dart';

final resultViewModelProvider =
    StateNotifierProvider<ResultViewModel, ResultState>(
  (ref) => ResultViewModel(),
);

class ResultViewModel extends StateNotifier<ResultState> {
  ResultViewModel() : super(ResultState.initialState()) {
    getAllMarkSheet();
  }

  void getAllMarkSheet() {
    state.result.add(
        Result(fname: "Sanjin", lname: "Thapa", course: "Flutter", mark: 60));
    state.result.add(
        Result(fname: "Sanjin", lname: "Thapa", course: "Web API", mark: 60));
    state.result.add(Result(
        fname: "Sanjin", lname: "Thapa", course: "Design Thinking", mark: 60));
    state.result
        .add(Result(fname: "Sanjin", lname: "Thapa", course: "IOT", mark: 60));
  }

  void deleteMarkSheet(Result result) {
    // Add logic to delete the mark sheet from the data source
    // For example:
    state = state.copyWith(isLoading: true);
    final updatedMarksheets = state.result.where((ms) => ms != result).toList();
    state = state.copyWith(result: updatedMarksheets);
    state = state.copyWith(isLoading: false);
  }

  void addMark(Result result) {
    state = state.copyWith(isLoading: true);
    state.result.add(result);
    state = state.copyWith(isLoading: false);
  }
}
