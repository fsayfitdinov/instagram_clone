import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './cubit/signup_cubit.dart';
import '../../repositories/repositories.dart';
import '../../widgets/widgets.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = '/signup';
  static Route route() => FadeRoute(
        page: BlocProvider<SignupCubit>(
          create: (context) => SignupCubit(authRepository: context.read<AuthRepository>()),
          child: SignUpScreen(),
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
        child: BlocConsumer<SignupCubit, SignupState>(
          listener: (context, state) {
            if (state.status == SignUpStatus.error) {
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
                            decoration: InputDecoration(hintText: 'Username'),
                            onChanged: (value) => context.read<SignupCubit>().usernameChanged(value),
                            validator: (value) => value!.trim().isEmpty ? 'Please enter valid username' : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            decoration: InputDecoration(hintText: 'Email'),
                            onChanged: (value) => context.read<SignupCubit>().emailChanged(value),
                            validator: (value) => value!.contains('@') ? null : 'Please enter valid email',
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(hintText: 'Password'),
                            onChanged: (value) => context.read<SignupCubit>().passwordChanged(value),
                            validator: (value) => value!.length < 6 ? 'Password must be at least 6 characters' : null,
                          ),
                          const SizedBox(height: 28),
                          ElevatedButton(
                            onPressed: () => _submitForm(context, state.status == SignUpStatus.submitting),
                            child: const Text(
                              'Sign Up',
                            ),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.grey[200],
                            ),
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'Have Account? Log In',
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
      context.read<SignupCubit>().signUpWithCredentials();
    }
  }
}
