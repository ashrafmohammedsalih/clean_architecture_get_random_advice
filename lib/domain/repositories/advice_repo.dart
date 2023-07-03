import 'package:dartz/dartz.dart';

import '../entities/advice_entity.dart';
import '../core/failures/failures.dart';

abstract class AdviceRepo {
  Future<Either<Failure, AdviceEntity>> getAdviceFromDatasource();
}