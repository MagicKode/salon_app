import 'package:flutter/material.dart';

class HistoryCardExpanded extends StatelessWidget {
  final List<String> servicesList;

  const HistoryCardExpanded({super.key, required this.servicesList});

  @override
  Widget build(BuildContext context) {
    if (servicesList.length <= 1) return const SizedBox.shrink();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          const Text(
            'Все услуги:',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          const SizedBox(height: 4),
          ...servicesList.map(
                (s) => Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 2),
              child: Text('• $s', style: const TextStyle(fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }
}
