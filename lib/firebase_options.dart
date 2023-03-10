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
    apiKey: 'AIzaSyAJPGOaedvFtNmr1o8h7_FzlHctE1NT_fE',
    appId: '1:316930969858:web:0cdc8d1d7e66e31243b21b',
    messagingSenderId: '316930969858',
    projectId: 'projet-flutter-2ec0d',
    authDomain: 'projet-flutter-2ec0d.firebaseapp.com',
    storageBucket: 'projet-flutter-2ec0d.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAzFpjdzS03cQNtytMSv-FgSJyQbBLkjFk',
    appId: '1:316930969858:android:a5e23430db06cd9c43b21b',
    messagingSenderId: '316930969858',
    projectId: 'projet-flutter-2ec0d',
    storageBucket: 'projet-flutter-2ec0d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAjnaQ0YmrRroSLRBDV9Y979GqTksztn20',
    appId: '1:316930969858:ios:90b7f2fbd24fdfd143b21b',
    messagingSenderId: '316930969858',
    projectId: 'projet-flutter-2ec0d',
    storageBucket: 'projet-flutter-2ec0d.appspot.com',
    iosClientId: '316930969858-2sibidi0cvjam29rkppvp249jg7gpcrb.apps.googleusercontent.com',
    iosBundleId: 'com.example.projet1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAjnaQ0YmrRroSLRBDV9Y979GqTksztn20',
    appId: '1:316930969858:ios:90b7f2fbd24fdfd143b21b',
    messagingSenderId: '316930969858',
    projectId: 'projet-flutter-2ec0d',
    storageBucket: 'projet-flutter-2ec0d.appspot.com',
    iosClientId: '316930969858-2sibidi0cvjam29rkppvp249jg7gpcrb.apps.googleusercontent.com',
    iosBundleId: 'com.example.projet1',
  );
}
