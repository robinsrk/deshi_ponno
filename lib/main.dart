// import 'package:deshi_ponno/core/theme/material_theme.dart';
// import 'package:deshi_ponno/features/product_scanner/data/datasources/remote/product_remote_data_source.dart';
// import 'package:deshi_ponno/features/product_scanner/data/repositories/product_repository_impl.dart';
// import 'package:deshi_ponno/features/product_scanner/domain/usecases/get_product.dart';
// import 'package:deshi_ponno/features/product_scanner/presentation/bloc/product_bloc.dart';
// import 'package:deshi_ponno/features/product_scanner/presentation/pages/home_page.dart';
// import 'package:deshi_ponno/services/firebase_options.dart';
// import 'package:dynamic_color/dynamic_color.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'injection_container.dart' as di;
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   FirebaseDatabase.instance.setPersistenceEnabled(true);
//   di.init();
//   final productRepository = ProductRepositoryImpl(
//     ProductRemoteDataSourceImpl(FirebaseDatabase.instance),
//   );
//   runApp(MyApp(
//     repository: productRepository,
//   ));
// }
//
// class MyApp extends StatelessWidget {
//   final ProductRepositoryImpl repository;
//   const MyApp({super.key, required this.repository});
//
//   @override
//   Widget build(BuildContext context) {
//     return DynamicColorBuilder(
//       builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
//         return MaterialApp(
//             title: 'Deshi Ponno',
//             debugShowCheckedModeBanner: false,
//             themeMode: ThemeMode.system, // Follow system theme
//             theme: lightMaterialTheme(lightDynamic),
//             darkTheme: darkMaterialTheme(darkDynamic),
//             home: BlocProvider(
//               create: (_) => ProductCubit(
//                 GetProduct(repository),
//               ),
//               child: const HomePage(),
//             ));
//       },
//     );
//   }
// }
import 'package:deshi_ponno/core/theme/material_theme.dart';
import 'package:deshi_ponno/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:deshi_ponno/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:deshi_ponno/features/auth/domain/usecases/login.dart';
import 'package:deshi_ponno/features/auth/domain/usecases/signup.dart';
import 'package:deshi_ponno/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:deshi_ponno/features/auth/presentation/pages/login_page.dart';
import 'package:deshi_ponno/features/auth/presentation/pages/signup_page.dart';
import 'package:deshi_ponno/features/product_scanner/data/datasources/remote/product_remote_data_source.dart';
import 'package:deshi_ponno/features/product_scanner/data/repositories/product_repository_impl.dart';
import 'package:deshi_ponno/features/product_scanner/domain/usecases/get_product.dart';
import 'package:deshi_ponno/features/product_scanner/presentation/bloc/product_bloc.dart';
import 'package:deshi_ponno/features/product_scanner/presentation/pages/home_page.dart';
import 'package:deshi_ponno/services/firebase_options.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

  final productRepository = ProductRepositoryImpl(
    ProductRemoteDataSourceImpl(FirebaseDatabase.instance),
  );
  runApp(MyApp(
    repository: productRepository,
    loginUseCase: loginUseCase,
    signupUseCase: signupUseCase,
  ));
}

class MyApp extends StatelessWidget {
  final ProductRepositoryImpl repository;
  final Login loginUseCase;
  final Signup signupUseCase;
  const MyApp({
    super.key,
    required this.repository,
    required this.loginUseCase,
    required this.signupUseCase,
  });

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return MaterialApp(
            title: 'Deshi Ponno',
            debugShowCheckedModeBanner: true,
            themeMode: ThemeMode.system, // Follow system theme
            theme: lightMaterialTheme(lightDynamic),
            darkTheme: darkMaterialTheme(darkDynamic),
            routes: {
              '/login': (context) => const LoginPage(),
              '/signup': (context) => const SignupPage(),
              '/home': (context) => BlocProvider<ProductCubit>(
                    create: (context) => ProductCubit(GetProduct(repository)),
                    child: const HomePage(),
                  ),
            },
            home: MultiBlocProvider(
              providers: [
                BlocProvider<AuthBloc>(
                  create: (context) =>
                      AuthBloc(login: loginUseCase, signup: signupUseCase),
                ),
                BlocProvider<ProductCubit>(
                    create: (context) => ProductCubit(GetProduct(repository)))
              ],
              // create: (_) => ProductCubit(
              //   GetProduct(repository),
              // ),
              child: const LoginPage(),
            ));
      },
    );
  }
}
