import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_pal/screens/mymap.dart';

import '../core/util.dart';

Widget card(
    context, String image, String imageType, String text, String petname,
    [String? route_dir]) {
  print(imageType);
  return GestureDetector(
    onTap: () {
      if (route_dir == 'addpets') {
        GoRouter.of(context).go('/$route_dir');
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MyMap(petname)));
      }
      //MyMap(petname);
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
          if (imageType == 'svg') SvgPicture.asset('assets/images/$image.svg'),
          if (imageType == 'png') Image.asset('assets/images/$image.png'),
          if (imageType == 'url') Image.network(image),
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
