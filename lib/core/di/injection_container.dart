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
import 'package:deshi_ponno/features/auth/domain/usecases/check_admin.dart';
import 'package:deshi_ponno/features/auth/domain/usecases/check_user_logged_in.dart';
import 'package:deshi_ponno/features/auth/domain/usecases/login.dart';
import 'package:deshi_ponno/features/auth/domain/usecases/signup.dart';
import 'package:deshi_ponno/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:deshi_ponno/features/home_page/data/datasources/remote/product_remote_data_source.dart';
import 'package:deshi_ponno/features/home_page/data/repositories/product_repository_impl.dart';
import 'package:deshi_ponno/features/home_page/domain/repositories/product_repository.dart';
import 'package:deshi_ponno/features/home_page/domain/usecases/get_product.dart';
import 'package:deshi_ponno/features/home_page/presentation/bloc/product_bloc.dart';
import 'package:deshi_ponno/features/settings/data/repositories/localization_repository_impl.dart';
import 'package:deshi_ponno/features/settings/domain/repositories/localization_repository.dart';
import 'package:deshi_ponno/features/settings/presentation/bloc/localization_cubit.dart';
import 'package:deshi_ponno/features/welcome/data/datasources/local/welcome_local_data_source.dart';
import 'package:deshi_ponno/features/welcome/data/repositories/welcome_repository_impl.dart';
import 'package:deshi_ponno/features/welcome/domain/repositories/welcome_repository.dart';
import 'package:deshi_ponno/features/welcome/domain/usecases/check_welcome.dart';
import 'package:deshi_ponno/features/welcome/domain/usecases/complete_welcome.dart';
import 'package:deshi_ponno/features/welcome/presentation/blocs/welcome_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

void init() async {
  // Firebase
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseDatabase>(() => FirebaseDatabase.instance);

  sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());
  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl<FirebaseAuth>()),
  );
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(sl<FirebaseDatabase>()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl<AuthRemoteDataSource>()),
  );
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(sl<ProductRemoteDataSource>()),
  );

  // Number format
  sl.registerLazySingleton<NumberFormatterService>(
      () => NumberFormatterService());

  sl.registerFactory<ProductListCubit>(
      () => ProductListCubit(sl<GetAllProducts>()));
  sl.registerLazySingleton<GetAllProducts>(
      () => GetAllProducts(sl<AllProductsRepository>()));
  sl.registerLazySingleton<AllProductsRepository>(
      () => ProductListRepositoryImpl(sl<ProductListRemoteDataSource>()));
  sl.registerLazySingleton<ProductListRemoteDataSource>(
      () => ProductListRemoteDataSource(FirebaseDatabase.instance));
  // Use cases
  sl.registerLazySingleton<CheckUserLoggedIn>(
      () => CheckUserLoggedIn(sl<AuthRepository>()));
  sl.registerLazySingleton<Login>(() => Login(sl<AuthRepository>()));
  sl.registerLazySingleton<Signup>(() => Signup(sl<AuthRepository>()));
  sl.registerLazySingleton<GetProduct>(
      () => GetProduct(sl<ProductRepository>()));

  sl.registerFactory<LocalizationCubit>(
      () => LocalizationCubit(sl<LocalizationRepository>()));
  sl.registerLazySingleton<LocalizationRepository>(
      () => LocalizationRepositoryImpl());
  // Localization delegates
  sl.registerLazySingleton<List<LocalizationsDelegate<Object>>>(
      () => <LocalizationsDelegate<Object>>[
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ]);

  // Supported locales
  sl.registerLazySingleton<List<Locale>>(() => const <Locale>[
        Locale('en', ''),
        Locale('bn', ''),
      ]);

  // Blocs/Cubits
  sl.registerFactory<AuthBloc>(() => AuthBloc(
        checkUserLoggedIn: sl<CheckUserLoggedIn>(),
        login: sl<Login>(),
        signup: sl<Signup>(),
        checkAdmin: sl<CheckAdmin>(),
      ));
  sl.registerFactory<ProductCubit>(() => ProductCubit(sl<GetProduct>()));
// Features - Welcome
  sl.registerFactory(
    () => WelcomeCubit(
      checkWelcomeCompleted: sl(),
      completeWelcome: sl(),
    ),
  );

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => CheckWelcomeCompleted(sl()));
  sl.registerLazySingleton(() => CompleteWelcome(sl()));

  // Repository
  sl.registerLazySingleton<WelcomeRepository>(
    () => WelcomeRepositoryImpl(sl()),
  );

  // Data sources
  sl.registerLazySingleton<WelcomeLocalDataSource>(
    () => WelcomeLocalDataSourceImpl(sl()),
  );

  // External
}
