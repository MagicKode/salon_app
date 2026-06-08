import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/booking_service_screen.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/appbar/app_bar_section.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/bookingbutton/home_booking_button_section.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/description/description_section.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/feedback/bloc/review_bloc.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/feedback/bloc/review_event.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/feedback/bloc/review_state.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/feedback/feedback_section.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/gallery/sections/gallery_section.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/salonheadersection/salon_header_section.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/searchbar/home_search-bar.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/servicesgrid/service_grid_section.dart';
import 'package:salon_flutter/feature/core/homepagescreen/sections/specialists/sections/specialists_section.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../catalog/bloc/catalog_bloc.dart';
import '../../catalog/bloc/catalog_event.dart';
import '../../catalog/bloc/catalog_state.dart';
import '../catalogscreen/catalog_screen.dart';
import '../catalogscreen/domain/catalog_service.dart';
import '../nearbymapscreen/nearby_map_screen.dart';

class HomePageBody extends StatelessWidget {
  final bool isMaster;
  final Function(CatalogService service)? onQuickBookRequested;

  const HomePageBody({
    super.key,
    required this.isMaster,
    this.onQuickBookRequested,
  });

  // Вынес навигацию в отдельный метод внутри StatelessWidget
  void _navigateToNearbyMap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NearbyMapScreen()),
    );
  }

  void _onBookingTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingServiceScreen(selectedServices: const []),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<CatalogBloc>().add(CatalogFetchRequested());
    context.read<ReviewBloc>().add(ReviewFetchRequested(1));

    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      appBar: AppBarSection(isMaster: isMaster),
      body: SafeArea(
        child: BlocBuilder<CatalogBloc, CatalogState>(
          builder: (context, state) {
            // 1. СОСТОЯНИЕ ЗАГРУЗКИ: Показываем красивый индикатор, пока идет запрос
            if (state is CatalogLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primaryBlue),
              );
            }
            // 2. ОШИБКА: Если бэк упал или токен просрочен, выводим ошибку с кнопкой повтора
            if (state is CatalogFailure) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.errorMessage,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColors.primaryRed,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          context.read<CatalogBloc>().add(
                            CatalogFetchRequested(),
                          );
                        },
                        child: const Text(AppStrings.tryAgain),
                      ),
                    ],
                  ),
                ),
              );
            }

            // 3. УСПЕХ: Данные получены, рендерим весь интерфейс
            if (state is CatalogSuccess) {
              final salon = state.salon;

              // Идея с кастомным или дефолтным названием студии:
              final displaySalonName =
                  salon.name.isEmpty || salon.name == "Дмитрий"
                      ? "Студия Павла Ярошенко"
                      : salon.name;

              return SingleChildScrollView(
                padding: EdgeInsets.only(bottom: isMaster ? 20 : 80),
                child: Column(
                  children: [
                    if (!isMaster)
                      HomeSearchBar(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CatalogScreen(),
                            ),
                          );
                        },
                      ),

                    // НОВЫЙ БЛОК: Визитка салона (теперь она НАВЕРХУ!)
                    SalonHeaderSection(
                      name: displaySalonName,
                      address: salon.address,
                      workingHours: salon.workingHours,
                      onLocationTap: () => _navigateToNearbyMap(context),
                    ),

                    const SizedBox(height: 16),

                    ServiceGridSection(
                      isMaster: isMaster,
                      onQuickBookRequested: isMaster ? null : onQuickBookRequested,
                    ),

                    const SizedBox(height: 16),

                    // Передаем реальные данные с бэкенда в секцию описания!
                    DescriptionSection(description: salon.description),

                    const SizedBox(height: 16),

                    const GallerySection(),

                    const SizedBox(height: 16),

                    const SpecialistsSection(),

                    const SizedBox(height: 20),

                    BlocBuilder<ReviewBloc, ReviewState>(
                      builder: (context, reviewState) {
                        if (reviewState is ReviewLoading ||
                            reviewState is ReviewInitial) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.0),
                              child: CircularProgressIndicator(
                                color: AppColors.primaryBlue,
                              ),
                            ),
                          );
                        }
                        if (reviewState is ReviewSuccess) {
                          return FeedbackSection(
                            stats: reviewState.stats,
                            reviews: reviewState.reviews,
                            isMaster: isMaster,
                          );
                        }
                        if (reviewState is ReviewFailure) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 10.0,
                            ),
                            child: Text(
                              "Не удалось загрузить отзывы: ${reviewState.errorMessage}",
                              style: const TextStyle(
                                color: AppColors.primaryRed,
                                fontSize: 12,
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              );
            }
            // Дефолтный пустой контейнер на случай непредвиденного стейта
            return const SizedBox.shrink();
          },
        ),
      ),

      // ВЫЗОВ СЕКЦИИ КНОПКИ бронирования
      floatingActionButton:
          isMaster
              ? null
              : BlocBuilder<CatalogBloc, CatalogState>(
                builder: (context, state) {
                  if (state is CatalogSuccess) {
                    return HomeBookingButtonSection(
                      key: const ValueKey('persistent_booking_button'),
                      onPressed: () => _onBookingTap(context),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
