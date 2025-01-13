import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
          'DefaultFirebaseOptions are not configured for iOS.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not configured for macOS.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not configured for Windows.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not configured for Linux.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBSljFrW8LRfGKGlNMslADFS5eil20_ZS4',
    appId: '1:310680659215:web:94443d0f0ab12507fb8a7a',
    messagingSenderId: '310680659215',
    projectId: 'testdbnosql',
    authDomain: 'testdbnosql.firebaseapp.com',
    storageBucket: 'testdbnosql.appspot.com', // Remplacez par le bon domaine
    measurementId: 'G-95DGG2GLYW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC73NhSVTl8hMuL8SKAtX47H6hrmCtgbpM',
    appId: '1:310680659215:android:6e8fd4405a34494bfb8a7a',
    messagingSenderId: '310680659215',
    projectId: 'testdbnosql',
    storageBucket: 'testdbnosql.appspot.com', // Remplacez par le bon domaine
  );
}
