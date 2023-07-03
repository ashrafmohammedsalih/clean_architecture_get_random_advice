import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_advices/domain/usecases/advice_usecases.dart';

part 'advice_state.dart';

class AdviceCubit extends Cubit<AdviceCubitState> {
  final AdviceUseCases advaiceUseCases;
  AdviceCubit({required this.advaiceUseCases}) : super(AdviceInitial());

  void aviceRequested() async {
    emit(AdvicerStateLoading());
    final response = await advaiceUseCases.getAdvice();
    response.fold(
        (faliure) => emit(const AdvicerStateError(message: 'error message')),
        (advice) => emit(AdvicerStateLoaded(advice: advice.advice)));
  }
}
