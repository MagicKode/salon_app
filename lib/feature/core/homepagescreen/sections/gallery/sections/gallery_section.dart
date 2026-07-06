import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/gallery/gallery_screen.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/gallery/sections/gallery_grid_preview.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/gallery/sections/add_photo_sheet.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

class GallerySection extends StatefulWidget {
  final bool isMaster;

  const GallerySection({super.key, required this.isMaster});

  @override
  State<GallerySection> createState() => _GallerySectionState();
}

class _GallerySectionState extends State<GallerySection> {
  void _refreshGallery() {
    setState(() {});
  }

  void _showUploadDialog(BuildContext context) async {
    const String uploadUrl = 'http://10.0.2.2:8081/api/v1/catalog/images/upload';
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
        const GalleryGridPreview(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ✅ Только для мастера – кликабельная надпись вместо кнопки
              if (widget.isMaster)
                TextButton(
                  onPressed: () => _showUploadDialog(context),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    foregroundColor: AppColors.primaryBlue,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.add_photo_alternate, size: 18),
                      const SizedBox(width: 4),
                      const Text(
                        'Добавить фото',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(width: 12),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GalleryScreen()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primaryBlue),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
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
