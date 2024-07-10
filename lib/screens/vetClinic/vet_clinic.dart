import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import '../../global_state.dart';
import '../../widgets/VetClinic/chatPopup.dart';
import '../../widgets/VetClinic/subscribePopup.dart';

class VetClinic extends StatefulWidget {
  @override
  _VetClinicState createState() => _VetClinicState();
}

class _VetClinicState extends State<VetClinic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFADD9E6),
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
              image: AssetImage('assets/images/vet_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          
                    padding: const EdgeInsets.only(
              top: 0, left: 16.0, right: 16.0, bottom: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            
            children: [
               SizedBox(height: 300),
              Row(
                
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildCard(context, 'Our Vet Location', '/allvet', 'map_loc'),
                  buildCard(
                      context, 'Vets Near You', '/vets_near', 'Near_Icon'),
                ],
              ),
              SizedBox(height: 10), // Add spacing between rows
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildCardPopup(context, 'Subscribe'),
                  ChatCardPopup(context, 'Text Our Vet'),
                ],
              ),
              SizedBox(height: 100), // Add spacing after the rows
            ],
          ),
        ),
      ]),
    );
  }

  Widget buildCard(
      BuildContext context, String title, String route, String path) {
    return Center(
      child: Card(
        elevation: 15,
        //color:Color.fromARGB(255, 179, 172, 78),
        surfaceTintColor: Color.fromARGB(255, 254, 140, 1),
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Container(
          width: 170, // Adjust this value to make the card square
          height: 100, // Same value as width to ensure square shape
          child: Center(
            child: ListTile(
              leading: Container(
                width: 35,
                height: 35,
                child: Image.asset(
                  'assets/images/$path.png', // Replace with your local image path
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                title,
                textAlign: TextAlign.center,
                // Prevent text overflow
              ),
              onTap: () async {
                GoRouter.of(context).go(route);
              },
             // Adjust padding if necessary
            ),
          ),
        ),
      ),
    );
  }
}
