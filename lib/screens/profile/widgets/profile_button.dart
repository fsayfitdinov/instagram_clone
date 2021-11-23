import 'package:flutter/material.dart';
import 'package:instagram/screens/screens.dart';

class ProfileButton extends StatelessWidget {
  final bool isCurrentUser;
  final bool isFollowing;

  const ProfileButton({
    Key? key,
    required this.isCurrentUser,
    required this.isFollowing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isCurrentUser
        ? TextButton(
            onPressed: () => Navigator.pushNamed(
              context,
              EditProfileScreen.routeName,
              arguments: EditProfileArgs(context: context),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
            ),
            child: Text(
              'Edit Profile',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          )
        : TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: isFollowing ? Colors.grey[300] : Theme.of(context).primaryColor,
            ),
            child: Text(
              isFollowing ? 'Unfollow' : 'Follow',
              style: TextStyle(
                fontSize: 16,
                color: isFollowing ? Colors.black : Colors.white,
              ),
            ),
          );
  }
}
