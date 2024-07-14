import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileDrawer extends StatefulWidget {
  @override
  State<ProfileDrawer> createState() => _ProfileDrawerState();
}

class _ProfileDrawerState extends State<ProfileDrawer> {
  User? _user;
  String? _userName;
  String? _email;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _user = user;
      });
      await _getUserDetails(user.uid);
    }
  }

  Future<void> _getUserDetails(String uid) async {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('UserData').doc(uid).get();
    if (userDoc.exists) {
      setState(() {
        _userName = userDoc['username'];
        _email = userDoc['email'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 226, 246, 255),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 250,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 215, 202, 243),
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
                    _userName ??
                        'Loading...', // Show 'Loading...' while fetching
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    _email ?? 'Loading...', // Show 'Loading...' while fetching
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
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
            leading: Icon(Icons.pets),
            title: Text('My pets'),
            onTap: () {
              Navigator.of(context).pop();
              GoRouter.of(context).go('/mypets');
            },
          ),
          ListTile(
            leading: Icon(Icons.store_rounded),
            title: Text('Pet Mart'),
            onTap: () {
              Navigator.of(context).pop();
              GoRouter.of(context).go('/store');
            },
          ),
          ListTile(
            leading: Icon(Icons.post_add_rounded),
            title: Text('Community'),
            onTap: () {
              Navigator.of(context).pop();
              GoRouter.of(context).go('/posts');
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Sign Out'),
            onTap: () {
              Navigator.of(context).pop();
              GoRouter.of(context).go('/signin');
            },
          )
        ],
      ),
    );
  }
}
