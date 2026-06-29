import 'package:flutter/material.dart';
import '../../../uikit/widgets/map/positioned_info_card.dart';
import '../../../uikit/widgets/map/mapview/map_widget.dart';
import '../../../uikit/widgets/map/locationbutton/positioned_location_button.dart';

class NearbyMapBody extends StatelessWidget {
  const NearbyMapBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const MapWidget(),           // Слой 1: Карта
        const PositionedLocationButton(), // Слой 2: Кнопка GPS
        const PositionedInfoCard(),  // Слой 3: Твоя новая карточка
      ],
    );
  }
}
