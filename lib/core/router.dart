import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_pal/screens/addpets.dart';
import 'package:pet_pal/screens/login_reg/reset_password.dart';
import 'package:pet_pal/screens/login_reg/signin_screen.dart';
import 'package:pet_pal/screens/login_reg/signup_screen.dart';
import 'package:pet_pal/screens/profile.dart';
import '../screens/dashboard.dart';
import '../screens/home.dart';
import '../screens/mypets.dart';
import '../screens/posts.dart';
import '../screens/store.dart';
//import '../screens/cart.dart';
import '../screens/vetClinic/vet_clinic.dart';
import '../screens/vetClinic/vets_near.dart';
import '../screens/vetClinic/all_vets.dart';
import '../screens/vetClinic/bkash_sub.dart';
import '../screens/vetClinic/chat/WhatsappChat.dart';
import '../screens/vetClinic/chat/ProfilePageWhatsapp.dart';
import '../../global_state.dart';
import 'package:permission_handler/permission_handler.dart';

const String signin = '/signin';
const String signup = '/signup';
const String reset = '/reset';
const String homeRoute = '/home';
const String dashboardRoute = '/dashboard';
const String myPetsRoute = '/mypets';
const String addPetsRoute = '/addpets';
const String postsRoute = '/posts';
const String virtualVet = '/vet';
const String vetsNearRoute = '/vets_near';
const String allvetroute = '/allvet';
const String storeRoute = '/store';
const String cartRoute = '/cart';
const String profileRoute = '/profile';
const String chatview = '/chat';
const String profileChat= '/profileChat';
const String bkash_pay='/bkashsub';
// Create a global key for the navigator
final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

// Define the GoRouter
final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: signin,
  debugLogDiagnostics: true,
  routes: <RouteBase>[
    GoRoute(
      path: signin,
      builder: (BuildContext context, GoRouterState state) {
        return SignInScreen();
      },
    ),
    GoRoute(
      path: signup,
      builder: (BuildContext context, GoRouterState state) {
        return SignUpScreen();
      },
    ),
    GoRoute(
      path: reset,
      builder: (BuildContext context, GoRouterState state) {
        return ResetPassword();
      },
    ),

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
      path: addPetsRoute,
      builder: (BuildContext context, GoRouterState state) {
        return AddPetPage();
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
      path: storeRoute,
      builder: (BuildContext context, GoRouterState state) {
        return StorePage();
      },
    ),
    GoRoute(
      path: profileRoute,
      builder: (BuildContext context, GoRouterState state) {
        return ProfilePage();
      },
    ),
    // GoRoute(
    //   path: cartRoute,
    //   builder: (BuildContext context, GoRouterState state) {
    //     return CartPage();
    //   },
    // ),
    GoRoute(
      path: vetsNearRoute,
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
    GoRoute(
      path: chatview,
      builder: (BuildContext context, GoRouterState state) {
        final args = state.extra as Map<String, dynamic>;
        return WhatsappChat(path: args['path'], name: args['name']);
      },
    ),
    GoRoute(
      path: profileChat,
      builder: (BuildContext context, GoRouterState state) {
        final args = state.extra as Map<String, dynamic>;
        
         return Theme(
      data: ThemeData.dark(useMaterial3: false),
      child: ProfilePageWhatsapp(path: args['path'], name: args['name']),
    );
      },
    ),
    GoRoute(
      path: bkash_pay,
      builder: (BuildContext context, GoRouterState state) {
        return bkashSub(title:"Bkash Payment");
      },
    ),
  ],
);

Future<void> initializeLocationData() async {
  await requestLocationPermission();
  await globalState.setCurrentLocation();
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
