import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/widgets/card/images/networkimagewithplaceholder.dart';
import '../../../../uikit/colors/app_colors.dart';

class SpecialistAvatar extends StatelessWidget {
  final String imageUrl;
  final double size;

  const SpecialistAvatar({
    super.key,
    required this.imageUrl,
    this.size = 70,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: NetworkImageWithPlaceholder(
        url: imageUrl,
        fit: BoxFit.cover,
        width: size,
        height: size,
        errorWidget: const Icon(Icons.person, size: 28, color: Colors.grey),
      ),
    );
  }
}
