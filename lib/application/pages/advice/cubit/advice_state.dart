part of 'advice_cubit.dart';

abstract class AdviceCubitState extends Equatable {
  const AdviceCubitState();

  @override
  List<Object?> get props => [];
}

class AdviceInitial extends AdviceCubitState {
  const AdviceInitial();

}

class AdvicerStateLoading extends AdviceCubitState {
  const AdvicerStateLoading();
}
class AdvicerStateLoaded extends AdviceCubitState {
  final String advice;
  const AdvicerStateLoaded({required this.advice});

  @override
  List<Object?> get props => [advice];
}

class AdvicerStateError extends AdviceCubitState {
  final String message;
  const AdvicerStateError({required this.message});
  @override
  List<Object?> get props => [message];
}
