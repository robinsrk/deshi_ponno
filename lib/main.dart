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
import 'package:deshi_ponno/features/navigation/domain/cubit/nav_bar_cubit.dart';
import 'package:deshi_ponno/features/navigation/presentation/pages/nav_bar_page.dart';
import 'package:deshi_ponno/features/product_scanner/data/datasources/remote/product_remote_data_source.dart';
import 'package:deshi_ponno/features/product_scanner/data/repositories/product_repository_impl.dart';
import 'package:deshi_ponno/features/product_scanner/domain/usecases/get_product.dart';
import 'package:deshi_ponno/features/product_scanner/presentation/bloc/product_bloc.dart';
import 'package:deshi_ponno/features/product_scanner/presentation/pages/home_page.dart';
import 'package:deshi_ponno/features/settings/data/repositories/localization_repository_impl.dart';
import 'package:deshi_ponno/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:deshi_ponno/features/settings/presentation/bloc/localization_cubit.dart';
import 'package:deshi_ponno/features/settings/presentation/bloc/settings_cubit.dart';
import 'package:deshi_ponno/services/firebase_options.dart';
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
  MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseDatabase.instance.setPersistenceEnabled(true);
  FirebaseDatabase.instance.ref().keepSynced(true);
  di.init();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool isDarkMode = prefs.getBool('isDarkMode') ?? false;

  final firebaseAuth = FirebaseAuth.instance;

  final authRemoteDataSource = AuthRemoteDataSourceImpl(firebaseAuth);
  final authRepository = AuthRepositoryImpl(authRemoteDataSource);
  final loginUseCase = Login(authRepository);
  final signupUseCase = Signup(authRepository);
  final checkUserLoggedIn = CheckUserLoggedIn(authRepository);

  final productRepository = ProductRepositoryImpl(
    ProductRemoteDataSourceImpl(FirebaseDatabase.instance),
  );

  runApp(MyApp(
    repository: productRepository,
    loginUseCase: loginUseCase,
    signupUseCase: signupUseCase,
    checkUserLoggedInUseCase: checkUserLoggedIn,
    isDarkMode: isDarkMode,
  ));
}

class MyApp extends StatelessWidget {
  final ProductRepositoryImpl repository;
  final Login loginUseCase;
  final Signup signupUseCase;
  final CheckUserLoggedIn checkUserLoggedInUseCase;
  final bool isDarkMode;

  const MyApp({
    super.key,
    required this.repository,
    required this.loginUseCase,
    required this.signupUseCase,
    required this.checkUserLoggedInUseCase,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CheckUserLoggedIn>(
          create: (context) => checkUserLoggedInUseCase,
        ),
        RepositoryProvider<ProductRepositoryImpl>(
          create: (context) => repository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
              create: (context) => AuthBloc(
                  login: loginUseCase,
                  signup: signupUseCase,
                  checkUserLoggedIn: checkUserLoggedInUseCase)),
          BlocProvider<ProductCubit>(
              create: (context) => ProductCubit(GetProduct(repository))),
          BlocProvider<NavBarCubit>(create: (context) => NavBarCubit()),
          BlocProvider(create: (_) => ThemeCubit()),
          BlocProvider(
              create: (_) =>
                  SettingsCubit(SettingsRepositoryImpl(), isDarkMode)),
          BlocProvider<ProductListCubit>(
              create: (context) => di.sl<ProductListCubit>()..getAllProducts()),
          BlocProvider<LocalizationCubit>(
            create: (context) =>
                LocalizationCubit(LocalizationRepositoryImpl()),
          ),
        ],
        child:
            BlocBuilder<LocalizationCubit, Locale>(builder: (context, locale) {
          return DynamicColorBuilder(
              builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
            return BlocBuilder<ThemeCubit, ThemeData>(builder: (
              context,
              theme,
            ) {
              return MaterialApp(
                title: "Deshi Ponno",
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en', ''),
                  Locale('bn', ''),
                ],
                locale: locale,
                localeResolutionCallback: (locale, supportedLocales) {
                  for (var supportedLocale in supportedLocales) {
                    if (supportedLocale.languageCode == locale?.languageCode) {
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
                routes: {
                  "/login": (context) => const LoginPage(),
                  "/signup": (context) => const SignupPage(),
                  "/home": (context) => const HomePage(),
                  "/main": (context) => const NavBarPage(),
                  "/loading": (context) => const LoadingPage(),
                  "/products": (context) => const ProductListPage(),
                },
                home: const LoadingPage(),
              );
            });
          });
        }),
      ),
    );
  }
}
