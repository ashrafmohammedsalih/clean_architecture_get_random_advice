import 'package:dartz/dartz.dart';
import 'package:get_advices/data/core/exceptions/exceptions.dart';
import 'package:get_advices/data/datasources/advice_remote_datasource.dart';
import 'package:get_advices/domain/entities/advice_entity.dart';
import 'package:get_advices/domain/core/failures/failures.dart';
import 'package:get_advices/domain/repositories/advice_repo.dart';

class AdviceRepoImpl implements AdviceRepo {
    AdviceRepoImpl({required this.adviceRemoteDatasource});
  final AdviceRemoteDatasource adviceRemoteDatasource;
  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromDatasource() async {
    try {
      final result = await adviceRemoteDatasource.getRandomAdviceFromApi();
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      return left(GeneralFailure());
    }
  }
}