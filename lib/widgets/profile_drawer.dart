import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 255, 235, 121),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 250,
            child: const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 247, 175, 68),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Namu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'namu@iut-dhaka.edu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context).pop();
              GoRouter.of(context).go('/dashboard');
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Navigator.of(context).pop();
              GoRouter.of(context).go('/profile');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.of(context).pop();
              GoRouter.of(context).go('/settings');
            },
          ),
        ],
      ),
    );
  }
}
