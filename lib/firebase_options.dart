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
    apiKey: 'AIzaSyCK329Xro9VUbW15-Ra8yWJycxKAOJ5XbM',
    appId: '1:217190706406:web:0999b64c8a3d349f9b1f27',
    messagingSenderId: '217190706406',
    projectId: 'learning-ac087',
    authDomain: 'learning-ac087.firebaseapp.com',
    storageBucket: 'learning-ac087.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCEhD3QOZJ3D2WFxEvVh9YkhGFZmQMiB-s',
    appId: '1:217190706406:android:1fb1ca02d133e0429b1f27',
    messagingSenderId: '217190706406',
    projectId: 'learning-ac087',
    storageBucket: 'learning-ac087.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAvnVwYlTkygy6XdC1vFkFJKIyLZH2QZvo',
    appId: '1:217190706406:ios:af0f8220ba6ed6c89b1f27',
    messagingSenderId: '217190706406',
    projectId: 'learning-ac087',
    storageBucket: 'learning-ac087.appspot.com',
    iosBundleId: 'com.example.onlineLearning',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAvnVwYlTkygy6XdC1vFkFJKIyLZH2QZvo',
    appId: '1:217190706406:ios:af0f8220ba6ed6c89b1f27',
    messagingSenderId: '217190706406',
    projectId: 'learning-ac087',
    storageBucket: 'learning-ac087.appspot.com',
    iosBundleId: 'com.example.onlineLearning',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCK329Xro9VUbW15-Ra8yWJycxKAOJ5XbM',
    appId: '1:217190706406:web:f16fb503f1df19339b1f27',
    messagingSenderId: '217190706406',
    projectId: 'learning-ac087',
    authDomain: 'learning-ac087.firebaseapp.com',
    storageBucket: 'learning-ac087.appspot.com',
  );
}
