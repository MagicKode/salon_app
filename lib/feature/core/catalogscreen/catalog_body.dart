import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/booking_service_screen.dart';
import 'package:salon_flutter/feature/core/catalogscreen/sections/catalog_search_bar.dart';
import 'package:salon_flutter/feature/core/catalogscreen/sections/category_grid_list.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../config/theme/custom_colors.dart';
import '../../../uikit/widgets/bottombarrow/service_list_bottom_sheet.dart';
import '../../catalog/data/models/category_dto.dart';
import '../../catalog/data/models/service_dto.dart';
import '../../catalog/domain/repositories/catalog_repository.dart';
import 'domain/bottom_bar_item_data.dart';
import 'domain/catalog_service.dart';
import 'domain/selected_services_bottom_bar.dart';

class CatalogBody extends StatefulWidget {
  const CatalogBody({super.key});

  @override
  State<CatalogBody> createState() => _CatalogBodyState();
}

class _CatalogBodyState extends State<CatalogBody> {
  final List<CatalogService> _selectedServices = [];
  final TextEditingController _searchController = TextEditingController();
  List<ServiceDto> _filteredServices = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase().trim();
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        _filteredServices = [];
      });
      return;
    }

    _isSearching = true;
    context.read<CatalogRepository>().getServices().then((allServices) {
      if (mounted) {
        setState(() {
          _filteredServices =
              allServices
                  .where((s) => s.name.toLowerCase().contains(query))
                  .toList();
        });
      }
    });
  }

  void _handleServiceSelection(CatalogService service) {
    setState(() {
      if (_selectedServices.contains(service)) {
        _selectedServices.remove(service);
      } else {
        _selectedServices.add(service);
      }
    });
  }

  void _navigateToBooking() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => BookingServiceScreen(selectedServices: _selectedServices),
      ),
    );
  }

  Widget _buildSearchResultsList() {
    final colors = Theme.of(context).extension<CustomColors>()!;

    if (_filteredServices.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 48,
              color: colors.textSecondary,
            ),
            SizedBox(height: 12),
            Text(
              'Ничего не найдено',
              style: TextStyle(color: colors.textSecondary),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _filteredServices.length,
      itemBuilder: (context, index) {
        final s = _filteredServices[index];
        final catalogService = CatalogService(
          id: s.id.toString(),
          name: s.name,
          price: s.price,
          duration: '${s.durationMinutes} мин',
        );
        final isSelected = _selectedServices.contains(catalogService);

        return ListTile(
          title: Text(s.name, style: TextStyle(color: colors.textPrimary)),
          subtitle: Text(
            '${s.durationMinutes} мин',
            style: TextStyle(color: colors.textSecondary),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${s.price} Br',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: colors.primaryBlue,
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => _handleServiceSelection(catalogService),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSelected ? colors.surfaceInput : colors.primaryBlue,
                  foregroundColor: isSelected ? colors.textPrimary : colors.textOnPrimary,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  isSelected ? 'Убрать' : 'Выбрать',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Scaffold(
      backgroundColor: colors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: colors.backgroundPrimary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: colors.textPrimary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppStrings.servicesCatalogTitle,
          style: TextStyle(
            color: colors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            CatalogSearchBar(controller: _searchController),
            const SizedBox(height: 8),
            Expanded(
              child:
                  _isSearching
                      ? _buildSearchResultsList()
                      : FutureBuilder<List<CategoryDto>>(
                        future:
                            context.read<CatalogRepository>().getCategories(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: colors.primaryBlue,
                              ),
                            );
                          }
                          if (snapshot.hasError || !snapshot.hasData) {
                            return Center(
                              child: Text(
                                'Ошибка загрузки категорий',
                                style: TextStyle(color: colors.textSecondary),
                              ),
                            );
                          }
                          final categories = snapshot.data!;
                          return CategoryGridList(
                            categories: categories,
                            onCategorySelected: (category) {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: colors.backgroundPrimary,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(24),
                                    topRight: Radius.circular(24),
                                  ),
                                ),
                                builder:
                                    (_) => ServiceListBottomSheet(
                                      category: category,
                                      selectedServices: _selectedServices,
                                      onServiceSelected:
                                          _handleServiceSelection,
                                    ),
                              );
                            },
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SelectedServicesBottomBar(
        items:
            _selectedServices
                .map(
                  (s) => BottomBarItemData(
                    id: s.name,
                    name: s.name,
                    price: s.price,
                  ),
                )
                .toList(),
        onProceed: _navigateToBooking,
        onRemoveItem: (id) {
          setState(() {
            _selectedServices.removeWhere((s) => s.name == id);
          });
        },
      ),
    );
  }
}
