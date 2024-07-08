import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/dashboard.dart';
import '../screens/home.dart';
import '../screens/mypets.dart';
import '../screens/posts.dart';
import '../screens/vetClinic/vet_clinic.dart';
import '../screens/vetClinic/vets_near.dart';
import '../screens/vetClinic/all_vets.dart';
import '../../global_state.dart';
import 'package:permission_handler/permission_handler.dart';

const String homeRoute = '/home';
const String dashboardRoute = '/dashboard';
const String myPetsRoute = '/mypets';
const String postsRoute = '/posts';
const String virtualVet = '/vet';
const String vetsNearRoute = '/vets_near';
const String allvetroute = '/allvet';

// Create a global key for the navigator
final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

// Define the GoRouter
final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: homeRoute,
  debugLogDiagnostics: true,
  routes: <RouteBase>[
    GoRoute(
      path: homeRoute,
      builder: (BuildContext context, GoRouterState state) {
        return Home();
      },
    ),
    GoRoute(
      path: dashboardRoute,
      builder: (BuildContext context, GoRouterState state) {
        return Dashboard();
      },
    ),
    GoRoute(
      path: myPetsRoute,
      builder: (BuildContext context, GoRouterState state) {
        return MyPets();
      },
    ),
    GoRoute(
      path: postsRoute,
      builder: (BuildContext context, GoRouterState state) {
        return PostsPage();
      },
    ),
    GoRoute(
      path: virtualVet,
      builder: (BuildContext context, GoRouterState state) {
        return VetClinic();
      },
    ),
    GoRoute(
      path: vetsNearRoute,
      builder: (BuildContext context, GoRouterState state) {
        return FutureBuilder<void>(
          future: initializeLocationData(),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                appBar: AppBar(
                  title: Text('Loading...'),
                ),
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasError) {
              return Scaffold(
                appBar: AppBar(
                  title: Text('Error'),
                ),
                body: Center(
                  child: Text('Error: ${snapshot.error}'),
                ),
              );
            } else {
              return VetsNear(
                latLng: globalState.nearbyLocation,
                currentLocation: globalState.currentLocation,
              );
            }
          },
        );
      },
    ),
    GoRoute(
      path: allvetroute,
      builder: (BuildContext context, GoRouterState state) {
        return FutureBuilder<void>(
          future: globalState.getNearbyLocations(2000),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                appBar: AppBar(
                  title: Text('Loading...'),
                ),
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasError) {
              return Scaffold(
                appBar: AppBar(
                  title: Text('Error'),
                ),
                body: Center(
                  child: Text('Error: ${snapshot.error}'),
                ),
              );
            } else {
              return AllVets(
                latLng: globalState.latLng,
                currentLocation: globalState.currentLocation,
              );
            }
          },
        );
      },
    ),
  ],
);

Future<void> initializeLocationData() async {
  await requestLocationPermission();
  //await globalState.setCurrentLocation();
  await globalState.getNearbyLocations(2000);
}

Future<void> requestLocationPermission() async {
  var status = await Permission.location.status;
  if (!status.isGranted) {
    await Permission.location.request();
  }
}

void navigateTo(BuildContext context, String route) {
  context.go(route);
}
