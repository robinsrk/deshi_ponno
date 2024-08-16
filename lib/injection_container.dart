// import 'package:deshi_ponno/features/auth/data/datasources/remote/auth_remote_data_source.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get_it/get_it.dart';
//
// import 'features/auth/data/repositories/auth_repository_impl.dart';
// import 'features/auth/domain/repositories/auth_repository.dart';
// import 'features/auth/domain/usecases/login.dart';
// import 'features/auth/domain/usecases/signup.dart';
// import 'features/auth/presentation/bloc/auth_bloc.dart';
//
// final sl = GetIt.instance;
//
// void init() {
//   // Bloc
//   sl.registerFactory(() => AuthBloc(
//         login: sl(),
//         signup: sl(),
//       ));
//
//   // Use cases
//   sl.registerLazySingleton(() => Login(sl()));
//   sl.registerLazySingleton(() => Signup(sl()));
//
//   // Repository
//   sl.registerLazySingleton<AuthRepository>(
//     () => AuthRepositoryImpl(
//       sl(),
//     ),
//   );
//
//   // Data sources
//   sl.registerLazySingleton<AuthRemoteDataSource>(
//     () => AuthRemoteDataSourceImpl(sl()),
//   );
//
//   // External
//   sl.registerLazySingleton(() => FirebaseAuth.instance);
// }
// import 'package:deshi_ponno/features/auth/data/datasources/remote/auth_remote_data_source.dart';
// import 'package:get_it/get_it.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'features/auth/data/repositories/auth_repository_impl.dart';
// import 'features/auth/domain/repositories/auth_repository.dart';
// import 'features/auth/domain/usecases/login.dart';
// import 'features/auth/domain/usecases/signup.dart';
// import 'features/auth/presentation/bloc/auth_bloc.dart';
//
// final sl = GetIt.instance;
//
// void init() {
//   // Bloc
//   sl.registerFactory(() => AuthBloc(
//         login: sl(),
//         signup: sl(),
//       ));
//
//   // Use cases
//   sl.registerLazySingleton(() => Login(sl()));
//   sl.registerLazySingleton(() => Signup(sl()));
//
//   // Repository
//   sl.registerLazySingleton<AuthRepository>(
//     () => AuthRepositoryImpl(
//       sl(),
//     ),
//   );
//
//   // Data sources
//   sl.registerLazySingleton<AuthRemoteDataSource>(
//     () => AuthRemoteDataSourceImpl(sl()),
//   );
//
//   // External
//   sl.registerLazySingleton(() => FirebaseAuth.instance);
// }
import 'package:get_it/get_it.dart';
import 'package:deshi_ponno/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:deshi_ponno/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:deshi_ponno/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:deshi_ponno/features/auth/domain/usecases/login.dart';
import 'package:deshi_ponno/features/auth/domain/usecases/signup.dart';
import 'package:deshi_ponno/features/product_scanner/data/datasources/remote/product_remote_data_source.dart';
import 'package:deshi_ponno/features/product_scanner/data/repositories/product_repository_impl.dart';
import 'package:deshi_ponno/features/product_scanner/domain/usecases/get_product.dart';
import 'package:deshi_ponno/features/product_scanner/presentation/bloc/product_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

final sl = GetIt.instance;

void init() {
  // Firebase
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseDatabase.instance);

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(sl()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepositoryImpl>(
    () => AuthRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<ProductRepositoryImpl>(
    () => ProductRepositoryImpl(sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => Signup(sl()));
  sl.registerLazySingleton(() => GetProduct(sl()));

  // Blocs/Cubits
  sl.registerFactory(() => AuthBloc(
        login: sl(),
        signup: sl(),
      ));
  sl.registerFactory(() => ProductCubit(sl()));
}
