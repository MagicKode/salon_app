import 'package:flutter/material.dart';

import '../../../../../uikit/widgets/card/specialist_card.dart';
import 'domain/master_data.dart';

class SpecialistsBody extends StatelessWidget {
  const SpecialistsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final masters = MasterData.allMasters;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: masters.map((m) => SpecialistCard(master: m)).toList(),
      ),
    );
  }
}
