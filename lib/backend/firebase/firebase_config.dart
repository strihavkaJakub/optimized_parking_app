import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBdhWPW8NuCZX8tY8w63iV8CP2tNz__Olg",
            authDomain: "optimizedparkingapp.firebaseapp.com",
            projectId: "optimizedparkingapp",
            storageBucket: "optimizedparkingapp.appspot.com",
            messagingSenderId: "161807354731",
            appId: "1:161807354731:web:04c1510709db06cffa1a2e",
            measurementId: "G-RQX5V21JDF"));
  } else {
    await Firebase.initializeApp();
  }
}
