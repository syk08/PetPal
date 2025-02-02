import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_pal/core/loadingscreen.dart';
import 'package:pet_pal/widgets/navbar.dart';
import '../core/util.dart';
import '../widgets/card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../widgets/slider_widget.dart';
import '../widgets/profile_drawer.dart';
import 'mymap.dart';

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
  //List<Map<String, dynamic>>? _pets = [];

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
      //await _getPets();
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
        await FirebaseFirestore.instance.collection('posts').get();
    List<Map<String, dynamic>> fetchedPosts = postQuery.docs.map((doc) {
      return {
        'imageURL': doc['imageUrl'],
        'poster': doc['poster'],
      };
    }).toList();
    setState(() {
      _images = fetchedPosts;
    });
  }

  // Future<void> _getPets() async {
  //   QuerySnapshot petQuery =
  //       await FirebaseFirestore.instance.collection('pets').get();
  //   // List<Map<String, dynamic>> fetchedPets = petQuery.docs.map((doc) {
  //   //   return {
  //   //     'imageURL': doc['imageUrl'],
  //   //     'name': doc['name'],
  //   //   };
  //   // }).toList();

  //   List<Map<String, dynamic>> fetchedPets = [];

  //   petQuery.docs.forEach((doc) {
  //     // Check if pet is already in fetchedPets
  //     if (!fetchedPets.any((pet) => pet['name'] == doc['name'] && pet['owner']==doc['owner'])) {
  //       fetchedPets.add({
  //         'imageURL': doc['imageUrl'],
  //         'name': doc['name'],
  //       });
  //     }
  //   });

  //   setState(() {
  //     _pets = fetchedPets;
  //   });
  // }

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
        ? getLoader()
        : Scaffold(
            backgroundColor: Colors.transparent,
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
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/home2.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 6,
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: MediaQuery.of(context).size.height / 6,
                            aspectRatio: 16 / 12,
                            viewportFraction: 0.4,
                            enlargeCenterPage: true,
                            autoPlay: true, // Enable auto play
                            autoPlayInterval:
                                Duration(seconds: 3), // Time between auto plays
                            autoPlayAnimationDuration: Duration(
                                milliseconds: 800), // Animation duration
                            autoPlayCurve: Curves.fastOutSlowIn,
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
                                title: 'Virtual Vet',
                                icon: Icons.local_hospital,
                                route: '/vet'),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        alignment: Alignment.center,
                        color: Color.fromARGB(255, 157, 208, 232),
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          "Posts",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontFamily: 'Pacifico'),
                        ),
                      ),
                      // posts
                      _images == null || _images!.isEmpty
                          ? Container(
                              color:
                                  Colors.transparent, // Transparent background
                              margin: EdgeInsets.all(2),
                              padding: EdgeInsets.all(5),
                              height: MediaQuery.of(context).size.height / 6,
                              child: Center(
                                child: LoadingAnimationWidget
                                    .horizontalRotatingDots(
                                        color: Colors.white, size: 40),
                              ),
                            )
                          : Container(
                              color:
                                  Colors.transparent, // Transparent background
                              margin: EdgeInsets.all(2),
                              padding: EdgeInsets.all(5),
                              height: MediaQuery.of(context).size.height / 5,
                              child: CarouselSlider(
                                options: CarouselOptions(
                                  height:
                                      MediaQuery.of(context).size.height / 6,
                                  aspectRatio: 16 / 12,
                                  viewportFraction: 0.4,
                                  enlargeCenterPage: true,
                                  autoPlay: true, // Enable auto play
                                  autoPlayInterval: Duration(
                                      seconds: 3), // Time between auto plays
                                  autoPlayAnimationDuration: Duration(
                                      milliseconds: 800), // Animation duration
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                ),
                                items: _images!.map((post) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                2,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        child: postcard(
                                          context,
                                          post['imageURL'],
                                          'url',
                                          post['poster'] ?? 'No Poster',
                                          post['poster'] ?? 'No Poster',
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                      SizedBox(height: 15),
                      Container(
                        alignment: Alignment.center,
                        color: Color.fromARGB(255, 157, 208, 232),
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          "My Pets",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontFamily: 'Pacifico'),
                        ),
                      ),
                      // pets
                      Container(
                        color: Colors.transparent, // Transparent background
                        margin: EdgeInsets.all(2),
                        padding: EdgeInsets.all(5),
                        height: MediaQuery.of(context).size.height / 5,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('pets')
                              .where('owner', isEqualTo: _userName)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Container(
                                color: Colors
                                    .transparent, // Transparent background
                                margin: EdgeInsets.all(2),
                                padding: EdgeInsets.all(5),
                                height: MediaQuery.of(context).size.height / 6,
                                child: Center(
                                  child: LoadingAnimationWidget
                                      .horizontalRotatingDots(
                                          color: Colors.white, size: 40),
                                ),
                              );
                            }
                            if (!snapshot.hasData ||
                                snapshot.data!.docs.isEmpty) {
                              return Center(child: Text('No pets found.'));
                            }

                            var pets = snapshot.data!.docs;

                            return ListView.builder(
                              itemCount: pets.length,
                              itemBuilder: (context, index) {
                                var pet =
                                    pets[index].data() as Map<String, dynamic>;
                                return Card(
                                  margin: EdgeInsets.all(10.0),
                                  elevation: 4.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(
                                          0.1), // Set transparency here
                                      borderRadius: BorderRadius.circular(15.0),
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //     color: Colors.black12,
                                      //     blurRadius: 4.0,
                                      //     spreadRadius: 2.0,
                                      //   ),
                                      // ],
                                    ),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: pet['imageUrl'] != null
                                            ? NetworkImage(pet['imageUrl'])
                                            : AssetImage(
                                                    'assets/placeholder.png')
                                                as ImageProvider,
                                      ),
                                      title: Text(
                                        pet['name'] ?? 'No Name',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      trailing: IconButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MyMap(pet['name'])));
                                          },
                                          icon: const Icon(Icons.pets),
                                          color: const Color.fromARGB(
                                              255, 157, 208, 232)),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
            bottomNavigationBar: BottomNavbar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
          );
  }
}
