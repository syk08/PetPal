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
        backgroundColor: Color.fromARGB(255, 218, 175, 243),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.pets,
                size: 120,
                color: Colors.white,
              ),
              SizedBox(height: 15),
              Text(
                'PetPal',
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
