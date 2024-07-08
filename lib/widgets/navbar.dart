import 'package:flutter/material.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final int currentIndex;
  final ValueChanged<int> onTap;

  Navbar({
    required this.title,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontFamily: 'Pacifico',
            fontSize: 30,
            fontWeight: FontWeight.w500),
      ),
      backgroundColor: Color.fromARGB(255, 157, 208, 232),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class BottomNavbar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  BottomNavbar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: Color.fromARGB(255, 157, 208, 232),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: Colors.white,
          ),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.pets,
            color: Colors.white,
          ),
          label: 'My Pets',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.post_add,
            color: Colors.white,
          ),
          label: 'Community',
        ),
      ],
    );
  }
}
