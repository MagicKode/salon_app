import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/domain/time_slot_model.dart';
import 'package:salon_flutter/uikit/widgets/time/time_slot_title.dart';
import '../../../feature/core/bookingservicescreen/bookingblock/booking_slots_bloc.dart';
import '../../../feature/core/bookingservicescreen/bookingblock/booking_slots_state.dart';
import '../../colors/app_colors.dart';

class TimeSlotsGrid extends StatelessWidget {
  final String? selectedTime;
  final List<TimeSlotModel> selectedSlots;
  final ValueChanged<String> onTimeSelected; // Передаем строку наверх при выборе

  const TimeSlotsGrid({
    super.key,
    this.selectedTime,
    required this.selectedSlots,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingSlotsBloc, BookingSlotsState>(
      builder: (context, state) {
        // 1. Состояние ожидания выбора даты
        if (state is BookingSlotsInitial) {
          return const Center(
            child: Text("Выберите дату для просмотра времени"),
          );
        }

        // 2. Идет запрос к микросервису — показываем лоадер вместо кнопок
        if (state is BookingSlotsLoading) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 24.0),
            child: Center(
              child: CircularProgressIndicator(color: AppColors.primaryBlue),
            ),
          );
        }

        // 3. Сервер вернул ошибку
        if (state is BookingSlotsFailure) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "Ошибка загрузки слотов: ${state.errorMessage}",
                style: const TextStyle(color: AppColors.primaryRed, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        // 4. Успешно получили слоты от Spring Boot
        if (state is BookingSlotsSuccess) {
          final List<TimeSlotModel> slots = state.slots;

          if (slots.isEmpty) {
            return const Center(
              child: Text("Нет доступных слотов на выбранный день"),
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
                onTap: slot.isAvailable ? () => onTimeSelected(slot.time) : null,
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
