import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/theme/custom_colors.dart';
import '../../../../../uikit/strings/app_strings.dart';
import '../../../../../uikit/widgets/card/images/networkimagewithplaceholder.dart';
import '../../../../catalog/data/models/catalog_image.dart';
import '../../../../catalog/domain/repositories/catalog_repository.dart';

class SpecialistSelectorSection extends StatelessWidget {
  final Function(String masterName, String title)? onMasterSelected;

  const SpecialistSelectorSection({super.key, this.onMasterSelected});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

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
            Text(
              AppStrings.yourMasterPavel,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),

            // Делаем контейнер кликабельным
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colors.surfaceCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.borderLight),
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
                          errorWidget: Icon(
                            Icons.person,
                            size: 30,
                            color: colors.textSecondary,
                          ),
                        ),
                      ),
                    )
                  else
                    CircleAvatar(
                      radius: 30,
                      child: Icon(
                        Icons.person,
                        size: 30,
                        color: colors.surfaceInput,
                      ),
                    ),
                  const SizedBox(width: 16),
                  // ... имя и должность
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.masterName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: colors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          AppStrings.topMaster,
                          style: TextStyle(
                            fontSize: 14,
                            color: colors.textSecondary,
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
