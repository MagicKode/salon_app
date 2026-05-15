import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../feature/core/nearbymapscreen/cubit/nearby_cubit.dart';
import 'location_button.dart';

class PositionedLocationButton extends StatelessWidget {
  const PositionedLocationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 16,
      bottom: 150,
      child: LocationButton(
        onPressed: () {
          print("Клик по кнопке GPS!"); // Проверь, появится ли это в консоли
          context.read<NearbyCubit>().moveToUser();
        },
      ),
    );
  }
}
