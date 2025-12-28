import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/createaccountscreen/create_acc_screen.dart';
import 'package:salon_flutter/feature/onboardingscreen/onboarding_screen.dart';
import 'package:salon_flutter/feature/splashscreen/splash_screen.dart';
import '../../feature/loginscreen/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moving Splash Screen',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Colors.white,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // home: SplashScreen(),
      // home: OnboardingScreen(),
      // home: LoginScreen(),
      home: CreateAccountScreen(),
    );
  }
}
