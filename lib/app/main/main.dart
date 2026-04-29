import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/booking_service_screen.dart';
import 'package:salon_flutter/feature/profile/my_booking_screen.dart';

import '../../feature/auth/createaccountscreen/create_acc_screen.dart';
import '../../feature/auth/emailverificationscreen/email_verification_screen.dart';
import '../../feature/auth/forgotpasswordscreen/forgot_password_screen.dart';
import '../../feature/auth/loginscreen/login_screen.dart';
import '../../feature/core/servicemenuscreen/service_menu_screen.dart';

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
      // home: LoginScreen(),
      // home: CreateAccountScreen(),
      home: ForgotPasswordScreen(),
      // home: EmailVerificationScreen(),
      // home: CreateNewPassScreen(),
      // home: HomePageScreen(),
      // home: ServiceDetailScreen(),
      // home: BookingServiceScreen(),
      // home: MyBookingsScreen(),
    );
  }
}
