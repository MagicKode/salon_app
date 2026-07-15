import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/uikit/widgets/map/positioned_info_card.dart';

import '../../catalog/data/models/catalog_image.dart';
import '../../catalog/domain/repositories/catalog_repository.dart';

class NearbyMapBody extends StatelessWidget {
  const NearbyMapBody({super.key});

  static const String _address = 'пр.Независимости 14, Минск';

  @override
  Widget build(BuildContext context) {
    final repository = context.read<CatalogRepository>();

    return FutureBuilder<List<CatalogImage>>(
      future: repository.getImages('map', 0, limit: 1),
      builder: (context, snapshot) {
        Widget mapWidget;
        if (snapshot.connectionState == ConnectionState.waiting) {
          mapWidget = _buildPlaceholder('Загрузка карты...');
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final imageUrl = snapshot.data!.first.url;
          mapWidget = CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (_, __) => _buildPlaceholder('Загрузка...'),
            errorWidget:
                (_, __, ___) => _buildPlaceholder('Не удалось загрузить карту'),
          );
        } else {
          mapWidget = _buildPlaceholder('Мы находимся здесь');
        }

        return Stack(
          children: [
            Positioned.fill(child: mapWidget),
            PositionedInfoCard(address: _address),
          ],
        );
      },
    );
  }

  Widget _buildPlaceholder(String text) {
    return Container(
      color: Colors.grey.shade200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.map_outlined, size: 80, color: Colors.grey),
            const SizedBox(height: 8),
            Text(
              text,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
