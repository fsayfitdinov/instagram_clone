part of 'profile_bloc.dart';

enum ProfileStatus { initial, loading, loaded, error }

class ProfileState extends Equatable {
  final UserModel user;
  final bool isCurrentUser;
  final bool isGridView;
  final bool isFollowing;
  final ProfileStatus status;
  final Failure failure;

  const ProfileState({
    required this.user,
    required this.isCurrentUser,
    required this.isGridView,
    required this.isFollowing,
    required this.status,
    required this.failure,
  });

  @override
  List<Object> get props => [
        user,
        isCurrentUser,
        isGridView,
        isFollowing,
        status,
        failure,
      ];

  factory ProfileState.initial() {
    return ProfileState(
      user: UserModel.empty,
      isCurrentUser: false,
      isGridView: true,
      isFollowing: false,
      status: ProfileStatus.initial,
      failure: Failure(),
    );
  }

  ProfileState copyWith({
    UserModel? user,
    bool? isCurrentUser,
    bool? isGridView,
    bool? isFollowing,
    ProfileStatus? status,
    Failure? failure,
  }) {
    return ProfileState(
      user: user ?? this.user,
      isCurrentUser: isCurrentUser ?? this.isCurrentUser,
      isGridView: isGridView ?? this.isGridView,
      isFollowing: isFollowing ?? this.isFollowing,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
