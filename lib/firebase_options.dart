// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDn3yp6bxXYDEi7sbd8RTk84ZKGR32wzzc',
    appId: '1:103919774348:web:d45709bdba66f894b069a9',
    messagingSenderId: '103919774348',
    projectId: 'bli-project-2024',
    authDomain: 'bli-project-2024.firebaseapp.com',
    storageBucket: 'bli-project-2024.appspot.com',
    measurementId: 'G-540EKL4T6R',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCeJKKYqcMTPCfKu8f58pCqQxGIQYyozNg',
    appId: '1:103919774348:android:6403143b7349fce8b069a9',
    messagingSenderId: '103919774348',
    projectId: 'bli-project-2024',
    storageBucket: 'bli-project-2024.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBg5k0vMJ0TJRz9DRgf7jP9lSOsLt8ibzo',
    appId: '1:103919774348:ios:a8393f5e46e4f777b069a9',
    messagingSenderId: '103919774348',
    projectId: 'bli-project-2024',
    storageBucket: 'bli-project-2024.appspot.com',
    iosBundleId: 'com.example.petPal',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBg5k0vMJ0TJRz9DRgf7jP9lSOsLt8ibzo',
    appId: '1:103919774348:ios:a8393f5e46e4f777b069a9',
    messagingSenderId: '103919774348',
    projectId: 'bli-project-2024',
    storageBucket: 'bli-project-2024.appspot.com',
    iosBundleId: 'com.example.petPal',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDn3yp6bxXYDEi7sbd8RTk84ZKGR32wzzc',
    appId: '1:103919774348:web:e299fd34afcea849b069a9',
    messagingSenderId: '103919774348',
    projectId: 'bli-project-2024',
    authDomain: 'bli-project-2024.firebaseapp.com',
    storageBucket: 'bli-project-2024.appspot.com',
    measurementId: 'G-D9X7LCTHNG',
  );
}