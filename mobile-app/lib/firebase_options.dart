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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCy6AhB_BqkTn3-Mxn-KXx2ev17J8wZ5s8',
    appId: '1:363152234407:web:7cf2cc193ff76efd738882',
    messagingSenderId: '363152234407',
    projectId: 'mobile-4ee8a',
    authDomain: 'mobile-4ee8a.firebaseapp.com',
    storageBucket: 'mobile-4ee8a.appspot.com',
    measurementId: 'G-NV2NFWJDNN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCP3yAWau0JJE8BPgsUrbT2K27EJX3z2KE',
    appId: '1:363152234407:android:6293f9873ae6df8a738882',
    messagingSenderId: '363152234407',
    projectId: 'mobile-4ee8a',
    storageBucket: 'mobile-4ee8a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCFcTnIuxW7AeskmoNwbrEZX_ZvYz-aAdw',
    appId: '1:363152234407:ios:3894fa398c8bd70f738882',
    messagingSenderId: '363152234407',
    projectId: 'mobile-4ee8a',
    storageBucket: 'mobile-4ee8a.appspot.com',
    iosClientId: '363152234407-s26svd21nuqr63ksq30ue7qh4tvk2a2v.apps.googleusercontent.com',
    iosBundleId: 'org.freecodecamp',
  );
}
