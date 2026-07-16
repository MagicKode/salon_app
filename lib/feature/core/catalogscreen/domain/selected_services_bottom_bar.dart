import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../../config/theme/custom_colors.dart';
import 'bottom_bar_item_data.dart';

class SelectedServicesBottomBar extends StatelessWidget {
  final List<BottomBarItemData> items;
  final String titleText;
  final String buttonText;
  final VoidCallback onProceed;
  final Function(String id)? onRemoveItem;

  const SelectedServicesBottomBar({
    super.key,
    required this.items,
    this.titleText = AppStrings.chosenServices,
    this.buttonText = AppStrings.nextService,
    required this.onProceed,
    this.onRemoveItem,
  });

  // Метод, который показывает выезжающую шторку со списком услуг
  void _showSelectedServicesSheet(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    showModalBottomSheet(
      context: context,
      backgroundColor: colors.backgroundPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Линия-индикатор для закрытия шторки свайпом
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: colors.divider,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  titleText,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),

                // Нативный гибкий список внутри шторки
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: items.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      thickness: 0.5,
                      color: colors.divider,
                    ),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          item.name,
                          style: TextStyle(
                            fontSize: 14,
                            color: colors.textPrimary,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${item.price.toStringAsFixed(0)} BYN',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: colors.primaryBlue,
                              ),
                            ),
                            if (onRemoveItem != null) ...[
                              const SizedBox(width: 8),
                              IconButton(
                                icon: Icon(
                                  Icons.close_rounded,
                                  color: colors.textSecondary,
                                  size: 20,
                                ),
                                onPressed: () {
                                  onRemoveItem!(item.id);
                                  // Если удалили последний элемент, закрываем шторку автоматически
                                  if (items.length <= 1) {
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            ],
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;
    // Если ничего не выбрано, возвращаем пустой виджет (скрываем панель)
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    // Высчитываем итоговую сумму на лету
    final double totalPrice = items.fold(0, (sum, item) => sum + item.price);

    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 24),
      decoration: BoxDecoration(
        color: colors.backgroundPrimary,
        boxShadow: [
          BoxShadow(
            color: colors.shadow,
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Левая часть: Инфо о выбранных услугах
          GestureDetector(
            onTap: () => _showSelectedServicesSheet(context),
            behavior: HitTestBehavior.opaque,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      titleText,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: colors.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 6),
                    Icon(
                      Icons.keyboard_double_arrow_up_rounded,
                      size: 20,
                      color: colors.primaryBlue,
                    ),
                  ],
                ),
                Text(
                  '${totalPrice.toStringAsFixed(0)} BYN',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: colors.primaryBlue,
                  ),
                ),
              ],
            ),
          ),

          // Правая часть: Кнопка перехода к дате/времени
          ElevatedButton(
            onPressed: onProceed,
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primaryBlue,
              foregroundColor: colors.textOnPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: Row(
              children: [
                Text(
                  buttonText,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: colors.textOnPrimary,
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: colors.textOnPrimary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
