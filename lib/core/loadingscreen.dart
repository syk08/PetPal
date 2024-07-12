import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget getLoader() {
  return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/home2.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      //color: Color.fromARGB(255, 157, 208, 232).withOpacity(1.5) ),
      child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child:
              LoadingAnimationWidget.inkDrop(color: Colors.white, size: 75)));
}
