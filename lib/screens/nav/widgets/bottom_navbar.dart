import 'package:flutter/material.dart';
import 'package:instagram/enums/enums.dart';

class BottomNavbar extends StatelessWidget {
  final Map<BottomNavbarItem, IconData> items;
  final BottomNavbarItem selectedItem;
  final Function(int) onTap;

  const BottomNavbar({
    Key? key,
    required this.items,
    required this.selectedItem,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: BottomNavbarItem.values.indexOf(selectedItem),
      onTap: onTap,
      items: items
          .map(
            (item, icon) => MapEntry(
              item.toString(),
              BottomNavigationBarItem(
                label: '',
                icon: Icon(icon, size: 30),
              ),
            ),
          )
          .values
          .toList(),
    );
  }
}
