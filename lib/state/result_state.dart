import 'package:marksheet_generator/model/result.dart';

class ResultState {
  bool isLoading;
  List<Result> result;

  ResultState({
    required this.isLoading,
    required this.result,
  });

  ResultState.initialState()
      : this(
          isLoading: false,
          result: [],
        );

  ResultState copyWith({
    bool? isLoading,
    List<Result>? result,
  }) {
    return ResultState(
      isLoading: isLoading ?? this.isLoading,
      result: result ?? this.result,
    );
  }
}
