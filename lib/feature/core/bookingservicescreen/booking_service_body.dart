import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/sections/bookingbottombar/booking_bottom_bar.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/sections/calendar/date_selection_section.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/sections/notes/notes_section.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/sections/order/order_summary_section.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/sections/serviceselection/service_selection_bottom_sheet.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/sections/specialist/specialist_selector_section.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/sections/time/time_selection_section.dart';

import '../../../../uikit/strings/app_strings.dart';
import '../../checkout/domain/booking_entity.dart';
import '../catalogscreen/domain/catalog_service.dart';
import 'bookingblock/booking_slots_bloc.dart';
import 'bookingblock/booking_slots_event.dart';
import 'domain/add_service_data.dart';

class BookingServiceBody extends StatefulWidget {
  final List<CatalogService> initialServices;
  final Function(BookingEntity booking, List<AddServiceData> services)?
  onBookPressed;

  const BookingServiceBody({
    super.key,
    required this.initialServices,
    this.onBookPressed,
  });

  @override
  State<BookingServiceBody> createState() => _BookingServiceBodyState();
}

class _BookingServiceBodyState extends State<BookingServiceBody>
    with WidgetsBindingObserver {
  List<AddServiceData> _selectedServices = [];
  String _selectedMaster = 'Pavel';
  DateTime? _selectedDate;
  String? _selectedTime;

  final TextEditingController _notesController = TextEditingController();
  double get _totalPrice => _selectedServices.totalPrice;
  int get _requiredSlots => _selectedServices.requiredSlots;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _selectedMaster = 'Pavel';
    _selectedDate = DateTime.now();
    _selectedServices =
        widget.initialServices.map((service) {
          return AddServiceData(
            id: service.name,
            name: service.name,
            price: service.price,
          );
        }).toList();

    _notesController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _notesController.dispose();
    super.dispose();
  }

  // ✅ Обновление слотов при возврате на экран
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _refreshSlots();
    }
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
                  notes: _notesController.text,
                ),
                const SizedBox(height: 32),

                SpecialistSelectorSection(),
                const SizedBox(height: 24),

                DateSelectionSection(
                  masterName: _selectedMaster,
                  onDateSelected:
                      (date) => setState(() => _selectedDate = date),
                ),
                const SizedBox(height: 24),

                TimeSelectionSection(
                  // Передаем динамически вычисленное кол-во слотов
                  requiredSlots: _requiredSlots,
                  onTimeChanged:
                      (String? time) => setState(() => _selectedTime = time),
                ),
                const SizedBox(height: 24),

                NotesSection(controller: _notesController),
              ],
            ),
          ),
        ),
        BookingBottomBar(totalPrice: _totalPrice, onTap: _handleBookingProcess),
      ],
    );
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

  void _handleBookingProcess() {
    if (!_isInputValid()) return;

    final booking = _selectedServices.toEntity(
      masterName: _selectedMaster,
      date: _selectedDate!,
      time: _selectedTime!,
      notes: _notesController.text,
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
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _refreshSlots() {
    if (_selectedDate != null) {
      context.read<BookingSlotsBloc>().add(
        LoadBookingSlotsEvent(
          masterName: _selectedMaster,
          date: _selectedDate!,
        ),
      );
    }
  }
}
