import 'package:flutter/cupertino.dart';

class ServiceImageHeaderSection extends StatelessWidget {
  final String imageUrl;
  const ServiceImageHeaderSection({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.45,
      width: double.infinity,
      child: Image.network(imageUrl, fit: BoxFit.cover),
    );
  }
}