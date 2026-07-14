import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/uikit/widgets/card/specialist/specialistcard/specialist_card.dart';
import '../../../../catalog/domain/repositories/catalog_repository.dart';
import '../../../../catalog/data/models/catalog_image.dart';
import 'domain/master.dart';

class SpecialistsBody extends StatelessWidget {
  const SpecialistsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CatalogImage>>(
      future: context.read<CatalogRepository>().getImages('master', 0),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox.shrink();
        }

        final imageUrl = snapshot.data!.first.url;
        final master = Master(
          id: '1',
          name: 'Павел',
          position: 'Топ-мастер',
          description: '(20 лет опыта • Мастер международного класса.)',
          imageUrl: imageUrl,
        );

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SpecialistCard(master: master),
            ],
          ),
        );
      },
    );
  }
}
