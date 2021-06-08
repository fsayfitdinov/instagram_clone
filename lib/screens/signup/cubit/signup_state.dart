part of 'signup_cubit.dart';

enum SignUpStatus { initial, submitting, success, error }

class SignupState extends Equatable {
  final String username;
  final String email;
  final String password;
  final SignUpStatus status;
  final Failure failure;

  SignupState({
    required this.username,
    required this.email,
    required this.password,
    required this.status,
    required this.failure,
  });

  bool get isFormValid => email.isNotEmpty && password.isNotEmpty && username.isNotEmpty;

  @override
  bool? get stringify => true;

  @override
  List<Object> get props => [email, username, password, status, failure];

  factory SignupState.initial() {
    return SignupState(
      username: '',
      email: '',
      password: '',
      status: SignUpStatus.initial,
      failure: Failure(),
    );
  }

  SignupState copyWith({
    String? username,
    String? email,
    String? password,
    SignUpStatus? status,
    Failure? failure,
  }) {
    return SignupState(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
