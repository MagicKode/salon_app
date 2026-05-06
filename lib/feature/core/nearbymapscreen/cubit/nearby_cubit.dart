import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/location_model.dart';
import '../domain/location_repository.dart';
import 'nearby_state.dart';

class NearbyCubit extends Cubit<NearbyState> {
  final ILocationRepository repository;
  final LocationModel shopLocation;

  NearbyCubit({
    required this.repository,
    required this.shopLocation,
  }) : super(NearbyState(
    status: NearbyStatus.initial,
    shopLocation: shopLocation,
  ));

  Future<void> getUserLocation() async {
    if (state.isLoading) return;

    emit(state.copyWith(status: NearbyStatus.loading));

    try {
      final userLocation = await repository.getCurrentLocation();
      final distance = await repository.calculateDistance(
        userLocation.coordinates,
        shopLocation.coordinates,
      );

      final updatedShopLocation = shopLocation.copyWith(distanceInKm: distance);

      emit(state.copyWith(
        status: NearbyStatus.loaded,
        userLocation: userLocation,
        shopLocation: updatedShopLocation,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: NearbyStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}