import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetyapp/child/bottom_page.dart';
import 'package:safetyapp/db/share_pref.dart';
import 'package:safetyapp/parent/parent_home_screen.dart';
import 'package:safetyapp/utils/constants.dart';
import 'package:safetyapp/utils/quotes.dart';
import 'child/child_login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyAuhmgbCHKZAySr_AlZnONg784py3eo3IU',
      appId: '1:60911552625:android:71e4b38a95c910704373d0',
      messagingSenderId: '60911552625',
      projectId: 'raksha88-4d05b',
    ),
  );
  await MySharedPrefference.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Women Safety Application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.firaSansTextTheme(
          Theme.of(context).textTheme,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AnimatedSplashScreen(
        duration: 2000, // Adjust the duration as needed
        splash: Image.asset('assets/splash.jpg'),
        nextScreen: FutureBuilder(
          future: MySharedPrefference.getUserType(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.data == "") {
              return LoginScreen();
            }
            if (snapshot.data == "child") {
              return BottomPage();
            }
            if (snapshot.data == "parent") {
              return ParentHomeScreen();
            }
            return progressIndicator(context);
          },
        ),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.white, // Change the background color as needed
        splashIconSize: 250.0, // Adjust the size of the splash image
      ),
    );
  }
}
