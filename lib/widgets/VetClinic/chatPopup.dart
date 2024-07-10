import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../screens/vetClinic/chat/WhatsappChat.dart';

void Chatpopup(BuildContext context) {
  List<String> titles = [
    'Mirpur Pet Animal Clinic',
    'Pet Care & Vet Point',
    'Royal Pet Care',
    'Vet and Pet Care (VNPC)'
  ];
  List<String> desc = [
    'Your trusted destination for all pet care essentials.',
    'Quality products and services for your beloved pets.',
    'Where your pets health and happiness come first.',
    'Comprehensive care solutions for every pet need.'
  ];
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        surfaceTintColor: Color.fromARGB(255, 223, 138, 189),

        title: Text('Get counsel anytime, day or night..'),
        content: Scrollbar(
          thumbVisibility: true,
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(
                4,
                (index) => Card(
                  elevation: 5,
                  surfaceTintColor: Color.fromARGB(255, 254, 140, 1),
                  shadowColor: Colors.black,
                  
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                'assets/images/vet$index.jpg', // Replace with your local image path
                                width: 35,
                                height: 35,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                                width:
                                    10), // Add some space between the image and the text
                            Text(titles[index]),
                          ],
                        ),
                        SizedBox(height: 10), // Space between rows
                        Text(desc[index]),
                        SizedBox(
                            height: 10), // Space between description and footer

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 5),
                            SizedBox(
                              width: 200, // Set the width of the button
                              child: ElevatedButton(
                                onPressed: () {
                                  // Add your subscribe action here
                                  context.go(
                                    '/chat',
                                    extra: {
                                      'path': index,
                                      'name': titles[index],
                                    },
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(
                                          Color.fromARGB(0, 252, 114,
                                              114)), // Background color
                                  foregroundColor:
                                      WidgetStateProperty.all<Color>(
                                          const Color.fromARGB(
                                              255, 0, 0, 0)), // Text color
                                  side: WidgetStateProperty.all<BorderSide>(
                                      const BorderSide(
                                          color: Color.fromARGB(255, 43, 179,
                                              57))), // Border color
                                  elevation: WidgetStateProperty.all<double>(0),
                                  shape: WidgetStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            5) // Set border radius to zero
                                        ),
                                  ),
                                  // Remove shadow
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Flexible(
                                      child: Text(
                                        'Chat With An Expert',
                                        style: TextStyle(
                                            fontSize: 12), // Reduced text size
                                        overflow: TextOverflow
                                            .ellipsis, // Prevent overflow by ellipsizing the text
                                      ),
                                    ),
                                    const SizedBox(
                                        width:
                                            10), // Add some space between the text and the image
                                    Image.asset(
                                      'assets/images/whatsapp.png', // Replace with your local image path
                                      width: 20,
                                      height: 20,
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        actionsPadding: EdgeInsets.symmetric(
            horizontal: 8.0, vertical: 0.5), // Reduced padding
        actions: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              child: Text(
                'Close',
                style: TextStyle(
                    color: Colors.black), // Set the text color to black
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      );
    },
  );
}

Widget ChatCardPopup(BuildContext context, String title) {
  return Center(
    child: Card(
      elevation: 15,
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
                'assets/images/chat_icon.png', // Replace with your local image path
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              title,
              textAlign: TextAlign.center,
              // Prevent text overflow
            ),
            onTap: () async {
              Chatpopup(context);
            },
          ),
        ),
      ),
    ),
  );
}
