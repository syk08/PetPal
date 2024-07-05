import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'dashboard.dart';
import '../core/util.dart';

class Home extends StatefulWidget {
  

  Home({Key? key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).go('/dashboard');
      },
      child: Scaffold(
        backgroundColor: CustomColors.Yellow,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              
              SvgPicture.asset('assets/images/Logo.svg'),
              SizedBox(height: 15),
              Text(
                'Pet Pal',
                style: TextStyle(
                    fontFamily: 'Pacifico', color: Colors.white, fontSize: 32),
              )
            ],
          ),
        ),
      ),
    );
  }
}
