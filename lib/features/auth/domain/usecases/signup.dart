import 'package:dartz/dartz.dart';
import 'package:deshi_ponno/core/errors/failures.dart';
import 'package:deshi_ponno/features/auth/domain/repositories/auth_repository.dart';

import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';

class Signup implements UseCase<User, SignupParams> {
  final AuthRepository repository;

  Signup(this.repository);

  @override
  Future<Either<Failure, User>> call(SignupParams params) async {
    return await repository.signup(params.email, params.password);
  }
}

class SignupParams {
  final String email;
  final String password;

  SignupParams({required this.email, required this.password});
}
