import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/dashboard.dart';
import '../screens/home.dart';
import '../screens/mypets.dart';


const String homeRoute = '/home';
const String dashboardRoute = '/dashboard';
const String myPetsRoute = '/mypets';

// Create a global key for the navigator
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

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
  ],
);

  void navigateTo(BuildContext context, String route) {
  context.go(route);
}