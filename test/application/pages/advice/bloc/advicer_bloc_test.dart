import 'package:bloc_test/bloc_test.dart';
import 'package:get_advices/application/pages/advice/bloc/advice_bloc.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('AdvicerBloc', () {
    group('should emits', () {
      blocTest<AdviceBloc, AdviceState>(
        'nothing when no event is added',
        build: () => AdviceBloc(),
        expect: () => const <AdviceState>[],
      );

      blocTest(
        '[AdvicerStateLoading, AdvicerStateError] when AdviceRequestedEvent is added',
        build: () => AdviceBloc(),
        act: (bloc) => bloc.add(AviceRequestedEvent()),
        wait: const Duration(seconds: 3),
        expect: () => <AdviceState>[AdvicerStateLoading(), AdvicerStateError(message: 'error message')],
      );
    });
  });
}