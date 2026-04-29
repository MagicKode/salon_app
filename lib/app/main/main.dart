import 'package:flutter/material.dart';

import '../../feature/core/homepagescreen/home_page_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moving Splash Screen',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // home: const SplashScreen(),
      // home: LoginScreen(),
      // home: CreateAccountScreen(),
      // home: ForgotPasswordScreen(),
      // home: EmailVerificationScreen(),
      // home: CreateNewPassScreen(),
      home: HomePageScreen(),
      // home: ServiceDetailScreen(),
      // home: BookingServiceScreen(),
      // home: MyBookingsScreen(),
    );
  }
}
