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

class BookingServiceBody extends StatefulWidget {
  final Function(BookingEntity booking, List<AddServiceData> services)?
  onBookPressed;

  const BookingServiceBody({super.key, this.onBookPressed});

  @override
  State<BookingServiceBody> createState() => _BookingServiceBodyState();
}

class _BookingServiceBodyState extends State<BookingServiceBody> {
  List<AddServiceData> _selectedServices = [];
  String _selectedMaster = "Pavel";
  String _masterTitle = "Топ-стилист";
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  double get _totalPrice =>
      _selectedServices.fold(0.0, (sum, service) => sum + service.price);

  @override
  void initState() {
    super.initState();
    // Можно задать дату по умолчанию — сегодня
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
                  onMasterSelected: (masterName, title) {
                    setState(() {
                      _selectedMaster = masterName;
                      _masterTitle = title;
                    });
                  },
                ),

                const SizedBox(height: 24),

                DateSelectionSection(
                  onDateSelected: (date) {
                    setState(() => _selectedDate = date);
                  },
                ),

                const SizedBox(height: 24),

                TimeSelectionSection(
                  onTimeChanged: (time) {
                    setState(() => _selectedTime = time);
                  },
                ),

                const SizedBox(height: 24),

                const NotesSection(),
              ],
            ),
          ),
        ),

        BookingBottomBar(totalPrice: _totalPrice, onTap: _onBookPressed),
      ],
    );
  }

  void _showServiceSelection() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder:
          (context) => ServiceSelectionBottomSheet(
            alreadySelected: _selectedServices,
            onServicesConfirmed: (services) {
              setState(() => _selectedServices = services);
            },
          ),
    );
  }

  void _removeService(AddServiceData service) {
    setState(() {
      _selectedServices.removeWhere((s) => s.id == service.id);
    });
  }

  void _onBookPressed() {
    if (_selectedServices.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(AppStrings.chooseAnyService)));
      return;
    }

    if (_selectedDate == null || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.pleaseChooseData)),
      );
      return;
    }

    final booking = BookingEntity(
      serviceName: _selectedServices.map((s) => s.name).join(", "),
      masterName: _selectedMaster,
      dateTime: DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      ),
      price: _totalPrice,
      durationMinutes: 60, // TODO: сделать динамическим из услуг
    );

    widget.onBookPressed?.call(booking, _selectedServices);
  }
}
