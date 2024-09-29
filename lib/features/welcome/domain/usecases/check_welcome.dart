import 'package:dartz/dartz.dart';
import 'package:deshi_ponno/core/errors/failures.dart';
import 'package:deshi_ponno/core/usecases/usecase.dart';
import 'package:deshi_ponno/features/welcome/domain/repositories/welcome_repository.dart';

class CheckWelcomeCompleted extends UseCase<bool, NoParams> {
  final WelcomeRepository repository;

  CheckWelcomeCompleted(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.isWelcomeCompleted();
  }
}
