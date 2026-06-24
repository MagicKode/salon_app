import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../../../uikit/colors/app_colors.dart';
import '../../../../../uikit/widgets/button/app_button.dart';
import '../../../../catalog/bloc/catalog_bloc.dart';
import '../../../../catalog/bloc/catalog_state.dart';

class HomeBookingButtonSection extends StatelessWidget {
  final VoidCallback onPressed;
  final bool expanded;

  const HomeBookingButtonSection({
    super.key,
    required this.onPressed,
    this.expanded = false,
  });

  @override
  Widget build(BuildContext context) {
    // ✅ Используем LayoutBuilder для точной ширины экрана
    return LayoutBuilder(
      builder: (context, constraints) {
        final fullWidth = constraints.maxWidth;
        final collapsedWidth = 200.0;

        return AnimatedAlign(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: expanded ? Alignment.center : const Alignment(1.15, 0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: expanded ? fullWidth : collapsedWidth,  // ✅ Конкретные значения
            height: 52,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primaryBlue, AppColors.lightBlue],
              ),
              borderRadius: BorderRadius.circular(expanded ? 16 : 26),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryBlue.withOpacity(0.3),
                  blurRadius: expanded ? 12 : 6,
                  offset: Offset(0, expanded ? 4 : 2),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(expanded ? 16 : 26),
                onTap: onPressed,
                child: Center(
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: expanded ? 18 : 14,
                      fontWeight: FontWeight.bold,
                    ),
                    child: const Text('Оставить заявку'),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
