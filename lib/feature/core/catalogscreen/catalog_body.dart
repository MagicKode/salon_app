import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/booking_service_screen.dart';
import 'package:salon_flutter/feature/core/catalogscreen/sections/catalog_search_bar.dart';
import 'package:salon_flutter/feature/core/catalogscreen/sections/category_grid_list.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../uikit/colors/app_colors.dart';
import 'domain/bottom_bar_item_data.dart';
import 'domain/catalog_category.dart';
import 'domain/catalog_service.dart';
import 'domain/mock_catalog_data.dart';
import 'domain/selected_services_bottom_bar.dart';

class CatalogBody extends StatefulWidget {
  const CatalogBody({super.key});

  @override
  State<CatalogBody> createState() => _CatalogBodyState();
}

class _CatalogBodyState extends State<CatalogBody> {
  final List<CatalogService> _selectedServices = [];

  // Контроллер для поиска
  final TextEditingController _searchController = TextEditingController();

  // Список отфильтрованных услуг
  List<CatalogService> _filteredServices = [];
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

  // Логика фильтрации «на лету»
  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase().trim();

    setState(() {
      if (query.isEmpty) {
        _isSearching = false;
        _filteredServices = [];
      } else {
        _isSearching = true;

        // Плоский список: собираем ВСЕ услуги из всех категорий и фильтруем по имени
        _filteredServices =
            MockCatalogData.categories
                .expand((category) => category.services)
                .where((service) => service.name.toLowerCase().contains(query))
                .toList();
      }
    });
  }

  // Логика переключения выбора услуги (добавить/удалить из корзины)
  void _handleServiceSelection(CatalogService service) {
    setState(() {
      if (_selectedServices.contains(service)) {
        _selectedServices.remove(service); // Если уже выбрана — убираем
      } else {
        _selectedServices.add(service); // Если нет — добавляем в список
      }
    });
  }

  void _navigateToBooking() {
    // Переход на готовый экран бронирования (image_3fba3c.png)
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BookingServiceScreen()),
    );
  }

  // Метод рендеринга результатов интерактивного поиска
  Widget _buildSearchResultsList() {
    if (_filteredServices.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 48,
              color: AppColors.primaryGrey,
            ),
            SizedBox(height: 12),
            Text(
              'Ничего не найдено\nПопробуйте изменить запрос',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.primaryGrey, fontSize: 14),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: _filteredServices.length,
      separatorBuilder:
          (context, index) => const Divider(height: 1, thickness: 0.5),
      itemBuilder: (context, index) {
        final service = _filteredServices[index];
        final isSelected = _selectedServices.contains(service);

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryBlack,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '1 ч.',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.primaryGrey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${service.price.toStringAsFixed(0)} BYN',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlack,
                    ),
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    height: 32,
                    child: ElevatedButton(
                      onPressed: () => _handleServiceSelection(service),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isSelected
                                ? Colors.grey.shade200
                                : AppColors.primaryBlue,
                        foregroundColor:
                            isSelected
                                ? AppColors.primaryBlack
                                : AppColors.primaryWhite,
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
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showServicesBottomSheet(
    BuildContext context,
    CatalogCategory category,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.primaryWhite,
      isScrollControlled: true,
      // Позволяет шторке адаптироваться под высоту контента
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      builder: (context) {
        // Ограничиваем шторку по высоте, чтобы она не перекрывала весь экран до самого верха
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          // При открытии занимает 60% экрана
          minChildSize: 0.4,
          // Минимально можно сжать до 40%
          maxChildSize: 0.85,
          // Максимально можно растянуть до 85%
          expand: false,
          builder: (context, scrollController) {
            // Используем StatefulBuilder, чтобы кнопка «Выбрать/Удалить»
            // меняла свое состояние (цвет) прямо внутри открытой шторки
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setSheetState) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Аккуратная полосочка-индикатор для свайпа вниз
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 12, bottom: 16),
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),

                      // Заголовок категории (например: Женский зал)
                      Text(
                        category.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryBlack,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Список услуг категории
                      Expanded(
                        child: ListView.separated(
                          controller: scrollController,
                          // Передаем контроллер для плавного скролла
                          itemCount: category.services.length,
                          separatorBuilder:
                              (context, index) =>
                                  const Divider(height: 1, thickness: 0.5),
                          itemBuilder: (context, index) {
                            final service = category.services[index];
                            final isSelected = _selectedServices.contains(
                              service,
                            );

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Название и длительность услуги
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          service.name,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.primaryBlack,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        const Text(
                                          '1 ч. • Мастер-универсал',
                                          // Тут в будущем будут динамические данные
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(width: 16),

                                  // Цена и интерактивная кнопка «Выбрать»
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '${service.price.toStringAsFixed(0)} BYN',
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primaryBlack,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      SizedBox(
                                        height: 32,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            // 1. Обновляем главный стейт CatalogBody (чтобы пересчитался нижний главный бар)
                                            _handleServiceSelection(service);
                                            // 2. Обновляем локальный стейт шторки (чтобы кнопка визуально изменилась)
                                            setSheetState(() {});
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                isSelected
                                                    ? Colors.grey.shade200
                                                    : AppColors.primaryBlue,
                                            foregroundColor:
                                                isSelected
                                                    ? AppColors.primaryBlack
                                                    : AppColors.primaryWhite,
                                            elevation: 0,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
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
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      // Добавляем AppBar прямо внутрь боди, чтобы экран каталога имел кнопку возврата
      appBar: AppBar(
        backgroundColor: AppColors.primaryWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.primaryBlack,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          AppStrings.servicesCatalogTitle,
          style: TextStyle(
            color: AppColors.primaryBlack,
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

            // Секция раскрывающегося списка категорий
            Expanded(
              child: _isSearching
              ? _buildSearchResultsList()
              : CategoryGridList(
                categories: MockCatalogData.categories,
                onCategorySelected: (category) {
                  _showServicesBottomSheet(context, category);
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
                  (service) => BottomBarItemData(
                    id: service.name,
                    name: service.name,
                    price: service.price,
                  ),
                )
                .toList(),
        onProceed: _navigateToBooking,
        onRemoveItem: (id) {
          setState(() {
            _selectedServices.removeWhere((service) => service.name == id);
          });
        },
      ),
    );
  }
}
