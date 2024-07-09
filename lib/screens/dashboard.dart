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
  List<Map<String, dynamic>>? _images;

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
      await _getImages();
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

  Future<void> _getImages() async {
    QuerySnapshot postQuery =
        await FirebaseFirestore.instance.collection('images').get();
    List<Map<String, dynamic>> fetchedPosts = postQuery.docs.map((doc) {
      return {
        'imageURL': doc['imageUrl'],
      };
    }).toList();
    setState(() {
      _images = fetchedPosts;
    });
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
    } else if (index == 3) {
      GoRouter.of(context).go('/store');
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
                            title: 'Pet Mart',
                            icon: Icons.store_rounded,
                            route: '/store'),
                        SliderWidget(
                            context: context,
                            title: 'Adopt',
                            icon: Icons.favorite,
                            route: '/posts'),
                        SliderWidget(
                            context: context,
                            title: 'Lost & Found',
                            icon: Icons.search,
                            route: '/posts'),
                        SliderWidget(
                            context: context,
                            title: 'Virtual Vet',
                            icon: Icons.local_hospital,
                            route: '/vet'),
                      ],
                    ),
                  ),
                  // Other content of the dashboard goes here...
                  Container(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('images')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }

                        var images = snapshot.data!.docs;

                        return Expanded(
                          child: ListView(
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;
                              return ListTile(
                                title: Text(
                                  data['imageUrl'].toString(),
                                  //style: Theme.of(context).textTheme.headline1,
                                ),
                                subtitle: Image(
                                  image: NetworkImage(data[
                                      'imageUrl']), // ----------- the line that should change
                                  width: 300,
                                  height: 300,
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
                  ),
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
