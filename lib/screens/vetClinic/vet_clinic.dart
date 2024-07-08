import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../global_state.dart';

class VetClinic extends StatefulWidget {
  @override
  _VetClinicState createState() => _VetClinicState();
}

class _VetClinicState extends State<VetClinic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 249, 190, 179),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            GoRouter.of(context).go('/dashboard');
          },
        ),
        title: Text(
          'Vet Clinic',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Pacifico',
              fontSize: 30,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: Stack(children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/signup.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: 16.0, left: 16.0, right: 16.0, bottom: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildCard(context, 'Our Vet Location', '/allvet'),
              SizedBox(height: 10), // Add spacing between cards
              buildCard(context, 'Vets Near You', '/vets_near'),
              SizedBox(height: 10), // Add spacing between cards
              buildCard(context, 'Subscribe', '/allvet'),
              SizedBox(height: 10), // Add spacing between cards
              buildCard(context, 'Chat With Your Vet', '/allvet'),
              SizedBox(height: 100),
            ],
          ),
        ),
      ]),
    );
  }

  Widget buildCard(BuildContext context, String title, String route) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Container(
          width: 200, // Adjust this value to make the card square
          height: 50, // Same value as width to ensure square shape
          child: Center(
            child: ListTile(
              title: Text(title, textAlign: TextAlign.center),
              onTap: () async {
                GoRouter.of(context).go(route);
              },
            ),
          ),
        ),
      ),
    );
  }
}
