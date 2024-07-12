import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_pal/widgets/navbar.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      GoRouter.of(context).go('/dashboard');
    } else if (index == 1) {
      GoRouter.of(context).go('/mypets');
    } else if (index == 2) {
      GoRouter.of(context).go('/posts');
    } else if (index == 3) {
      GoRouter.of(context).go('/store');
    }
  }

  User? _user;
  String? _userName;
  String? _email;
  String? _phone;

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
        _phone = userDoc['phone_no'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 215, 202, 243),
      appBar: Navbar(
        title: 'Profile',
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 90,
            backgroundImage: AssetImage('assets/images/profile.png'),
          ),
          SizedBox(height: 20),
          Text(
            _userName ?? 'Loading...',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          ListTile(
            leading: Icon(Icons.email),
            title: Text(
              _email ?? 'Loading...',
            ),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text(
              _phone ?? 'Loading...',
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavbar(
        currentIndex: 0, // Adjust index as per your navigation setup
        onTap: (index) {
          // Implement navigation logic here based on the index
          if (index == 0) {
            GoRouter.of(context).go('/dashboard');
          } else if (index == 1) {
            GoRouter.of(context).go('/mypets');
          } else if (index == 2) {
            GoRouter.of(context).go('/posts');
          } else if (index == 3) {
            GoRouter.of(context).go('/store');
          }
        },
      ),
    );
  }
}
