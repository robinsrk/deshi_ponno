// import 'package:deshi_ponno/features/auth/presentation/bloc/auth_events.dart';
// import 'package:deshi_ponno/features/auth/presentation/bloc/auth_states.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../bloc/auth_bloc.dart';
//
// class LoginPage extends StatelessWidget {
//   const LoginPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Login')),
//       body: BlocListener<AuthBloc, AuthState>(
//         listener: (context, state) {
//           if (state is AuthError) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(state.message)),
//             );
//           } else if (state is Authenticated) {
//             Navigator.of(context).pushReplacementNamed('/home');
//           }
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               const TextField(
//                 decoration: InputDecoration(labelText: 'Email'),
//               ),
//               const TextField(
//                 decoration: InputDecoration(labelText: 'Password'),
//                 obscureText: true,
//               ),
//               const SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () {
//                   context.read<AuthBloc>().add(
//                         LoginEvent(
//                           email: 'test@example.com',
//                           password: 'password',
//                         ),
//                       );
//                 },
//                 child: const Text('Login'),
//               ),
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pushNamed('/signup');
//                 },
//                 child: const Text('Signup'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:deshi_ponno/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:deshi_ponno/features/auth/presentation/bloc/auth_states.dart';
import 'package:deshi_ponno/features/auth/presentation/widgets/email_input_field.dart';
import 'package:deshi_ponno/features/auth/presentation/widgets/login_button.dart';
import 'package:deshi_ponno/features/auth/presentation/widgets/password_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is Authenticated) {
            Navigator.pushReplacementNamed(context, '/home');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EmailInputField(controller: _emailController),
                const SizedBox(height: 16),
                PasswordInputField(controller: _passwordController),
                const SizedBox(height: 16),
                LoginButton(
                  emailController: _emailController,
                  passwordController: _passwordController,
                  formKey: _formKey,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: const Text('Don\'t have an account? Sign up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
