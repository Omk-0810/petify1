// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBqs6nUNC0h9fgChimhvcleXtRxKfHnRBI',
    appId: '1:346679821193:web:206549546d25711d12d758',
    messagingSenderId: '346679821193',
    projectId: 'petify-794fd',
    authDomain: 'petify-794fd.firebaseapp.com',
    storageBucket: 'petify-794fd.appspot.com',
    measurementId: 'G-ZF2EHX6KBM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBl6GrOJ5wItmm91jSH-BxgaBzHMx1j8WQ',
    appId: '1:346679821193:android:5d61e5fc5310484712d758',
    messagingSenderId: '346679821193',
    projectId: 'petify-794fd',
    storageBucket: 'petify-794fd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBlJxVRXkOIBs4iPlL71k-NLCHJeDtQzfw',
    appId: '1:346679821193:ios:4815ea10cd4628cb12d758',
    messagingSenderId: '346679821193',
    projectId: 'petify-794fd',
    storageBucket: 'petify-794fd.appspot.com',
    iosBundleId: 'com.example.petify',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBlJxVRXkOIBs4iPlL71k-NLCHJeDtQzfw',
    appId: '1:346679821193:ios:2f2bbd3f7f1a7bb412d758',
    messagingSenderId: '346679821193',
    projectId: 'petify-794fd',
    storageBucket: 'petify-794fd.appspot.com',
    iosBundleId: 'com.example.petify.RunnerTests',
  );
}
