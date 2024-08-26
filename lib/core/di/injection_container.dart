import 'package:deshi_ponno/core/localization/app_localization.dart';
import 'package:deshi_ponno/core/services/number_format_service.dart';
import 'package:deshi_ponno/features/all_products/data/datasources/remote/product_remote_data_source.dart';
import 'package:deshi_ponno/features/all_products/data/repositories/all_products_repository_impl.dart';
import 'package:deshi_ponno/features/all_products/domain/repositories/all_product_repository.dart';
import 'package:deshi_ponno/features/all_products/domain/usecases/get_all_products.dart';
import 'package:deshi_ponno/features/all_products/presentation/bloc/product_list_cubit.dart';
import 'package:deshi_ponno/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:deshi_ponno/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:deshi_ponno/features/auth/domain/repositories/auth_repository.dart';
import 'package:deshi_ponno/features/auth/domain/usecases/check_user_logged_in.dart';
import 'package:deshi_ponno/features/auth/domain/usecases/login.dart';
import 'package:deshi_ponno/features/auth/domain/usecases/signup.dart';
import 'package:deshi_ponno/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:deshi_ponno/features/product_scanner/data/datasources/remote/product_remote_data_source.dart';
import 'package:deshi_ponno/features/product_scanner/data/repositories/product_repository_impl.dart';
import 'package:deshi_ponno/features/product_scanner/domain/repositories/product_repository.dart';
import 'package:deshi_ponno/features/product_scanner/domain/usecases/get_product.dart';
import 'package:deshi_ponno/features/product_scanner/presentation/bloc/product_bloc.dart';
import 'package:deshi_ponno/features/settings/data/repositories/localization_repository_impl.dart';
import 'package:deshi_ponno/features/settings/domain/repositories/localization_repository.dart';
import 'package:deshi_ponno/features/settings/presentation/bloc/localization_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';

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
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(sl()),
  );

  // Number format
  sl.registerLazySingleton<NumberFormatterService>(
      () => NumberFormatterService());

  sl.registerFactory(() => ProductListCubit(sl<GetAllProducts>()));
  sl.registerLazySingleton(() => GetAllProducts(sl<AllProductsRepository>()));
  sl.registerLazySingleton<AllProductsRepository>(
      () => ProductListRepositoryImpl(sl<ProductListRemoteDataSource>()));
  sl.registerLazySingleton(
      () => ProductListRemoteDataSource(FirebaseDatabase.instance));
  // Use cases
  sl.registerLazySingleton(() => CheckUserLoggedIn(sl()));
  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => Signup(sl()));
  sl.registerLazySingleton(() => GetProduct(sl()));

  sl.registerFactory(() => LocalizationCubit(sl()));
  sl.registerLazySingleton<LocalizationRepository>(
      () => LocalizationRepositoryImpl());
  // Localization delegates
  sl.registerLazySingleton(() => [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ]);

  // Supported locales
  sl.registerLazySingleton(() => const [
        Locale('en', ''),
        Locale('bn', ''),
      ]);

  // Blocs/Cubits
  sl.registerFactory(() => AuthBloc(
        checkUserLoggedIn: sl(),
        login: sl(),
        signup: sl(),
      ));
  sl.registerFactory(() => ProductCubit(sl()));
}
