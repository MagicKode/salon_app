import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/servicedetailscreen/service_detail_body.dart';

import 'domain/service_detail_data.dart';

class ServiceDetailScreen extends StatelessWidget {
  const ServiceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Передаем конкретный объект из нашего класса данных
      body: ServiceDetailBody(
        service: ServiceDetailData.mensHaircut,
      ),
    );
  }
}
