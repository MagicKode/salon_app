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
    final appointment = widget.appointment;
    final bool canExpand = appointment.hasDetails;

    return GestureDetector(
      onTap:
          canExpand ? () => setState(() => _isExpanded = !_isExpanded) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: _cardDecoration(canExpand),
        child: Column(
          children: [
            _buildMainHeader(appointment),
            if (_isExpanded && canExpand) _buildExpandedContent(appointment),
            _buildBottomBar(appointment, canExpand),
          ],
        ),
      ),
    );
  }

  // --- Кусочки верстки (Методы) ---
  Widget _buildMainHeader(AppointmentModel appointment) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Icon(Icons.content_cut, color: AppColors.primaryBlue, size: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appointment.mainService,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "Клиент: ${appointment.clientName}",
                  style: const TextStyle(
                    color: AppColors.primaryBlue,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.delete_outline,
              color: Colors.red.withOpacity(0.7),
              size: 30,
            ),
            onPressed: () => _confirmDelete(context),
          ),
        ],
      ),
    );
  }

  // Метод подтверждения удаления
  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(AppStrings.deleteBooking),
        content: Text("Вы действительно хотите отменить запись клиента ${widget.appointment.clientName}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              widget.onDelete(); // Вызываем удаление из родителя
            },
            child: const Text(AppStrings.deleteBookedService, style: TextStyle(color: AppColors.primaryRed)),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedContent(AppointmentModel appointment) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          const SizedBox(height: 8),
          if (appointment.servicesNames.length > 1) ...[
            _headerText(AppStrings.allServices),
            ...appointment.servicesNames.map(
              (s) => Text("• $s", style: const TextStyle(fontSize: 13)),
            ),
            const SizedBox(height: 12),
          ],
          if (appointment.notes != null) ...[
            _headerText(AppStrings.detailsForMaster),
            _buildNotesBox(appointment.notes!),
          ],
        ],
      ),
    );
  }

  Widget _buildBottomBar(AppointmentModel appointment, bool canExpand) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withOpacity(_isExpanded ? 0.08 : 0.03),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.access_time, size: 16, color: AppColors.primaryGrey),
          const SizedBox(width: 8),
          Text(
            appointment.timeRange,
            style: const TextStyle(
              color: AppColors.dateGrey,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Text(
            _isExpanded ? AppStrings.closeDetails : AppStrings.details,
            style: TextStyle(
              color: canExpand ? AppColors.primaryBlue : AppColors.primaryGrey,
              fontSize: 12,
            ),
          ),
          Icon(
            _isExpanded ? Icons.expand_less : Icons.expand_more,
            size: 16,
            color: canExpand ? AppColors.primaryBlue : AppColors.primaryGrey,
          ),
        ],
      ),
    );
  }

  // --- Маленькие хелперы для верстки ---
  BoxDecoration _cardDecoration(bool canExpand) => BoxDecoration(
    color: AppColors.boxDecorationColor,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(
      color:
          _isExpanded
              ? AppColors.primaryBlue
              : AppColors.primaryBlue.withOpacity(0.5),
      width: _isExpanded ? 1.5 : 1,
    ),
  );

  Widget _headerText(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
    ),
  );

  Widget _buildNotesBox(String notes) => Container(
    padding: const EdgeInsets.all(10),
    width: double.infinity,
    decoration: BoxDecoration(
      color: AppColors.boxDecorationColor,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      notes,
      style: const TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
    ),
  );
}
