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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyB3m60ln5QKInpdiPJJz3nZwU12gi5JdGo',
    appId: '1:162219019066:web:2ad2e2c5eac89e303e9e03',
    messagingSenderId: '162219019066',
    projectId: 'final-project-2e3b6',
    authDomain: 'final-project-2e3b6.firebaseapp.com',
    storageBucket: 'final-project-2e3b6.appspot.com',
    measurementId: 'G-64CDR8CP1E',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDPR1wAuk59tyHzCzFcUeb3FTt3RI1faUg',
    appId: '1:162219019066:android:be44e9c7d48c8b793e9e03',
    messagingSenderId: '162219019066',
    projectId: 'final-project-2e3b6',
    storageBucket: 'final-project-2e3b6.appspot.com',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB3m60ln5QKInpdiPJJz3nZwU12gi5JdGo',
    appId: '1:162219019066:web:e786c89c876c6fb13e9e03',
    messagingSenderId: '162219019066',
    projectId: 'final-project-2e3b6',
    authDomain: 'final-project-2e3b6.firebaseapp.com',
    storageBucket: 'final-project-2e3b6.appspot.com',
    measurementId: 'G-BN90N65YCV',
  );

}