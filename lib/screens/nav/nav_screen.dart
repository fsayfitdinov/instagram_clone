import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../enums/enums.dart';
import './cubit/bottom_navbar_cubit.dart';
import './widgets/widgets.dart';
import '../../widgets/widgets.dart';

class NavScreen extends StatelessWidget {
  static const routeName = '/nav';
  static Route route() => FadeRoute(
        page: BlocProvider<BottomNavbarCubit>(
          create: (_) => BottomNavbarCubit(),
          child: NavScreen(),
        ),
        routeName: routeName,
      );

  final Map<BottomNavbarItem, GlobalKey<NavigatorState>> navigatorKeys = {
    BottomNavbarItem.feed: GlobalKey<NavigatorState>(),
    BottomNavbarItem.search: GlobalKey<NavigatorState>(),
    BottomNavbarItem.create: GlobalKey<NavigatorState>(),
    BottomNavbarItem.notifications: GlobalKey<NavigatorState>(),
    BottomNavbarItem.profile: GlobalKey<NavigatorState>(),
  };

  final Map<BottomNavbarItem, IconData> items = const {
    BottomNavbarItem.feed: Icons.home_filled,
    BottomNavbarItem.search: Icons.search_outlined,
    BottomNavbarItem.create: Icons.add,
    BottomNavbarItem.notifications: Icons.favorite_border,
    BottomNavbarItem.profile: Icons.account_circle,
  };

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocBuilder<BottomNavbarCubit, BottomNavbarState>(
        builder: (context, state) => Scaffold(
          body: Stack(
            children: items.map((item, icon) => MapEntry(item, _buildOffstageNavigator(item, item == state.selectedItem))).values.toList(),
          ),
          bottomNavigationBar: BottomNavbar(
            items: items,
            selectedItem: state.selectedItem,
            onTap: (index) {
              final selectedItem = BottomNavbarItem.values[index];

              _selectBottomNavItem(context, selectedItem, selectedItem == state.selectedItem);
            },
          ),
        ),
      ),
    );
  }

  void _selectBottomNavItem(BuildContext context, BottomNavbarItem selectedItem, bool isSameItem) {
    if (isSameItem) {
      navigatorKeys[selectedItem]!.currentState!.popUntil((route) => route.isFirst);
    }
    context.read<BottomNavbarCubit>().updateSelectedItem(selectedItem);
  }

  Widget _buildOffstageNavigator(BottomNavbarItem currentItem, bool isSelected) {
    return Offstage(
      child: TabNavigator(
        navigatorKey: navigatorKeys[currentItem]!,
        item: currentItem,
      ),
      offstage: !isSelected,
    );
  }
}
