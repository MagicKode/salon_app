import 'package:flutter/material.dart';

import '../homepagescreen/domain/home_models.dart';
import 'domain/service_detail_data.dart';
import 'service_detail_body.dart';

class ServiceDetailScreen extends StatelessWidget {
  final ServiceCategory category;
  final bool isModal;

  const ServiceDetailScreen({
    super.key,
    required this.category,
    this.isModal = true,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Ищем данные.
    final detail = ServiceDetailData.allDetails.firstWhere(
      (element) => element.title == category.title,
      orElse: () => ServiceDetailData.mensHaircut,
    );

    // 2. Создаем контент напрямую
    final Widget content = ServiceDetailBody(service: detail);

    // 3. Возвращаем результат
    if (isModal) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(title: Text(category.title), centerTitle: true),
      body: content,
    );
  }
}
