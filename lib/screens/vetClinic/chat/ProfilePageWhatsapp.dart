import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ProfilePageWhatsapp extends StatefulWidget {
  const ProfilePageWhatsapp({super.key, required this.path, required this.name});

  final int path;
  final String name;


  @override
  // ignore: library_private_types_in_public_api
   
  _ProfilePageWhatsappState createState() => _ProfilePageWhatsappState();
}

class _ProfilePageWhatsappState extends State<ProfilePageWhatsapp> {
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  @override
   
  Widget build(BuildContext context) {
    return Scaffold(
       
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('Contact info'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.go(
              '/chat',
              extra: {
                'path': widget.path,
                'name': widget.name,
              },
            );
          },
        ),
        actions: [
          Container(
            child: Text("Edit"),
            padding: EdgeInsets.all(15),
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(height: 20),
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/vet${widget.path}.jpg'),
          ),
          SizedBox(height: 10),
          Text(
            widget.name,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text('+880 1715-155313'),
          SizedBox(height: 20),
          Container(
            width: MediaQuery.sizeOf(context).width * 0.95,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: (MediaQuery.sizeOf(context).width * 0.95) / 3.2,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color.fromARGB(255, 30, 30, 30),
                    ),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.call,
                          color: Color.fromARGB(255, 75, 255, 99),
                        ),
                        Gap(12),
                        Text("Audio")
                      ],
                    )),
                Gap(7),
                Container(
                    width: (MediaQuery.sizeOf(context).width * 0.95) / 3.2,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color.fromARGB(255, 30, 30, 30),
                    ),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.videocam_outlined,
                          color: Color.fromARGB(255, 75, 255, 99),
                        ),
                        Gap(12),
                        Text("Video")
                      ],
                    )),
                const Gap(7),
                Container(
                    width: (MediaQuery.sizeOf(context).width * 0.95) / 3.2,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color.fromARGB(255, 30, 30, 30),
                    ),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.search_outlined,
                          color: Color.fromARGB(255, 75, 255, 99),
                        ),
                        Gap(12),
                        Text("Search")
                      ],
                    ))
              ],
            ),
          ),
          const Gap(12),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromARGB(255, 30, 30, 30),
            ),
            width: MediaQuery.sizeOf(context).width * 0.95,
            child: ListTile(
              title: Text('Hey there! I am using WhatsApp.'),
              subtitle: Text('17 Dec, 2021'),
            ),
          ),
          Gap(12),
          Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero),
                  color: Color.fromARGB(255, 30, 30, 30),
                ),
                width: MediaQuery.sizeOf(context).width * 0.95,
                child: ListTile(
                  leading: Icon(Icons.insert_drive_file),
                  title: Text('Media, links and docs'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('372', style: TextStyle(color: Colors.white)),
                      Gap(5),
                      Icon(Icons.chevron_right, color: Colors.white),
                    ],
                  ),
                  onTap: () {
                    // Handle tap
                  },
                ),
              ),
              Divider(
                  height: 1,
                  thickness: 0.5,
                  color: Colors.grey,
                  indent: MediaQuery.sizeOf(context).width * 0.05 / 2,
                  endIndent: MediaQuery.sizeOf(context).width * 0.05 / 2),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      topLeft: Radius.zero,
                      topRight: Radius.zero),
                  color: Color.fromARGB(255, 30, 30, 30),
                ),
                width: MediaQuery.sizeOf(context).width * 0.95,
                child: ListTile(
                  leading: Icon(Icons.star),
                  title: Text('Starred messages'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('None', style: TextStyle(color: Colors.white)),
                      Gap(5),
                      Icon(Icons.chevron_right, color: Colors.white),
                    ],
                  ),
                  onTap: () {
                    // Handle tap
                  },
                ),
              ),
            ],
          ),
          Gap(12),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero),
                  color: Color.fromARGB(255, 30, 30, 30),
                ),
                width: MediaQuery.sizeOf(context).width * 0.95,
                child: ListTile(
                  leading: Icon(Icons.notifications),
                  title: Text('Notifications'),
                  trailing: Icon(Icons.chevron_right, color: Colors.white),
                  onTap: () {
                    // Handle tap
                  },
                ),
              ),
              Divider(
                  height: 1,
                  thickness: 0.5,
                  color: Colors.grey,
                  indent: MediaQuery.sizeOf(context).width * 0.05 / 2,
                  endIndent: MediaQuery.sizeOf(context).width * 0.05 / 2),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero,
                      topLeft: Radius.zero,
                      topRight: Radius.zero),
                  color: Color.fromARGB(255, 30, 30, 30),
                ),
                width: MediaQuery.sizeOf(context).width * 0.95,
                child: ListTile(
                  leading: Icon(Icons.wallpaper),
                  title: Text('Wallpaper'),
                  trailing: Icon(Icons.chevron_right, color: Colors.white),
                  onTap: () {
                    // Handle tap
                  },
                ),
              ),
              Divider(
                  height: 1,
                  thickness: 0.5,
                  color: Colors.grey,
                  indent: MediaQuery.sizeOf(context).width * 0.05 / 2,
                  endIndent: MediaQuery.sizeOf(context).width * 0.05 / 2),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      topLeft: Radius.zero,
                      topRight: Radius.zero),
                  color: Color.fromARGB(255, 30, 30, 30),
                ),
                width: MediaQuery.sizeOf(context).width * 0.95,
                child: ListTile(
                  leading: Icon(Icons.save_alt),
                  title: Text('Save to Photos'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Default', style: TextStyle(color: Colors.white)),
                      Gap(5),
                      Icon(Icons.chevron_right, color: Colors.white),
                    ],
                  ),
                  onTap: () {
                    // Handle tap
                  },
                ),
              ),
            ],
          ),
          Gap(12),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero),
                  color: Color.fromARGB(255, 30, 30, 30),
                ),
                width: MediaQuery.sizeOf(context).width * 0.95,
                child: ListTile(
                  leading: Icon(Icons.lock),
                  title: Text('Encryption'),
                  subtitle: Text(
                      'Messages and calls are end-to-end encrypted. Tap to verify.'),
                  trailing: Icon(Icons.chevron_right, color: Colors.white),
                  onTap: () {
                    // Handle tap
                  },
                ),
              ),
              Divider(
                  height: 1,
                  thickness: 0.5,
                  color: Colors.grey,
                  indent: MediaQuery.sizeOf(context).width * 0.05 / 2,
                  endIndent: MediaQuery.sizeOf(context).width * 0.05 / 2),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero,
                      topLeft: Radius.zero,
                      topRight: Radius.zero),
                  color: Color.fromARGB(255, 30, 30, 30),
                ),
                width: MediaQuery.sizeOf(context).width * 0.95,
                child: ListTile(
                  leading: Icon(Icons.timer),
                  title: Text('Disappearing messages'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Off', style: TextStyle(color: Colors.white)),
                      Gap(5),
                      Icon(Icons.chevron_right, color: Colors.white),
                    ],
                  ),
                  onTap: () {
                    // Handle tap
                  },
                ),
              ),
              Divider(
                  height: 1,
                  thickness: 0.5,
                  color: Colors.grey,
                  indent: MediaQuery.sizeOf(context).width * 0.05 / 2,
                  endIndent: MediaQuery.sizeOf(context).width * 0.05 / 2),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      topLeft: Radius.zero,
                      topRight: Radius.zero),
                  color: Color.fromARGB(255, 30, 30, 30),
                ),
                width: MediaQuery.sizeOf(context).width * 0.95,
                child: ListTile(
                  leading: Icon(Icons.lock_outline),
                  title: Text('Lock chat'),
                  trailing: Switch(
                    value: false,
                    onChanged: (value) {
                      // Handle switch
                    },
                  ),
                ),
              ),
            ],
          ),
          Gap(12),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero),
                  color: Color.fromARGB(255, 30, 30, 30),
                ),
                width: MediaQuery.sizeOf(context).width * 0.95,
                child: ListTile(
                  title: Text(
                    "Share Contact",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ),
              Divider(
                  height: 1,
                  thickness: 0.5,
                  color: Colors.grey,
                  indent: MediaQuery.sizeOf(context).width * 0.05 / 2,
                  endIndent: MediaQuery.sizeOf(context).width * 0.05 / 2),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero,
                      topLeft: Radius.zero,
                      topRight: Radius.zero),
                  color: Color.fromARGB(255, 30, 30, 30),
                ),
                width: MediaQuery.sizeOf(context).width * 0.95,
                child: ListTile(
                  title: Text(
                    "Export Chat",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ),
              Divider(
                  height: 1,
                  thickness: 0.5,
                  color: Colors.grey,
                  indent: MediaQuery.sizeOf(context).width * 0.05 / 2,
                  endIndent: MediaQuery.sizeOf(context).width * 0.05 / 2),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      topLeft: Radius.zero,
                      topRight: Radius.zero),
                  color: Color.fromARGB(255, 30, 30, 30),
                ),
                width: MediaQuery.sizeOf(context).width * 0.95,
                child: ListTile(
                  title: Text(
                    "Clear chat",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
          Gap(12),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero),
                  color: Color.fromARGB(255, 30, 30, 30),
                ),
                width: MediaQuery.sizeOf(context).width * 0.95,
                child: ListTile(
                  title: Text(
                    widget.name,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
              Divider(
                  height: 1,
                  thickness: 0.5,
                  color: Colors.grey,
                  indent: MediaQuery.sizeOf(context).width * 0.05 / 2,
                  endIndent: MediaQuery.sizeOf(context).width * 0.05 / 2),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      topLeft: Radius.zero,
                      topRight: Radius.zero),
                  color: Color.fromARGB(255, 30, 30, 30),
                ),
                width: MediaQuery.sizeOf(context).width * 0.95,
                child: ListTile(
                  title: Text(
                    widget.name,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
          Gap(12),
        ],
      )),
    );
    //);
  }
}
