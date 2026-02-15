import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/homepagescreen/home_page_screen.dart';
import 'package:salon_flutter/feature/homepagescreen/sections/appbarsection/app_bar_section.dart';
import 'package:salon_flutter/feature/homepagescreen/sections/bpttomnavbarsection/bottom_nav_bar_section.dart';

import '../homepagescreen//sections/background.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // Navigation state
  int _selectedIndex = 0;

  // Переменные для управления состоянием
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier<bool>(false);
  bool _isLoading = false;
  bool _isGoogleLoading = false;

  //переменные для отслеживания фокуса полей
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  // Constants
  static const double _verticalPadding = 24.0;
  static const double _extraLargeSpacing = 118.0;
  static const double _smallSpacing = 12.0;
  static const double _largeSpacing = 108.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: BottomNavBarSection(
        initialIndex: _selectedIndex,
        onTabSelected: _handleTabSelected,
      ),
      body: _buildBody(),
    );
  }

  void _handleTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      color: Colors.white,
      child: Background(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: _verticalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBarSection(),
              // Add other sections here when needed


              // SizedBox(height: 118.0), // Отступ между текстами

              //
              // SizedBox(height: 12.0),
              //
              //
              // SizedBox(height: 108.0),
              //
            ],
          ),
        ),
      ),
    );
  }
}
