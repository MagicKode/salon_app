import 'package:flutter/material.dart';

import '../../../../../../uikit/colors/app_colors.dart';
import '../../../feature/checkout/domain/booking_entity.dart';
import '../../strings/app_strings.dart';
import '../../utils/clientsCardsDateFormater/app_date_formats.dart';
import '../dialog/cancel_booking_dialog.dart';
import 'expandable_note.dart';

class HistoryBookingCard extends StatefulWidget {
  final BookingEntity booking;
  final bool isDimmed;
  final VoidCallback? onCancelSuccess;

  const HistoryBookingCard({
    super.key,
    required this.booking,
    this.isDimmed = false,
    this.onCancelSuccess,
  });

  @override
  State<HistoryBookingCard> createState() => _HistoryBookingCardState();
}

class _HistoryBookingCardState extends State<HistoryBookingCard> {
  // 1. Добавляем флаг анимации схлопывания карточки
  bool _isCollapsing = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: _isCollapsing ? 0.0 : (widget.isDimmed ? 0.5 : 1.0),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: Alignment.topCenter,
        // Чтобы нижние карточки плавно ехали вверх
        child:
            _isCollapsing
                ? const SizedBox(
                  height: 0,
                  width: double.infinity,
                ) // Конечная точка анимации
                : Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.boxDecorationColor,
                    border: Border.all(
                      color: AppColors.primaryBlue.withOpacity(0.2),
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        // Верхняя часть: Иконка + Инфо + Цена
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 1. Иконка услуги
                          Container(
                            padding: const EdgeInsets.all(2),
                            child: const Icon(
                              Icons.content_cut,
                              color: AppColors.primaryBlue,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 8),

                          // 2. Центральный блок (Услуга и Мастер)
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.booking.serviceNames,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    height: 1.1,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${AppStrings.labelMaster}: ${widget.booking.masterName}',
                                  style: const TextStyle(
                                    color: AppColors.primaryBlue,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // 3. Правый блок (Цена + кнопка отмены)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.payments_outlined,
                                    size: 14,
                                    color: AppColors.primaryBlue.withOpacity(
                                      0.5,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${widget.booking.price} BYN',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: AppColors.primaryBlue,
                                    ),
                                  ),
                                ],
                              ),

                              // ДОБАВИЛИ КНОПКУ ОТМЕНЫ (только для актуальных записей)
                              if (!widget.isDimmed) ...[
                                const SizedBox(height: 8),
                                GestureDetector(
                                  onTap:
                                      () => showDialog(
                                        context: context,
                                        builder:
                                            (dialogContext) =>
                                                CancelBookingDialog(
                                                  bookingId:
                                                      '${widget.booking.id}',
                                                  onCancelSuccess:
                                                      widget.onCancelSuccess,
                                                ),
                                      ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        AppStrings.cancelBookingService,
                                        style: TextStyle(
                                          color: AppColors.primaryRed,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      Icon(
                                        Icons.delete_outline,
                                        color: AppColors.primaryRed,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      // 4. Дата
                      Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Text(
                          AppDateFormats.formatBookingDate(
                            widget.booking.dateTime,
                          ),
                          style: const TextStyle(
                            color: AppColors.primaryBlack,
                            fontSize: 10,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      if (widget.booking.notes != null &&
                          widget.booking.notes!.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        ExpandableNote(note: widget.booking.notes!),
                      ],
                    ],
                  ),
                ),
      ),
    );
  }
}
