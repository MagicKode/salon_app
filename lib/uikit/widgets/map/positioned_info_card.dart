import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../feature/core/nearbymapscreen/cubit/nearby_cubit.dart';
import '../../../feature/core/nearbymapscreen/cubit/nearby_state.dart';
import 'infocardwidget/info_card_widget.dart';

class PositionedInfoCard extends StatelessWidget {
  const PositionedInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      right: 16,
      bottom: 30,
      child: BlocBuilder<NearbyCubit, NearbyState>(
        buildWhen: (p, c) => p.shopLocation.distanceInKm != c.shopLocation.distanceInKm,
        builder: (context, state) {
          return InfoCardWidget(
            shopLocation: state.shopLocation,
            onRoutePressed: () async {
              final lat = state.shopLocation.coordinates.latitude;
              final lng = state.shopLocation.coordinates.longitude;

              // Самая простая и надежная ссылка для мобильных устройств
              final Uri uri = Uri.parse('geo:$lat,$lng?q=$lat,$lng');

              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              } else {
                // Если geo: не сработал (редко), пробуем https версию
                final httpsUri = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');
                await launchUrl(httpsUri, mode: LaunchMode.externalApplication);
              }
            },
          );
        },
      ),
    );
  }
}
