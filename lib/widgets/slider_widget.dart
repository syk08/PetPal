import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget({
    super.key,
    required this.context,
    required this.title,
    required this.icon,
    required this.route,
  });

  final BuildContext context;
  final String title;
  final IconData icon;
  final String route;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).go(route);
      },
      child: Card(
        color: Color.fromARGB(255, 157, 208, 232),
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50,
                color: Colors.white,
              ),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
