import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens.dart';
import '../../repositories/repositories.dart';
import './cubit/login_cubit.dart';
import '../../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';
  static Route route() => FadeRoute(
        page: BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(authRepository: context.read<AuthRepository>()),
          child: LoginScreen(),
        ),
        routeName: routeName,
      );

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status == LoginStatus.error) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(content: state.failure.message),
              );
            }
          },
          builder: (context, state) => Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text(
                            'Instagram',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            decoration: InputDecoration(hintText: 'Email'),
                            onChanged: (value) => context.read<LoginCubit>().emailChanged(value),
                            validator: (value) => value!.contains('@') ? null : 'Please enter valid email',
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(hintText: 'Password'),
                            onChanged: (value) => context.read<LoginCubit>().passwordChanged(value),
                            validator: (value) => value!.length < 6 ? 'Password must be at least 6 characters' : null,
                          ),
                          const SizedBox(height: 28),
                          ElevatedButton(
                            onPressed: () => _submitForm(context, state.status == LoginStatus.submitting),
                            child: const Text('Log In'),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.grey[200],
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, SignUpScreen.routeName);
                            },
                            child: const Text(
                              'No Account? Sign Up',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm(BuildContext context, bool isSubmitting) {
    if (_formKey.currentState!.validate() && !isSubmitting) {
      context.read<LoginCubit>().loginWithCredentials();
    }
  }
}
