import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/sections/bookingbottombar/booking_bottom_bar.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/sections/calendar/date_selection_section.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/sections/notes/notes_section.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/sections/order/order_summary_section.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/sections/serviceselection/service_selection_bottom_sheet.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/sections/specialist/specialist_selector_section.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/sections/time/time_selection_section.dart';

import '../../../../uikit/strings/app_strings.dart';
import '../../checkout/domain/booking_entity.dart';
import 'domain/add_service_data.dart';
import 'domain/booking_logic.dart';

class BookingServiceBody extends StatefulWidget {
  final Function(BookingEntity booking, List<AddServiceData> services)? onBookPressed;

  const BookingServiceBody({super.key, this.onBookPressed});

  @override
  State<BookingServiceBody> createState() => _BookingServiceBodyState();
}

class _BookingServiceBodyState extends State<BookingServiceBody> {
  // Состояние экрана
  List<AddServiceData> _selectedServices = [];
  String _selectedMaster = "Pavel";
  String _masterTitle = "Топ-стилист";
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  double get _totalPrice => _selectedServices.totalPrice;
  int get _requiredSlots => _selectedServices.requiredSlots;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OrderSummarySection(
                  selectedServices: _selectedServices,
                  onAddMoreServices: _showServiceSelection,
                  onRemoveService: _removeService,
                ),
                const SizedBox(height: 32),

                SpecialistSelectorSection(
                  onMasterSelected: _updateMaster,
                ),
                const SizedBox(height: 24),

                DateSelectionSection(
                  onDateSelected: (date) => setState(() => _selectedDate = date),
                ),
                const SizedBox(height: 24),

                TimeSelectionSection(
                  // Передаем динамически вычисленное кол-во слотов
                  requiredSlots: _requiredSlots,
                  onTimeChanged: (time) => setState(() => _selectedTime = time),
                ),
                const SizedBox(height: 24),

                const NotesSection(),
              ],
            ),
          ),
        ),
        BookingBottomBar(
          totalPrice: _totalPrice,
          onTap: _handleBookingProcess,
        ),
      ],
    );
  }

  // --- Методы обновления состояния (State Management) ---
  void _updateMaster(String name, String title) {
    setState(() {
      _selectedMaster = name;
      _masterTitle = title;
    });
  }

  void _showServiceSelection() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => ServiceSelectionBottomSheet(
        alreadySelected: _selectedServices,
        onServicesConfirmed: (services) => setState(() => _selectedServices = services),
      ),
    );
  }

  void _removeService(AddServiceData service) {
    setState(() {
      _selectedServices.removeWhere((s) => s.id == service.id);
      _selectedTime = null;
    });
  }

  // --- Бизнес-логика (Action Logic) ---
  void _handleBookingProcess() {
    if (!_isInputValid()) return;

    final booking = _selectedServices.toEntity(
      masterName: _selectedMaster,
      date: _selectedDate!,
      time: _selectedTime!,
    );

    widget.onBookPressed?.call(booking, _selectedServices);
  }

  bool _isInputValid() {
    if (_selectedServices.isEmpty) {
      _showError(AppStrings.chooseAnyService);
      return false;
    }
    if (_selectedDate == null || _selectedTime == null) {
      _showError(AppStrings.pleaseChooseData);
      return false;
    }
    return true;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
