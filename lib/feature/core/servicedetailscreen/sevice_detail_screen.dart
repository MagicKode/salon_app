import 'package:flutter/material.dart';

import 'domain/service_detail_data.dart';
import 'service_detail_body.dart';

class ServiceDetailScreen extends StatelessWidget {
  final ServiceDetail service;
  final bool isMaster;

  const ServiceDetailScreen({
    super.key,
    required this.service,
    this.isMaster = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(service.title), centerTitle: true),
      body: ServiceDetailBody(
        service: service,
        isMaster: isMaster,
      ),
    );
  }
}
