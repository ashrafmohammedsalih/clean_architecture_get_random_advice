import 'package:dartz/dartz.dart';
import 'package:get_advices/data/repositories/advice_repo_imp.dart';
import 'package:get_advices/domain/core/failures/failures.dart';
import 'package:get_advices/domain/entities/advice_entity.dart';
import 'package:get_advices/domain/usecases/advice_usecases.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'advice_usecases.mocks.dart';

@GenerateNiceMocks([MockSpec<AdviceRepoImpl>()])
void main() {
  group('AdviceUseCases', () {
    group('should return AdviceEntity ', () {
      test('when AdviceUseCases return AdviceEntity', () async {
        final mockAdviceRepoImpl = MockAdviceRepoImpl();

        final adviceUseCasesUnderTest =AdviceUseCases(adviceRepo: mockAdviceRepoImpl);
        when(mockAdviceRepoImpl.getAdviceFromDatasource()).thenAnswer(
          (realInvocation) => Future.value(const Right(AdviceEntity(advice: "test", id: 1))), );

        final result = await adviceUseCasesUnderTest.getAdvice();

        expect(result.isLeft(), false);
        expect(result.isRight(), true);
        expect(result,const Right<Failure, AdviceEntity>( AdviceEntity(advice: 'test', id: 1)));

        verify(mockAdviceRepoImpl.getAdviceFromDatasource()).called(1);
        verifyNoMoreInteractions(mockAdviceRepoImpl);
      });
    });

    group('should return left with ', () {
      test('a server failure', () async {
        
        final mockAdviceRepoImpl = MockAdviceRepoImpl();
        final adviceUseCasesUnderTest =AdviceUseCases(adviceRepo: mockAdviceRepoImpl);
        
        when(mockAdviceRepoImpl.getAdviceFromDatasource()).thenAnswer(
              (realInvocation) => Future.value(Left(ServerFailure())), );

        final result = await adviceUseCasesUnderTest.getAdvice();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviceEntity>( ServerFailure()));

        verify(mockAdviceRepoImpl.getAdviceFromDatasource()).called(1);
        verifyNoMoreInteractions(mockAdviceRepoImpl);
      });

      test('a General failure', () async {

        final mockAdviceRepoImpl = MockAdviceRepoImpl();
        final adviceUseCasesUnderTest =AdviceUseCases(adviceRepo: mockAdviceRepoImpl);

        when(mockAdviceRepoImpl.getAdviceFromDatasource()).thenAnswer(
              (realInvocation) => Future.value(Left(GeneralFailure())), );

        final result = await adviceUseCasesUnderTest.getAdvice();

        assert(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviceEntity>( GeneralFailure()));

        verify(mockAdviceRepoImpl.getAdviceFromDatasource()).called(1);
        verifyNoMoreInteractions(mockAdviceRepoImpl);
      });

    });
  });
}
