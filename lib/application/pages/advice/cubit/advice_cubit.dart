import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_advices/domain/usecases/advice_usecases.dart';

import '../../../../domain/core/failures/failures.dart';

part 'advice_state.dart';

const generalFailureMessage = 'Ups, something gone wrong. Please try again!';
const serverFailureMessage = 'Ups, API Error. please try again!';
const cacheFailureMessage = 'Ups, chache failed. Please try again!';

class AdviceCubit extends Cubit<AdviceCubitState> {
  final AdviceUseCases advaiceUseCases;
  AdviceCubit({required this.advaiceUseCases}) : super(AdviceInitial());

  void aviceRequested() async {
    emit(AdvicerStateLoading());
    final response = await advaiceUseCases.getAdvice();
    response.fold(
        (faliure) => emit( AdvicerStateError(message:  _mapFailureToMessage(faliure))),
        (advice) => emit(AdvicerStateLoaded(advice: advice.advice)));
  }
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return generalFailureMessage;
    }
  }

}
