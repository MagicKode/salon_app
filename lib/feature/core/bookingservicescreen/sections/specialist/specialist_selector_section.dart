import 'package:flutter/material.dart';
import '../../../../../uikit/assets/app_assets.dart';
import '../../../../../uikit/colors/app_colors.dart';
import '../../../../../uikit/strings/app_strings.dart';

class SpecialistSelectorSection extends StatelessWidget {
  final Function(String masterName, String title)? onMasterSelected;

  const SpecialistSelectorSection({
    super.key,
    this.onMasterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.yourMasterPavel,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),

        // Делаем контейнер кликабельным
        GestureDetector(
          onTap: () {
            onMasterSelected?.call("Pavel", AppStrings.topMaster);
            // В будущем здесь можно открыть BottomSheet с выбором мастера
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.lightBorder),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(AppAssets.pavelImg),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Pavel",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppStrings.topMaster,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(
                  Icons.chevron_right,
                  color: AppColors.primaryGrey,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
