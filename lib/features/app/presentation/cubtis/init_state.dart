part of 'init_cubit.dart';

abstract class InitState extends Equatable {
  const InitState();
}

class InitInitial extends InitState {
  @override
  List<Object> get props => [];
}

/// Loaded data state.
class InitLoaded extends InitState {
  final bool result;
  final Settings settings;

  const InitLoaded({this.result, this.settings});

  InitLoaded copyWith({bool result, Settings settings}) {
    return InitLoaded(
      result: result ?? this.result,
      settings: settings ?? this.settings,
    );
  }

  @override
  List<Object> get props => [result, settings];
}

class InitLoading extends InitState {
  @override
  List<Object> get props => [];
}
