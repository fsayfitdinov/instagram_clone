import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram/models/models.dart';
import 'package:instagram/repositories/auth/auth_repository.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository _authRepository;

  SignupCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(SignupState.initial());

  void emailChanged(String email) {
    emit(state.copyWith(email: email, status: SignUpStatus.initial));
  }

  void passwordChanged(String password) {
    emit(state.copyWith(password: password, status: SignUpStatus.initial));
  }

  void usernameChanged(String username) {
    emit(state.copyWith(username: username, status: SignUpStatus.initial));
  }

  void signUpWithCredentials() async {
    if (!state.isFormValid || state.status == SignUpStatus.submitting) return;
    try {
      emit(state.copyWith(status: SignUpStatus.submitting));
      await _authRepository.signUpWithEmailAndPassword(username: state.username, email: state.email, password: state.password);
      emit(state.copyWith(status: SignUpStatus.success));
    } on Failure catch (err) {
      emit(state.copyWith(status: SignUpStatus.error, failure: err));
    }
  }
}
