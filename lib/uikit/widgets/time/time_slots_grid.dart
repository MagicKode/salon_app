import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/domain/time_slot_model.dart';
import 'package:salon_flutter/uikit/widgets/time/time_slot_title.dart';

import '../../../config/theme/custom_colors.dart'; // ✅ импорт динамических цветов
import '../../../feature/core/bookingservicescreen/bookingblock/booking_slots_bloc.dart';
import '../../../feature/core/bookingservicescreen/bookingblock/booking_slots_state.dart';

class TimeSlotsGrid extends StatelessWidget {
  final String? selectedTime;
  final List<TimeSlotModel> selectedSlots;
  final ValueChanged<String> onTimeSelected;

  const TimeSlotsGrid({
    super.key,
    this.selectedTime,
    required this.selectedSlots,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем динамические цвета внутри билдера
    final colors = Theme.of(context).extension<CustomColors>()!;

    return BlocBuilder<BookingSlotsBloc, BookingSlotsState>(
      builder: (context, state) {
        if (state is BookingSlotsInitial) {
          return Center(
            child: Text(
              "Выберите дату для просмотра времени",
              style: TextStyle(
                color: colors.textSecondary, // ✅ динамический серый
                fontSize: 14,
              ),
            ),
          );
        }

        if (state is BookingSlotsLoading) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Center(
              child: CircularProgressIndicator(
                color: colors.primaryBlue, // ✅ динамический синий
              ),
            ),
          );
        }

        if (state is BookingSlotsFailure) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "Ошибка загрузки слотов: ${state.errorMessage}",
                style: TextStyle(
                  color: colors.statusError, // ✅ динамический красный
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        if (state is BookingSlotsSuccess) {
          final List<TimeSlotModel> slots = state.slots;

          if (slots.isEmpty) {
            return Center(
              child: Text(
                "Нет доступных слотов на выбранный день",
                style: TextStyle(
                  color: colors.textSecondary, // ✅ динамический серый
                  fontSize: 14,
                ),
              ),
            );
          }

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 2.5,
            ),
            itemCount: slots.length,
            itemBuilder: (context, index) {
              final TimeSlotModel slot = slots[index];
              final isSelected = selectedSlots.any((s) => s.time == slot.time);

              return TimeSlotTile(
                label: slot.time,
                isHighlighted: isSelected,
                isAvailable: slot.isAvailable,
                onTap:
                    slot.isAvailable ? () => onTimeSelected(slot.time) : null,
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
