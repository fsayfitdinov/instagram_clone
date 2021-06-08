import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:instagram/blocs/blocs.dart';
import 'package:instagram/repositories/repositories.dart';
import 'package:instagram/widgets/widgets.dart';

import 'bloc/profile_bloc.dart';
import 'widgets/widgets.dart';

class ProfileScreenArgs {
  final String userId;

  const ProfileScreenArgs({required this.userId});
}

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';

  static Route route({required ProfileScreenArgs args}) {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BlocProvider<ProfileBloc>(
        create: (_) => ProfileBloc(
          userRepository: context.read<UserRepository>(),
          authBloc: context.read<AuthBloc>(),
        )..add(
            ProfileLoadUser(userId: args.userId),
          ),
        child: ProfileScreen(),
      ),
    );
  }

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.status == ProfileStatus.error) {
          showDialog(context: context, builder: (context) => ErrorDialog(content: state.failure.message));
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text(state.user.username),
          actions: [
            if (state.isCurrentUser)
              IconButton(
                onPressed: () => context.read<AuthBloc>().add(AuthLogoutRequested()),
                icon: Icon(Icons.logout_outlined),
              )
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
                    child: Row(
                      children: <Widget>[
                        UserProfileImage(
                          radius: 40,
                          profileImageUrl: state.user.profileImageUrl,
                        ),
                        ProfileStats(
                          isCurrentUser: state.isCurrentUser,
                          isFollowing: state.isFollowing,
                          posts: 0,
                          followers: state.user.followers,
                          following: state.user.following,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: ProfileInfo(
                      username: state.user.username,
                      bio: state.user.bio,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
