// Suggested code may be subject to a license. Learn more: ~LicenseLog:2912834105.

import 'package:firebase_core/firebase_core.dart';
        import 'package:flutter/foundation.dart' show kIsWeb;

        class DefaultFirebaseOptions {
          static FirebaseOptions get currentPlatform {
            if (kIsWeb) {
              return web;
            }
            return android; // or ios if needed
          }

          static const FirebaseOptions web = FirebaseOptions(
                    apiKey: "AIzaSyBSljFrW8LRfGKGlNMslADFS5eil20_ZS4",
                    authDomain: "testdbnosql.firebaseapp.com",
                    projectId: "testdbnosql",
                    storageBucket: "testdbnosql.firebasestorage.app",
                    messagingSenderId: "310680659215",
                    appId: "1:310680659215:web:383c8eb99ab0fcd0fb8a7a",
                    measurementId: "G-JWLX6YG6DC",
                    databaseURL: "https://testdbnosql-default-rtdb.firebaseio.com"
          );

        static const FirebaseOptions android = FirebaseOptions(
          apiKey: 'AIzaSyC73NhSVTl8hMuL8SKAtX47H6hrmCtgbpM',
          appId: '1:310680659215:android:2d2241d077bcec09fb8a7a',
          messagingSenderId: '310680659215',
          projectId: 'testdbnosql',
          storageBucket: 'testdbnosql.firebasestorage.app',
          databaseURL: "https://testdbnosql-default-rtdb.firebaseio.com"
        );
        }
