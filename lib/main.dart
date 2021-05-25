import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'pages/login.page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:photo_gallery/pages/home.page.dart';
import 'package:photo_gallery/pages/WaitingScreen.page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return WaitingScreen();
          }
          if (userSnapshot.hasData) {
            return HomePage(result: null);
          }
          return LoginPage();
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
