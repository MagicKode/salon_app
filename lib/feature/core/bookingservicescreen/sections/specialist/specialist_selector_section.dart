import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../uikit/colors/app_colors.dart';
import '../../../../../uikit/strings/app_strings.dart';
import '../../../../../uikit/widgets/card/images/networkimagewithplaceholder.dart';
import '../../../../catalog/data/models/catalog_image.dart';
import '../../../../catalog/domain/repositories/catalog_repository.dart';

class SpecialistSelectorSection extends StatelessWidget {
  final Function(String masterName, String title)? onMasterSelected;

  const SpecialistSelectorSection({super.key, this.onMasterSelected});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CatalogImage>>(
      future: context.read<CatalogRepository>().getImages('master', 0),
      builder: (context, snapshot) {
        final String? imageUrl =
            (snapshot.hasData && snapshot.data!.isNotEmpty)
                ? snapshot.data!.first.url
                : null;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.yourMasterPavel,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Делаем контейнер кликабельным
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primaryBackgroundColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.lightBorder),
              ),
              child: Row(
                children: [
                  // Фото мастера с плейсхолдером
                  if (imageUrl != null)
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: ClipOval(
                        child: NetworkImageWithPlaceholder(
                          url: imageUrl,
                          fit: BoxFit.cover,
                          errorWidget: const Icon(Icons.person, size: 30, color: AppColors.primaryGrey),
                        ),
                      ),
                    )
                  else
                    const CircleAvatar(
                      radius: 30,
                      child: Icon(Icons.person, size: 30, color: AppColors.primaryGrey),
                    ),
                  const SizedBox(width: 16),
                  // ... имя и должность
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.masterName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryBlack,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          AppStrings.topMaster,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
