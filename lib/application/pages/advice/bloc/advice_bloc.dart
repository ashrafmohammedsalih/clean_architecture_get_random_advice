import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'advice_event.dart';
part 'advice_state.dart';

class AdviceBloc extends Bloc<AdviceEvent, AdviceState> {
  AdviceBloc() : super(AdviceInitial()) {
    on<AviceRequestedEvent>((event, emit) async {
      emit(AdvicerStateLoading());
      // execute business logic
      // for example get and advice
      debugPrint('fake get advice triggered');
      await Future.delayed(const Duration(seconds: 3), () {});
      debugPrint('got advice');
      emit(const AdvicerStateLoaded(advice: 'fake advice to test bloc'));
      //emit(const AdvicerStateError(message: 'error message'));
    });
  }
}
