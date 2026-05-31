import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/homepagescreen/home_page_body.dart';

import '../catalogscreen/domain/catalog_service.dart';

class HomePageScreen extends StatelessWidget {
  final bool isMaster;
  final Function(CatalogService service)? onQuickBookRequested;

  const HomePageScreen({
    super.key,
    required this.isMaster,
    this.onQuickBookRequested,
  });

  @override
  Widget build(BuildContext context) {
    return HomePageBody(
      isMaster: isMaster,
      onQuickBookRequested: onQuickBookRequested,
    );
  }
}
