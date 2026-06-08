import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../../../uikit/colors/app_colors.dart';
import '../../../feature/core/mastercalendarscreen/domain/appointment_model.dart';

class MasterAppointmentCard extends StatefulWidget {
  final AppointmentModel appointment;
  final VoidCallback onDelete;

  const MasterAppointmentCard({
    super.key,
    required this.appointment,
    required this.onDelete,
  });

  @override
  State<MasterAppointmentCard> createState() => _MasterAppointmentCardState();
}

class _MasterAppointmentCardState extends State<MasterAppointmentCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final a = widget.appointment;
    final canExpand = a.hasDetails;

    return GestureDetector(
      onTap: canExpand ? () => setState(() => _isExpanded = !_isExpanded) : null,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.boxDecorationColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isExpanded ? AppColors.primaryBlue : AppColors.primaryBlue.withOpacity(0.5),
            width: _isExpanded ? 1.5 : 1,
          ),
        ),

        child: Column(
          children: [
            // Верхняя часть
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 8, right: 4, bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: Icon(Icons.content_cut, color: AppColors.primaryBlue, size: 20),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Название услуги + иконка удаления справа
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Text(a.mainService, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              ),
                            ),

                            // Иконка удаления в правом верхнем углу
                            Positioned(
                              right: 0,
                              top: 0,
                              child: IconButton(
                                icon: Icon(Icons.delete_outline, color: Colors.red.withOpacity(0.7), size: 22),
                                onPressed: () => _confirmDelete(context),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 5),

                        // Клиент и телефон
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(fontSize: 14),
                            children: [
                              const TextSpan(
                                text: "Клиент: ",
                                style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text: a.displayClientName,
                                style: const TextStyle(color: AppColors.primaryBlack, fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text: " (${a.clientPhone})",
                                style: TextStyle(color: Colors.grey.shade500, fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Цена и статус на одном уровне
                        Row(
                          children: [
                            if (a.totalPrice > 0)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryBlue.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(a.priceDisplay, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                              ),
                            const Spacer(),
                            _buildStatusChip(a.status),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Раскрывающиеся детали (между ценой и временем)
            if (_isExpanded && canExpand) _buildExpanded(a),

            // Нижняя панель с временем и кнопкой Детали
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withOpacity(
                  _isExpanded ? 0.08 : 0.03,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    size: 14,
                    color: AppColors.primaryGrey,
                  ),

                  const SizedBox(width: 4),

                  Text(
                    a.timeRange,
                    style: const TextStyle(
                      color: AppColors.dateGrey,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const Spacer(),

                  if (canExpand) ...[
                    Text(
                      _isExpanded
                          ? AppStrings.closeDetails
                          : AppStrings.details,
                      style: const TextStyle(
                        color: AppColors.primaryBlue,
                        fontSize: 12,
                      ),
                    ),
                    Icon(
                      _isExpanded ? Icons.expand_less : Icons.expand_more,
                      size: 16,
                      color: AppColors.primaryBlue,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String? status) {
    Color bg, text;
    String label;
    switch (status?.toUpperCase()) {
      case 'CONFIRMED':
        bg = AppColors.primaryGreen.withOpacity(0.1);
        text = AppColors.primaryGreen;
        label = 'Подтверждено';
        break;
      case 'PENDING':
        bg = AppColors.starsYellow.withOpacity(0.1);
        text = AppColors.starsYellow;
        label = 'Ожидает';
        break;
      case 'CANCELED':
        bg = AppColors.primaryRed.withOpacity(0.1);
        text = AppColors.primaryRed;
        label = 'Отменено';
        break;
      default:
        bg = AppColors.primaryGrey.withOpacity(0.1);
        text = AppColors.primaryGrey;
        label = 'Неизвестно';
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: text,
        ),
      ),
    );
  }

  Widget _buildExpanded(AppointmentModel a) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(48, 8, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          const SizedBox(height: 4),
          if (a.servicesNames.length > 1) ...[
            const Text(
              AppStrings.allServices,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            ...a.servicesNames.map(
              (s) => Text("• $s", style: const TextStyle(fontSize: 13)),
            ),
            const SizedBox(height: 8),
          ],
          if (a.notes?.isNotEmpty == true) ...[
            const Text(
              AppStrings.detailsForMaster,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.boxDecorationColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                a.notes!,
                style: const TextStyle(
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text(AppStrings.deleteBooking),
            content: Text(
              "Отменить запись клиента ${widget.appointment.displayClientName}?",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(AppStrings.cancel),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  widget.onDelete();
                },
                child: const Text(
                  AppStrings.deleteBookedService,
                  style: TextStyle(color: AppColors.primaryRed),
                ),
              ),
            ],
          ),
    );
  }
}
