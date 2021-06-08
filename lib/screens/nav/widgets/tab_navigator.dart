import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/blocs/auth/auth_bloc.dart';
import 'package:instagram/config/custom_router.dart';
import 'package:instagram/repositories/user/user_repository.dart';
import 'package:instagram/screens/profile/bloc/profile_bloc.dart';

import '../../../enums/enums.dart';
import '../../../screens/screens.dart';

class TabNavigator extends StatelessWidget {
  static const tabNavigatorRoot = '/';

  final GlobalKey<NavigatorState> navigatorKey;
  final BottomNavbarItem item;

  const TabNavigator({
    Key? key,
    required this.navigatorKey,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders();
    return Navigator(
      key: navigatorKey,
      initialRoute: tabNavigatorRoot,
      onGenerateInitialRoutes: (_, initialRoute) => [
        CupertinoPageRoute(
          builder: (context) => routeBuilders[initialRoute]!(context),
          settings: RouteSettings(name: tabNavigatorRoot),
        ),
      ],
      onGenerateRoute: CustomRouter.onGenerateNestedRoute,
    );
  }

  Map<String, WidgetBuilder> _routeBuilders() {
    return {tabNavigatorRoot: (context) => _getScreen(context, item)};
  }

  Widget _getScreen(BuildContext context, BottomNavbarItem item) {
    switch (item) {
      case BottomNavbarItem.feed:
        return FeedScreen();
      case BottomNavbarItem.search:
        return SearchScreen();
      case BottomNavbarItem.create:
        return CreatePostScreen();
      case BottomNavbarItem.notifications:
        return NotificationsScreen();
      case BottomNavbarItem.profile:
        return BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(
            authBloc: context.read<AuthBloc>(),
            userRepository: context.read<UserRepository>(),
          )..add(
              ProfileLoadUser(userId: context.read<AuthBloc>().state.user!.uid),
            ),
          child: ProfileScreen(),
        );
    }
  }
}
