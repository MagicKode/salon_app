import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../uikit/colors/app_colors.dart';
import '../../../../../uikit/strings/app_strings.dart';
import '../../../../../uikit/widgets/button/app_button.dart';
import '../../../../catalog/data/models/service_dto.dart';
import '../../../../catalog/domain/repositories/catalog_repository.dart';
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

  @override
  void initState() {
    super.initState();
    _selected = List.from(widget.alreadySelected);
  }

  @override
  Widget build(BuildContext context) {
    final repository = context.read<CatalogRepository>();

    return FutureBuilder<List<ServiceDto>>( // ✅ тип Future<List<ServiceDto>>
      future: repository.getServices(),
      builder: (context, snapshot) {
        List<AddServiceData> allServices = [];
        if (snapshot.hasData && snapshot.data != null) {
          allServices = snapshot.data!.map((service) {
            return AddServiceData(
              id: service.id.toString(),
              name: service.name,
              price: service.price,
              // Если в ServiceDto есть durationMinutes – берём его, иначе 30
              durationMinutes: service.durationMinutes ?? 30,
            );
          }).toList();
        }

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
                child: snapshot.connectionState == ConnectionState.waiting
                    ? const Center(child: CircularProgressIndicator())
                    : snapshot.hasError
                    ? const Center(child: Text('Ошибка загрузки услуг'))
                    : allServices.isEmpty
                    ? const Center(child: Text('Нет доступных услуг'))
                    : ListView.builder(
                  itemCount: allServices.length,
                  itemBuilder: (context, index) {
                    final service = allServices[index];
                    final isSelected = _selected.any((s) => s.id == service.id);

                    return Material(
                      color: Colors.transparent,
                      child: CheckboxListTile(
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
                      ),
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
      },
    );
  }
}
