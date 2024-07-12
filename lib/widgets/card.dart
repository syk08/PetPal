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
        color: Color.fromARGB(255, 157, 208, 232),
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
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (imageType == 'svg')
              SvgPicture.asset(
                'assets/images/$image.svg',
                height: 70,
              ),
            if (imageType == 'png')
              Image.asset(
                'assets/images/$image.png',
                height: 70,
              ),
            if (imageType == 'url')
              CircleAvatar(
                backgroundImage: NetworkImage(
                  image,
                ),
                radius: 40,
              ),
            SizedBox(height: 10),
            Text(
              text.isNotEmpty ? text : 'No Text',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    ),
  );
}

Widget postcard(
    context, String image, String imageType, String text, String petname) {
  print(imageType);
  return Container(
    margin: EdgeInsets.all(2),
    height: MediaQuery.of(context).size.height / 2,
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 157, 208, 232),
      borderRadius: BorderRadius.all(
        Radius.circular(15),
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
    child: Container(
      height: 200,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (imageType == 'svg')
            SvgPicture.asset(
              'assets/images/$image.svg',
              height: 70,
            ),
          if (imageType == 'png')
            Image.asset(
              'assets/images/$image.png',
              height: 70,
            ),
          if (imageType == 'url')
            Container(
                child: CircleAvatar(
              backgroundImage: NetworkImage(image),
              radius: 22,
            )),
          SizedBox(height: 5),
          Text(
            text.isNotEmpty ? text : 'No Text',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          )
        ],
      ),
    ),
  );
}
