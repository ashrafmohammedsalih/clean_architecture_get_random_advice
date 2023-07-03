import 'package:dartz/dartz.dart';
import 'package:get_advices/domain/entities/advice_entity.dart';
import 'package:get_advices/domain/core/failures/failures.dart';
import 'package:get_advices/domain/repositories/advice_repo.dart';

class AdviceUseCases {
  AdviceUseCases({required this.adviceRepo});
  final AdviceRepo adviceRepo;

  Future<Either<Failure, AdviceEntity>> getAdvice() async {
    return adviceRepo.getAdviceFromDatasource();
  }
}
