import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notech/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBUH5QbLSdJOhnHmmT3hCJdcETGusyNmOE",
          appId: "",
          messagingSenderId: "",
          projectId: "notech-98461",
          storageBucket: "notech-98461.appspot.com"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}
