import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_pal/widgets/navbar.dart';
import '../core/util.dart';
import '../widgets/card.dart';

class Dashboard extends StatefulWidget {
  static const routeName = '/dashboard';

  Dashboard({Key? key}) : super(key: key);

  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: 'Dashboard',
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      backgroundColor: Colors.white,
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
          //           'Your Pet\'s',
          //           style: TextStyle(fontSize: 45, fontWeight: FontWeight.w500),
          //         ),
          //         Text(
          //           'is here now!',
          //           style: TextStyle(fontSize: 45, fontWeight: FontWeight.w500),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          SliverGrid.count(
            crossAxisCount: 2,
            children: <Widget>[
              card(context, 'MyProfile', 'svg', 'My Profile', 'mypets'),
              card(context, 'MyPets', 'svg', 'My Pets', 'mypets'),
              card(context, 'Appointments', 'svg', 'Appointments', 'mypets'),
              card(context, 'MedicalRecords', 'svg', 'Medical Records',
                  'mypets'),
              card(context, 'Notifications', 'svg', 'Notifications', 'mypets'),
              card(context, 'MyPets', 'svg', 'Community', 'posts'),
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
