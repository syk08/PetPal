import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_pal/widgets/navbar.dart';

import '../widgets/card.dart';

class MyPets extends StatefulWidget {
  static const routeName = '/mypets';

  MyPets({Key? key}) : super(key: key);

  _MyPetsState createState() => _MyPetsState();
}

class _MyPetsState extends State<MyPets> {
  int _selectedIndex = 1;

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
    return Scaffold(
      appBar: Navbar(
        title: 'My Pets',
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      backgroundColor: Color.fromARGB(255, 207, 232, 255),
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: <Widget>[
          // SliverToBoxAdapter(
          //   child: Container(
          //     height: 136,
          //     margin: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: <Widget>[
          //         Text(
          //           'My Pet\'s',
          //           style: TextStyle(fontSize: 45, fontWeight: FontWeight.w500),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          SliverGrid.count(
            crossAxisCount: 2,
            children: <Widget>[
              card(context, 'AddPets', 'svg', 'Add Pets', "", 'addpets'),
              StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('pets').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  // Display pet cards
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var pet = snapshot.data!.docs[index];
                      return card(context, pet['imageUrl'], 'url', pet['name'],
                          pet['name']);
                    },
                  );
                },
              ),
              // card(context, 'Simba', 'png', 'Simba', 'Simba'),
              // card(context, 'Bella', 'png', 'Bella', 'Bella'),
              // card(context, 'Johny', 'png', 'Johny', 'Johny')
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavbar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
