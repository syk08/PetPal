import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';


import '../core/util.dart';

import '../screens/mypets.dart';

Widget card(context, String image, String imageType, String text,  [String? route_dir]) {
  print(imageType);
  return GestureDetector(
       onTap: () {
     
        GoRouter.of(context).go('/$route_dir');
    
    },
      child: Container(
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: CustomColors.BoxShadow,
            blurRadius: 20.0,
            spreadRadius: 0.0,
            offset: Offset(0.0, 0.0),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          imageType == 'svg' ? SvgPicture.asset('assets/images/$image.svg') : Image.asset('assets/images/$image.png'),
          SizedBox(height: 20),
          Text(
            text,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          )
        ],
      ),
    ),
  );
}
