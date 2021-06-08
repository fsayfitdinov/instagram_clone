import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, dynamic event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    // print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  Future<void> onError(BlocBase cubit, Object err, StackTrace stack) async {
    print(err);
    super.onError(cubit, err, stack);
  }
}
