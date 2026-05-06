import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../uikit/widgets/map/info_card.dart';
import '../../../uikit/widgets/map/location_button.dart';
import '../../../uikit/widgets/map/map_widget.dart';
import 'cubit/nearby_cubit.dart';
import 'cubit/nearby_state.dart';

class NearbyMapBody extends StatelessWidget {
  const NearbyMapBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NearbyCubit, NearbyState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.hasError) {
          return _buildErrorWidget(context);
        }

        return Stack(
          children: [
            MapWidget(
              shopLocation: state.shopLocation!,
              userLocation: state.userLocation,
              routePoints: state.routePoints,
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 20,
              child: InfoCardWidget(
                shopLocation: state.shopLocation!,
                onRoutePressed: () {
                  // TODO: Открыть маршрут в внешнем приложении (Yandex Maps / Google Maps)
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Маршрут будет открыт в навигаторе'),
                    ),
                  );
                },
              ),
            ),

            // Кнопка обновления геолокации
            LocationButton(
              onPressed: () => context.read<NearbyCubit>().getUserLocation(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildErrorWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.location_off, size: 80, color: Colors.grey),
          const SizedBox(height: 16),
          const Text('Не удалось определить местоположение'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.read<NearbyCubit>().getUserLocation(),
            child: const Text('Повторить'),
          ),
        ],
      ),
    );
  }
}
