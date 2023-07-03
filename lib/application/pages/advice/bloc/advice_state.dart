part of 'advice_bloc.dart';

abstract class AdviceState extends Equatable {
  const AdviceState();

  @override
  List<Object?> get props => [];
}

class AdviceInitial extends AdviceState {}

class AdvicerStateLoading extends AdviceState {}

class AdvicerStateLoaded extends AdviceState {
  final String advice;
  const AdvicerStateLoaded({required this.advice});

  @override
  List<Object?> get props => [advice];
}

class AdvicerStateError extends AdviceState {
  final String message;
  const AdvicerStateError({required this.message});
  @override
  List<Object?> get props => [message];
}
