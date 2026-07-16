import 'package:flutter/material.dart';
import '../theme/custom_colors.dart';

extension ThemeExt on BuildContext {
  CustomColors get colors => Theme.of(this).extension<CustomColors>()!;
}
