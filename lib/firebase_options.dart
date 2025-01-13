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
                    measurementId: "G-JWLX6YG6DC"
          );


        static const FirebaseOptions android = FirebaseOptions(
          apiKey: 'AIzaSyC73NhSVTl8hMuL8SKAtX47H6hrmCtgbpM', // Replace with your API Key
          appId: '1:310680659215:android:2d2241d077bcec09fb8a7a', // Replace with your App ID
          messagingSenderId: '310680659215',  // Replace with your Messaging Sender ID
          projectId: 'testdbnosql',   // Replace with your Project ID
          storageBucket: 'testdbnosql.firebasestorage.app',  // Replace with your storage bucket
        );
        }
