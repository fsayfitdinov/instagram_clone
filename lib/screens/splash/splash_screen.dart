import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';
import '../../screens/screens.dart';
import '../../widgets/widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const String routeName = '/splash';

  static Route route() {
    return FadeRoute(page: SplashScreen(), routeName: routeName);
  }

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocListener<AuthBloc, AuthState>(
        listenWhen: (prevState, state) => prevState.status != state.status,
        listener: (context, state) async {
          if (state.status == AuthStatus.unauthenticated) {
            Navigator.pushNamed(context, LoginScreen.routeName);
          } else if (state.status == AuthStatus.authenticated) {
            Navigator.pushNamed(context, NavScreen.routeName);
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: SizedBox(
              height: 200,
              width: 200,
              child: Image.asset(
                'assets/images/12xp-instagram-superJumbo.jpeg',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
