import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

import 'description_data.dart';

class DescriptionSection extends StatelessWidget {
  final DescriptionData data;

  const DescriptionSection({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Заголовок
          Text(
            data.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          // Полное описание с возможностью раскрытия
          ExpandableText(
            data.fullText, // Используем полный текст
            expandText: 'Подробнее',
            collapseText: 'Свернуть',
            maxLines: 3, // Показываем первые 3 строки
            linkColor: Colors.blue,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
              height: 1.5,
            ),
            // Можно добавить префикс с кратким описанием
            prefixText: data.shortDescription,
            prefixStyle: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
