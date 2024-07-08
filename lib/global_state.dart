import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class GlobalState {
  static final GlobalState _instance = GlobalState._internal();

  factory GlobalState() {
    return _instance;
  }

  GlobalState._internal() {
    // Hardcode the values here
    latLng = [
      LatLng(23.823073120078238, 90.36529894140328),
      LatLng(23.83000353698707, 90.37288107974112),
      LatLng(23.82193602731398, 90.37337460621342),
      LatLng(23.758921680108497, 90.37216931901256)
    ]; 
    currentLocation = LatLng(23.83839616689758, 90.36708542688567);
  }

  // Define your global variables here
  List<LatLng>? latLng;
  LatLng? currentLocation;
  List<LatLng> nearbyLocation = [];

  // Method to set the current location dynamically
  // Future<void> setCurrentLocation() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   // Test if location services are enabled.
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled, do not continue
  //     return Future.error('Location services are disabled.');
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // Permissions are denied, do not continue
  //       return Future.error('Location permissions are denied.');
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }

  //   // When we reach here, permissions are granted and we can continue accessing the position
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   currentLocation = LatLng(position.latitude, position.longitude);
  // }

  // Method to calculate nearby locations within a given radius
  Future<void> getNearbyLocations(double radius) async {
    // Ensure current location is set
    // print(currentLocation);
    // if (currentLocation == null) {
    //   await setCurrentLocation();
    // }
    print(currentLocation);
    for (LatLng otherUser in latLng!) {
      double distance = Geolocator.distanceBetween(
        currentLocation!.latitude,
        currentLocation!.longitude,
        otherUser.latitude,
        otherUser.longitude,
      );

      // Check if distance is within the radius
      if (distance <= radius) {
        nearbyLocation.add(otherUser);
      }
    }print('----------------------------------------------------------');
    print(nearbyLocation);
  }

  // Method to clear all data
  void clearData() {
    latLng?.clear();
    currentLocation = null;
    nearbyLocation.clear();
  }
}

// Accessor for the global state instance
final globalState = GlobalState();
