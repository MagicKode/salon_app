import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/gallery/gallery_screen.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/gallery/sections/gallery_grid_preview.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/gallery/sections/add_photo_sheet.dart';
import 'package:salon_flutter/feature/catalog/data/repositories/catalog_repository_impl.dart';
import 'package:salon_flutter/feature/catalog/domain/repositories/catalog_repository.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../app/main/main.dart';

class GallerySection extends StatefulWidget {
  final bool isMaster;

  const GallerySection({super.key, required this.isMaster});

  @override
  State<GallerySection> createState() => _GallerySectionState();
}

class _GallerySectionState extends State<GallerySection> {
  int _refreshCounter = 0;

  void _refreshGallery() {
    final repo = context.read<CatalogRepository>();
    if (repo is CatalogRepositoryImpl) {
      repo.clearGalleryCache();
    }
    setState(() {
      _refreshCounter++;
    });
  }

  void _showUploadDialog(BuildContext context) async {
    const String uploadUrl = catalogImagesUploadUrl;
    final result = await AddPhotoSheet.show(context, uploadUrl);
    if (result == true) {
      _refreshGallery();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            AppStrings.portfolio,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),

        GalleryGridPreview(key: ValueKey(_refreshCounter)),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.isMaster)
                TextButton(
                  onPressed: () => _showUploadDialog(context),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    backgroundColor: Colors.grey.shade200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    foregroundColor: AppColors.primaryBlue,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.add_photo_alternate, size: 18),
                      const SizedBox(width: 4),
                      const Text(
                        'Добавить фото',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              const SizedBox(width: 12),

              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GalleryScreen(
                        isMaster: widget.isMaster,
                        onRefresh: _refreshGallery,
                      ),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue.withOpacity(0.15),
                  side: BorderSide(color: AppColors.primaryBlue.withOpacity(0.2)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  foregroundColor: AppColors.primaryBlue,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                child: const Text(AppStrings.seeAllGallery),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
