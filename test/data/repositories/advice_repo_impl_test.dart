import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:get_advices/data/core/exceptions/exceptions.dart';
import 'package:get_advices/data/datasources/advice_remote_datasource.dart';
import 'package:get_advices/data/models/advice_model.dart';
import 'package:get_advices/data/repositories/advice_repo_imp.dart';
import 'package:get_advices/domain/core/failures/failures.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'advice_repo_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdviceRemoteDatasource>()])
void main() {
  group('AdviceRepoImpl', () {
    group('should return AdviceEntity ', () {
      test('when AdviceRepoImpl return AdviceEntity', () async {
        final mockAdviceRemoteDatasource = MockAdviceRemoteDatasource();

        final adviceRepoImplUnderTest =
            AdviceRepoImpl(adviceRemoteDatasource: mockAdviceRemoteDatasource);

        when(mockAdviceRemoteDatasource.getRandomAdviceFromApi()).thenAnswer(
            (realInvocation) =>
                Future.value(AdviceModel(advice: 'test', id: 1)));

        final result = await adviceRepoImplUnderTest.getAdviceFromDatasource();

        expect(result.isLeft(), false);
        expect(result.isRight(), true);
        expect(result,
            Right<Failure, AdviceModel>(AdviceModel(advice: 'test', id: 1)));

        verify(mockAdviceRemoteDatasource.getRandomAdviceFromApi()).called(1);
        verifyNoMoreInteractions(mockAdviceRemoteDatasource);
      });
    });

    group('should return Left ', () {
      test('when AdviceRepoImpl throw Exeption', () async {
        final mockAdviceRemoteDatasource = MockAdviceRemoteDatasource();

        final adviceRepoImplUnderTest =
            AdviceRepoImpl(adviceRemoteDatasource: mockAdviceRemoteDatasource);

        when(mockAdviceRemoteDatasource.getRandomAdviceFromApi())
            .thenThrow(ServerException());

        final result = await adviceRepoImplUnderTest.getAdviceFromDatasource();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviceModel>(ServerFailure()));

        verify(mockAdviceRemoteDatasource.getRandomAdviceFromApi()).called(1);
        verifyNoMoreInteractions(mockAdviceRemoteDatasource);
      });

      test('when AdviceRepoImpl throw Exeption General Filuer', () async {
        final mockAdviceRemoteDatasource = MockAdviceRemoteDatasource();

        final adviceRepoImplUnderTest =
            AdviceRepoImpl(adviceRemoteDatasource: mockAdviceRemoteDatasource);

        //? Method 1
        when(mockAdviceRemoteDatasource.getRandomAdviceFromApi())
            .thenThrow(const SocketException("error"));

        // //? Method 2
        // when(mockAdviceRemoteDatasource.getRandomAdviceFromApi()).thenAnswer(
        //     (realInvocation) => Future.value(AdviceModel.fromJson(const {
        //           "advice": "test advice",
        //         })));

        final result = await adviceRepoImplUnderTest.getAdviceFromDatasource();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviceModel>(GeneralFailure()));

        verify(mockAdviceRemoteDatasource.getRandomAdviceFromApi()).called(1);
        verifyNoMoreInteractions(mockAdviceRemoteDatasource);
      });
    });
  });
}
