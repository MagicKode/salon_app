import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/profilescreen/profile_body.dart';

class ProfileScreen extends StatelessWidget{
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfileBody(),
    );
  }
}
