import 'package:flutter/material.dart';

import 'catalog_body.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CatalogBody(),
    );
  }
}