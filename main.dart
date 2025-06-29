import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/splash.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDO9eE3dCwGgFYOAl238HvWKbvVNbsyZJI",
      authDomain: "newsapp-94431.firebaseapp.com",
      projectId: "newsapp-94431",
      storageBucket: "newsapp-94431.firebasestorage.app",
      messagingSenderId: "255576090976",
      appId: "1:255576090976:web:be6b1f7118e1b2c139d605",
      measurementId: "G-0TT2EXCV25"
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}


