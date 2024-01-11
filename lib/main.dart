import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'map_screen.dart'; // Harita sayfasının olduğu dosya

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Harita Uygulaması',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MapScreen(), // Harita sayfasını ana sayfa olarak belirtiyoruz
    );
  }
}
