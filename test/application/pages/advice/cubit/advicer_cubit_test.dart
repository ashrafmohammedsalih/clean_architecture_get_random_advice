
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:get_advices/application/pages/advice/cubit/advice_cubit.dart';
import 'package:get_advices/domain/core/failures/failures.dart';
import 'package:get_advices/domain/entities/advice_entity.dart';
import 'package:get_advices/domain/usecases/advice_usecases.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/scaffolding.dart';

class MockAdviceUseCases extends Mock implements AdviceUseCases {}

void main() {
  group('AdvicerCubit', () {
    group(
      'should emit',
          () {
        MockAdviceUseCases mockAdviceUseCases = MockAdviceUseCases();

        blocTest(
          'nothing when no method is called',
          build: () => AdviceCubit(advaiceUseCases: mockAdviceUseCases),
          expect: () => const <AdviceCubitState>[],
        );

        blocTest(
          '[AdvicerStateLoading, AdvicerStateLoaded] when adviceRequested() is called',
          setUp: () => when(() => mockAdviceUseCases.getAdvice()).thenAnswer(
                (invocation) => Future.value(
              const Right<Failure, AdviceEntity>(
                AdviceEntity(advice: 'advice', id: 1),
              ),
            ),
          ),
          build: () => AdviceCubit(advaiceUseCases: mockAdviceUseCases),
          act: (cubit) => cubit.aviceRequested(),
          expect: () => const <AdviceCubitState>[AdvicerStateLoading(), AdvicerStateLoaded(advice: 'advice')],
        );

        group(
          '[AdvicerStateLoading, AdvicerStateError] when adviceRequested() is called',
              () {
            blocTest(
              'and a ServerFailure occors',
              setUp: () => when(() => mockAdviceUseCases.getAdvice()).thenAnswer(
                    (invocation) => Future.value(
                  Left<Failure, AdviceEntity>(
                    ServerFailure(),
                  ),
                ),
              ),
              build: () => AdviceCubit(advaiceUseCases: mockAdviceUseCases),
              act: (cubit) => cubit.aviceRequested(),
              expect: () => const <AdviceCubitState>[
                AdvicerStateLoading(),
                AdvicerStateError(message: serverFailureMessage),
              ],
            );

            blocTest(
              'and a CacheFailure occors',
              setUp: () => when(() => mockAdviceUseCases.getAdvice()).thenAnswer(
                    (invocation) => Future.value(
                  Left<Failure, AdviceEntity>(
                    CacheFailure(),
                  ),
                ),
              ),
              build: () => AdviceCubit(advaiceUseCases: mockAdviceUseCases),
              act: (cubit) => cubit.aviceRequested(),
              expect: () => const <AdviceCubitState>[
                AdvicerStateLoading(),
                AdvicerStateError(message: cacheFailureMessage),
              ],
            );

            blocTest(
              'and a GeneralFailure occors',
              setUp: () => when(() => mockAdviceUseCases.getAdvice()).thenAnswer(
                    (invocation) => Future.value(
                  Left<Failure, AdviceEntity>(
                    GeneralFailure(),
                  ),
                ),
              ),
              build: () => AdviceCubit(advaiceUseCases: mockAdviceUseCases),
              act: (cubit) => cubit.aviceRequested(),
              expect: () => const <AdviceCubitState>[
                AdvicerStateLoading(),
                AdvicerStateError(message: generalFailureMessage),
              ],
            );
          },
        );

      },
    );
  });
}