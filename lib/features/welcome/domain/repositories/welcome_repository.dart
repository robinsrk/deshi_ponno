import 'package:dartz/dartz.dart';
import 'package:deshi_ponno/core/errors/failures.dart';

abstract class WelcomeRepository {
  Future<Either<Failure, bool>> isWelcomeCompleted();
  Future<Either<Failure, void>> completeWelcome();
}
