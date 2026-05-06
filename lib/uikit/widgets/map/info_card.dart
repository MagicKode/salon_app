import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/nearbymapscreen/domain/location_model.dart';

class InfoCardWidget extends StatelessWidget {
  final LocationModel shopLocation;
  final VoidCallback onRoutePressed;

  const InfoCardWidget({
    super.key,
    required this.shopLocation,
    required this.onRoutePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0x9D093882),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildIcon(),
          const SizedBox(width: 12),
          Expanded(child: _buildTextInfo()),
          _buildRouteButton(),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Colors.white38,
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.directions_walk, color: Colors.white),
    );
  }

  Widget _buildTextInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          shopLocation.distanceInKm != null
              ? 'До нас ${shopLocation.formattedDistance}'
              : 'Определение расстояния...',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          shopLocation.address,
          style: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildRouteButton() {
    return IconButton(
      onPressed: onRoutePressed,
      icon: const Icon(Icons.near_me, color: Colors.white, size: 30),
    );
  }
}
