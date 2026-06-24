import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/homepagescreen/home_page_body.dart';

import '../catalogscreen/domain/catalog_service.dart';

class HomePageScreen extends StatefulWidget {
  final bool isMaster;
  final Function(CatalogService service)? onQuickBookRequested;

  const HomePageScreen({
    super.key,
    required this.isMaster,
    this.onQuickBookRequested,
  });

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // ✅ Сохраняем состояние при смене вкладок

  @override
  Widget build(BuildContext context) {
    super.build(context); // Обязательно для AutomaticKeepAliveClientMixin
    return HomePageBody(
      isMaster: widget.isMaster,
      onQuickBookRequested: widget.onQuickBookRequested,
    );
  }
}
