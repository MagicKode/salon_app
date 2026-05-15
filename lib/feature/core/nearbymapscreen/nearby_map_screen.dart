import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:salon_flutter/feature/core/nearbymapscreen/domain/location_model.dart';

import '../../../uikit/colors/app_colors.dart';
import '../../../uikit/strings/app_strings.dart';
import 'cubit/nearby_cubit.dart';
import 'domain/location_repository.dart';
import 'nearby_map_body.dart';

class NearbyMapScreen extends StatelessWidget {
  const NearbyMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.howToFind,
          style: TextStyle(
            color: AppColors.primaryBlack,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primaryWhite,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocProvider(
        create:
            (_) => NearbyCubit(
              repository: LocationRepository(),
              shopLocation: const LocationModel(
                coordinates: LatLng(53.894034, 27.541170),
                address: "ул. Мясникова 78, Минск",
              ),
            )..init(), // автоматически при открытии
        child: const NearbyMapBody(),
      ),
    );
  }
}
