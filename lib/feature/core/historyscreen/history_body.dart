import 'package:flutter/material.dart';
import 'sections/history_list_section.dart';

class HistoryBody extends StatelessWidget {
  const HistoryBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: const [
        HistoryListSection(),
      ],
    );
  }
}
