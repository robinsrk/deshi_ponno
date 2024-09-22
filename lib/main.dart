import 'dart:developer' as dev;

import 'package:deshi_ponno/core/di/injection_container.dart' as di;
import 'package:deshi_ponno/core/localization/app_localization.dart';
import 'package:deshi_ponno/core/theme/theme_cubit.dart';
import 'package:deshi_ponno/features/all_products/presentation/bloc/product_list_cubit.dart';
import 'package:deshi_ponno/features/all_products/presentation/pages/all_products_page.dart';
import 'package:deshi_ponno/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:deshi_ponno/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:deshi_ponno/features/auth/domain/usecases/check_user_logged_in.dart';
import 'package:deshi_ponno/features/auth/domain/usecases/login.dart';
import 'package:deshi_ponno/features/auth/domain/usecases/signup.dart';
import 'package:deshi_ponno/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:deshi_ponno/features/auth/presentation/pages/login_page.dart';
import 'package:deshi_ponno/features/auth/presentation/pages/signup_page.dart';
import 'package:deshi_ponno/features/auth/presentation/pages/splash_page.dart';
import 'package:deshi_ponno/features/common/data/datasources/remote/product_remote_data_source.dart';
import 'package:deshi_ponno/features/common/data/repositories/product_repository_impl.dart';
import 'package:deshi_ponno/features/common/domain/repositories/product_repository.dart';
import 'package:deshi_ponno/features/common/domain/usecases/get_scanned_products.dart';
import 'package:deshi_ponno/features/common/domain/usecases/store_scanned_products.dart';
import 'package:deshi_ponno/features/common/presentation/bloc/product_history_bloc.dart';
import 'package:deshi_ponno/features/home_page/data/datasources/remote/product_remote_data_source.dart';
import 'package:deshi_ponno/features/home_page/data/repositories/product_repository_impl.dart';
import 'package:deshi_ponno/features/home_page/domain/usecases/get_product.dart';
import 'package:deshi_ponno/features/home_page/presentation/bloc/product_bloc.dart';
import 'package:deshi_ponno/features/home_page/presentation/pages/home_page.dart';
import 'package:deshi_ponno/features/navigation/domain/cubit/nav_bar_cubit.dart';
import 'package:deshi_ponno/features/navigation/presentation/pages/nav_bar_page.dart';
import 'package:deshi_ponno/features/profile/presentation/pages/profile_page.dart';
import 'package:deshi_ponno/features/settings/data/repositories/localization_repository_impl.dart';
import 'package:deshi_ponno/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:deshi_ponno/features/settings/presentation/bloc/localization_cubit.dart';
import 'package:deshi_ponno/features/settings/presentation/bloc/settings_cubit.dart';
import 'package:deshi_ponno/firebase_options.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Mobile ads
  MobileAds.instance.initialize();

  // Firebase
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    dev.log(e.toString());
  }
  FirebaseDatabase.instance.setPersistenceEnabled(true);
  FirebaseDatabase.instance.ref().child("products").keepSynced(true);
  FirebaseDatabase.instance.ref().child("users").keepSynced(true);

  // Dependency injection
  di.init();

  // Local storage
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
  final bool isMaterialU = prefs.getBool('isMaterialU') ?? false;

  final CommonProductRemoteDataSourceImpl commonProductRemoteDataSource =
      CommonProductRemoteDataSourceImpl();
  final CommonProductRepositoryImpl commonProductRepository =
      CommonProductRepositoryImpl(commonProductRemoteDataSource);
  // Firebase authentication
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final AuthRemoteDataSourceImpl authRemoteDataSource =
      AuthRemoteDataSourceImpl(firebaseAuth);
  final AuthRepositoryImpl authRepository =
      AuthRepositoryImpl(authRemoteDataSource);
  final Login loginUseCase = Login(authRepository);
  final Signup signupUseCase = Signup(authRepository);
  final CheckUserLoggedIn checkUserLoggedIn = CheckUserLoggedIn(authRepository);

  final ProductRepositoryImpl productRepository = ProductRepositoryImpl(
    ProductRemoteDataSourceImpl(FirebaseDatabase.instance),
  );

  runApp(MyApp(
    commonProductRepository: commonProductRepository,
    repository: productRepository,
    loginUseCase: loginUseCase,
    signupUseCase: signupUseCase,
    checkUserLoggedInUseCase: checkUserLoggedIn,
    isDarkMode: isDarkMode,
    isMaterialU: isMaterialU,
  ));
}

class MyApp extends StatelessWidget {
  final ProductRepositoryImpl repository;
  final Login loginUseCase;
  final Signup signupUseCase;
  final CheckUserLoggedIn checkUserLoggedInUseCase;
  final bool isDarkMode;
  final bool isMaterialU;
  final ProductRepository commonProductRepository;

  const MyApp({
    super.key,
    required this.repository,
    required this.loginUseCase,
    required this.signupUseCase,
    required this.checkUserLoggedInUseCase,
    required this.isDarkMode,
    required this.isMaterialU,
    required this.commonProductRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CheckUserLoggedIn>(
          create: (BuildContext context) => checkUserLoggedInUseCase,
        ),
        RepositoryProvider<ProductRepositoryImpl>(
          create: (BuildContext context) => repository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
              create: (BuildContext context) => AuthBloc(
                  login: loginUseCase,
                  signup: signupUseCase,
                  checkUserLoggedIn: checkUserLoggedInUseCase)),
          BlocProvider<ProductCubit>(
              create: (BuildContext context) =>
                  ProductCubit(GetProduct(repository))),
          BlocProvider<NavBarCubit>(
              create: (BuildContext context) => NavBarCubit()),
          BlocProvider<ThemeCubit>(
              create: (BuildContext context) => ThemeCubit()),
          BlocProvider<SettingsCubit>(
              create: (BuildContext context) => SettingsCubit(
                  SettingsRepositoryImpl(), isDarkMode, isMaterialU)),
          BlocProvider<ProductListCubit>(
              create: (BuildContext context) =>
                  di.sl<ProductListCubit>()..getAllProducts()),
          BlocProvider<LocalizationCubit>(
            create: (BuildContext context) =>
                LocalizationCubit(LocalizationRepositoryImpl()),
          ),
          BlocProvider<ProductHistoryBloc>(
            create: (BuildContext context) => ProductHistoryBloc(
              getScannedProducts: GetScannedProducts(commonProductRepository),
              storeScannedProduct: StoreScannedProduct(commonProductRepository),
            ),
          ),
        ],
        child: BlocBuilder<LocalizationCubit, Locale>(
          builder: (BuildContext context, Locale locale) {
            return DynamicColorBuilder(
              builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
                return BlocBuilder<ThemeCubit, ThemeData>(
                  builder: (
                    BuildContext context,
                    ThemeData theme,
                  ) {
                    return MaterialApp(
                      title: "Deshi Ponno",
                      localizationsDelegates: const <LocalizationsDelegate<
                          dynamic>>[
                        AppLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      supportedLocales: const <Locale>[
                        Locale('en', ''),
                        Locale('bn', ''),
                      ],
                      locale: locale,
                      localeResolutionCallback:
                          (Locale? locale, Iterable<Locale> supportedLocales) {
                        for (Locale supportedLocale in supportedLocales) {
                          if (supportedLocale.languageCode ==
                              locale?.languageCode) {
                            return supportedLocale;
                          }
                        }
                        return supportedLocales.first;
                      },
                      debugShowCheckedModeBanner: true,
                      // themeMode: ThemeMode.light,
                      // theme: lightMaterialTheme(lightDynamic),
                      // darkTheme: darkMaterialTheme(darkDynamic),
                      theme: theme,
                      routes: <String, Widget Function(BuildContext)>{
                        "/login": (BuildContext context) => const LoginPage(),
                        "/signup": (BuildContext context) => const SignupPage(),
                        "/home": (BuildContext context) => const HomePage(),
                        "/main": (BuildContext context) => const NavBarPage(),
                        "/loading": (BuildContext context) =>
                            const LoadingPage(),
                        "/products": (BuildContext context) =>
                            const ProductListPage(),
                        "/profile": (BuildContext context) =>
                            const ProfilePage(),
                      },
                      home: const LoadingPage(),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
