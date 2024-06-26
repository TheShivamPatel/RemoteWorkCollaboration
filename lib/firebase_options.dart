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
    apiKey: 'AIzaSyDOcCMjvPwP-4XJHG7fq4GKGZ1kx0qQcZI',
    appId: '1:694750951888:web:e78309b956c73a0b7621d5',
    messagingSenderId: '694750951888',
    projectId: 'flutter-chat-app-b92fa',
    authDomain: 'flutter-chat-app-b92fa.firebaseapp.com',
    storageBucket: 'flutter-chat-app-b92fa.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB2SiKssNWZkK27INkGSLiR1iuH24bc0Is',
    appId: '1:694750951888:android:1e01c122e171fd397621d5',
    messagingSenderId: '694750951888',
    projectId: 'flutter-chat-app-b92fa',
    storageBucket: 'flutter-chat-app-b92fa.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBfkaMzFYrRwbD6lcoijz0o9EzFrHOT0H8',
    appId: '1:694750951888:ios:71e2a7e89965a4937621d5',
    messagingSenderId: '694750951888',
    projectId: 'flutter-chat-app-b92fa',
    storageBucket: 'flutter-chat-app-b92fa.appspot.com',
    iosBundleId: 'com.example.chatterbox',
  );
}
