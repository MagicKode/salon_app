import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:salon_flutter/feature/auth/splashscreen/splash_screen.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

void main() async {
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
      title: 'Salon App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryBlue),
        scaffoldBackgroundColor: AppColors.primaryWhite,
        useMaterial3: true,
        fontFamily: 'Montserrat',
      ),
      home: const SplashScreen(),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // home: const SplashScreen(),
      // home: LoginScreen(),
      // home: CreateAccountScreen(),
      // home: ForgotPasswordScreen(),
      // home: EmailVerificationScreen(),
      // home: CreateNewPassScreen(),
      // home: HomePageScreen(),
      // home: ServiceDetailScreen(),
      // home: BookingServiceScreen(),
      // home: MyBookingCheckoutScreen(),
    );
  }
}
