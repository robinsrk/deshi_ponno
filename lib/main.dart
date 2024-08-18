import 'package:deshi_ponno/core/theme/material_theme.dart';
import 'package:deshi_ponno/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:deshi_ponno/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:deshi_ponno/features/auth/domain/usecases/check_user_logged_in.dart';
import 'package:deshi_ponno/features/auth/domain/usecases/login.dart';
import 'package:deshi_ponno/features/auth/domain/usecases/signup.dart';
import 'package:deshi_ponno/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:deshi_ponno/features/auth/presentation/pages/login_page.dart';
import 'package:deshi_ponno/features/auth/presentation/pages/signup_page.dart';
import 'package:deshi_ponno/features/auth/presentation/pages/splash_page.dart';
import 'package:deshi_ponno/features/product_scanner/data/datasources/remote/product_remote_data_source.dart';
import 'package:deshi_ponno/features/product_scanner/data/repositories/product_repository_impl.dart';
import 'package:deshi_ponno/features/product_scanner/domain/usecases/get_product.dart';
import 'package:deshi_ponno/features/product_scanner/presentation/bloc/product_bloc.dart';
import 'package:deshi_ponno/features/product_scanner/presentation/pages/home_page.dart';
import 'package:deshi_ponno/injection_container.dart' as di;
import 'package:deshi_ponno/services/firebase_options.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseDatabase.instance.setPersistenceEnabled(true);
  di.init();

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
  ));
}

class MyApp extends StatelessWidget {
  final ProductRepositoryImpl repository;
  final Login loginUseCase;
  final Signup signupUseCase;
  final CheckUserLoggedIn checkUserLoggedInUseCase;

  const MyApp({
    super.key,
    required this.repository,
    required this.loginUseCase,
    required this.signupUseCase,
    required this.checkUserLoggedInUseCase,
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
                checkUserLoggedIn: checkUserLoggedInUseCase),
          ),
          BlocProvider<ProductCubit>(
              create: (context) => ProductCubit(GetProduct(repository))),
        ],
        child: DynamicColorBuilder(
            builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
          return MaterialApp(
            title: 'Deshi Ponno',
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            theme: lightMaterialTheme(lightDynamic),
            darkTheme: darkMaterialTheme(darkDynamic),
            routes: {
              '/login': (context) => const LoginPage(),
              '/signup': (context) => const SignupPage(),
              '/home': (context) => const HomePage(),
            },
            home: const LoadingPage(),
          );
        }),
      ),
    );
  }
}
