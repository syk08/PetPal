
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            GoRouter.of(context).go('/dashboard');
          },
        ),
        title: Text('Vet Clinic'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0, bottom: 16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              buildCard(context, 'Our Vet Location','/allvet'),
              SizedBox(height: 20), // Add spacing between cards
              buildCard(context, 'Vets Near You','/vets_near'),
              SizedBox(height: 20), // Add spacing between cards
              buildCard(context, 'Subscribe','/allvet'),
              SizedBox(height: 20), // Add spacing between cards
              buildCard(context, 'Chat With Your Vet','/allvet'),
              
            ],
          ),
        ),
      ),
    );
  }
  Widget buildCard(BuildContext context, String title, String route) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Container(
          width: 250, // Adjust this value to make the card square
          height: 100, // Same value as width to ensure square shape
          child: Center(
            child: ListTile(
              title: Center(child: Text(title, textAlign: TextAlign.center)),
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
