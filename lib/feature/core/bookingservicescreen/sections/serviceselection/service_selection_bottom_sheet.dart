import 'package:flutter/material.dart';
import '../../../../../uikit/strings/app_strings.dart';
import '../../../../../uikit/colors/app_colors.dart';
import '../../../../../uikit/widgets/app_button.dart';
import '../../domain/add_service_data.dart';

class ServiceSelectionBottomSheet extends StatefulWidget {
  final List<AddServiceData> alreadySelected;
  final Function(List<AddServiceData>) onServicesConfirmed;

  const ServiceSelectionBottomSheet({
    super.key,
    required this.alreadySelected,
    required this.onServicesConfirmed,
  });

  @override
  State<ServiceSelectionBottomSheet> createState() =>
      _ServiceSelectionBottomSheetState();
}

class _ServiceSelectionBottomSheetState
    extends State<ServiceSelectionBottomSheet> {
  late List<AddServiceData> _selected;

  final List<AddServiceData> _allServices = [
    AddServiceData(id: '1', name: 'Женская стрижка', price: 30),
    AddServiceData(id: '2', name: 'Мужская стрижка', price: 25),
    AddServiceData(id: '3', name: 'Окрашивание волос', price: 80),
    AddServiceData(id: '4', name: 'Уход за волосами', price: 45),
    AddServiceData(id: '5', name: 'Массаж головы', price: 35),
  ];

  @override
  void initState() {
    super.initState();
    _selected = List.from(widget.alreadySelected);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: AppColors.primaryBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              AppStrings.chooseYourService,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _allServices.length,
              itemBuilder: (context, index) {
                final service = _allServices[index];
                final isSelected = _selected.any((s) => s.id == service.id);

                return CheckboxListTile(
                  title: Text(service.name),
                  subtitle: Text('${service.price} ${AppStrings.currency}'),
                  value: isSelected,
                  activeColor: AppColors.primaryBlue,
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        _selected.add(service);
                      } else {
                        _selected.removeWhere((s) => s.id == service.id);
                      }
                    });
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: AppButton(
              text: AppStrings.addToServices,
              onPressed: () {
                widget.onServicesConfirmed(_selected);
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
