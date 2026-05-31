import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../../../uikit/widgets/button/app_button.dart';
import '../../../../catalog/bloc/catalog_bloc.dart';
import '../../../../catalog/bloc/catalog_state.dart';

class HomeBookingButtonSection extends StatelessWidget {
  final VoidCallback onPressed;

  const HomeBookingButtonSection({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    // Кнопка слушает состояние каталога: показывается только при успехе
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: AppButton(text: AppStrings.bookNow, onPressed: onPressed),
      ),
    );
  }
}
