import 'package:dartz/dartz.dart';
import 'package:deshi_ponno/core/errors/failures.dart';
import 'package:deshi_ponno/core/usecases/usecase.dart';
import 'package:deshi_ponno/features/auth/domain/repositories/auth_repository.dart';

class CheckAdmin implements UseCase<bool, NoParams> {
  final AuthRepository repository;

  CheckAdmin(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    try {
      final isAdmin = await repository.isAdmin();
      return (isAdmin);
    } catch (e) {
      // Handle specific exceptions here if needed
      return Left(ServerFailure("Server Failure"));
    }
  }
}
