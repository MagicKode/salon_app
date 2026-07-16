import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';
import '../../../../config/theme/custom_colors.dart';
import '../../../../uikit/colors/app_colors.dart';

class SignUpSection extends StatelessWidget {
  final VoidCallback onJoinNowPressed;

  const SignUpSection({
    super.key,
    required this.onJoinNowPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppStrings.dontHaveAccount,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14.0,
            ),
          ),
          TextButton(
            onPressed: onJoinNowPressed,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              AppStrings.register,
              style: TextStyle(
                color: colors.primaryBlueLight,
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
