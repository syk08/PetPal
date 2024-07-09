import 'package:flutter/material.dart';
import 'package:pet_pal/screens/cart.dart';

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
      actions: [
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartPage(),
              ),
            );
          },
        ),
      ],
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
      selectedItemColor: Colors.white, // Set the color for selected item
      unselectedItemColor: Colors.white70,
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
        BottomNavigationBarItem(
          icon: Icon(
            Icons.store,
            color: Colors.white,
          ),
          label: 'PetMart',
        ),
      ],
    );
  }
}
