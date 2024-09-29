import 'package:dartz/dartz.dart';
import 'package:deshi_ponno/core/errors/failures.dart';
import 'package:deshi_ponno/core/usecases/usecase.dart';
import 'package:deshi_ponno/features/welcome/domain/repositories/welcome_repository.dart';

class CompleteWelcome extends UseCase<void, NoParams> {
  final WelcomeRepository repository;

  CompleteWelcome(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.completeWelcome();
  }
}
