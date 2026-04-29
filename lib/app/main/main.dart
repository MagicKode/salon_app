import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../feature/core/bookingservicescreen/booking_service_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('ru', null);

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
      // home: HomePageScreen(),
      // home: ServiceDetailScreen(),
      home: BookingServiceScreen(),
      // home: MyBookingsScreen(),
    );
  }
}
