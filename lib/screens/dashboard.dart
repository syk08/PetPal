import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_pal/widgets/navbar.dart';
import '../core/util.dart';
import '../widgets/card.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../widgets/slider_widget.dart';
import '../widgets/profile_drawer.dart';

class Dashboard extends StatefulWidget {
  static const routeName = '/dashboard';

  Dashboard({Key? key}) : super(key: key);

  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  User? _user;
  String? _userName;

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
      });
    }
  }

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
    }
  }

  @override
  Widget build(BuildContext context) {
    return _userName == null
        ? CircularProgressIndicator()
        : Scaffold(
            backgroundColor: Color.fromARGB(255, 147, 224, 219),
            appBar: Navbar(
              title: 'Hello, ${_userName}',
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
            drawer: ProfileDrawer(),
            body: Stack(children: [
              // Background Image
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/home2.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height / 6,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height / 6,
                        aspectRatio: 16 / 12,
                        viewportFraction: 0.4,
                        enlargeCenterPage: true,
                      ),
                      items: [
                        SliderWidget(
                            context: context,
                            title: 'Profile',
                            icon: Icons.person,
                            route: '/profile'),
                        SliderWidget(
                            context: context,
                            title: 'My Pets',
                            icon: Icons.pets,
                            route: '/mypets'),
                        SliderWidget(
                            context: context,
                            title: 'Community',
                            icon: Icons.group,
                            route: '/posts'),
                        SliderWidget(
                            context: context,
                            title: 'Adopt',
                            icon: Icons.favorite,
                            route: '/adopt'),
                        SliderWidget(
                            context: context,
                            title: 'Lost & Found',
                            icon: Icons.search,
                            route: '/lostfound'),
                        SliderWidget(
                            context: context,
                            title: 'Virtual Vet',
                            icon: Icons.local_hospital,
                            route: '/vet'),
                      ],
                    ),
                  ),
                  // Other content of the dashboard goes here...
                ],
              ),
            ]),
            bottomNavigationBar: BottomNavbar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
          );
  }
}
