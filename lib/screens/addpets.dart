import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../storage/firebase_storage.dart';
import '../storage/firestore_url.dart';

class AddPetPage extends StatefulWidget {
  @override
  _AddPetPageState createState() => _AddPetPageState();
}

class _AddPetPageState extends State<AddPetPage> {
  final FirebaseStorageService _storageService = FirebaseStorageService();
  final FirestoreService _firestoreService = FirestoreService();
  String? _imageUrl;
  User? _user;
  String? _userName;
  final TextEditingController _nameController = TextEditingController();
  File _image = File('assets/images/14558.png');
  
  String? _location;
  List<Map<String, dynamic>> _locations = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    //_getCurrentUser();
    _getCurrentLocationAndFetchNearbyLocations();
  }

  Future<void> _getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _user = user;
      });
      await _getUserDetails(user.uid);
      //await _fetchPosts();
    }
  }

  Future<void> _getUserDetails(String uid) async {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('UserData').doc(uid).get();
    if (userDoc.exists) {
      setState(() {
        _userName = userDoc['username'];
      });
    }
  }

  Future<void> _getCurrentLocationAndFetchNearbyLocations() async {
    setState(() {
      _loading = true;
      _getCurrentUser();
    });

    try {
      Position currentPosition = await _getCurrentLocation();
      List<Map<String, dynamic>> locations =
          await _fetchNearbyLocations(currentPosition);
      setState(() {
        _locations = locations;
      });
      print(_locations);
    } catch (e) {
      print(e);
    }

    setState(() {
      _loading = false;
    });
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<List<Map<String, dynamic>>> _fetchNearbyLocations(
      Position currentPosition) async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('pets').where('owner', isEqualTo: "").get();

    List<Map<String, dynamic>> nearbyLocations = [];

    for (var doc in snapshot.docs) {
      GeoPoint geoPoint = GeoPoint(doc['latitude'], doc['longitude']);
      double distanceInMeters = Geolocator.distanceBetween(
        currentPosition.latitude,
        currentPosition.longitude,
        geoPoint.latitude,
        geoPoint.longitude,
      );

      if (distanceInMeters <= 1000) {
        // Adjust this value as needed
        nearbyLocations.add({
          'name': doc['name'],
          'location': geoPoint,
          'distance': distanceInMeters,
        });
      }
    }

    return nearbyLocations;
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _addPet() async {
    if (_nameController.text.isEmpty || _image == null || _location == null) {
      // Show an error message or handle the case when any field is empty
      return;
    }
    String temp = "sth";
    setState(() {
      temp = _nameController.text;
      //_imageFile = _image;
      _nameController.clear();
     // _image = File(AutofillHints.addressCity);
    });
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final downloadUrl = await _storageService.uploadImage(_image, fileName);

    if (downloadUrl == null) return;

    setState(() {
      _imageUrl = downloadUrl;
    });

    // Save image URL to Firestore
    await _firestoreService.saveImageUrl(downloadUrl, fileName);

    //final timestamp = DateTime.now();
    await _firestoreService.addPet(temp, _imageUrl, _userName);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Pet')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _loading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Pet Name'),
                  ),
                  Gap(16),
                  // _image != null ?
                  //   Image.file(_image,
                  //       height: 200, width: double.infinity, fit: BoxFit.cover) : CircularProgressIndicator(),

                  ElevatedButton(
                    onPressed: _pickImage,
                    child: Text('Pick Image'),
                  ),
                  Gap(16),
                  _locations.isEmpty == true ? Text("No nearby devices") :
                  DropdownButtonFormField<String>(
                    value: _location,
                    items: _locations.map((location) {
                      return DropdownMenuItem<String>(
                        value: location['name'],
                        child: Text(
                            '${location['name']} (${location['distance'].toStringAsFixed(1)} meters)'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _location = value;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Location/Device'),
                  ),
                  Gap(16),
                  ElevatedButton(
                    onPressed: _addPet,
                    child: Text('Done'),
                  ),
                ],
              ),
      ),
    );
  }
}
