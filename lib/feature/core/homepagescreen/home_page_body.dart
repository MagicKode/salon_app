import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart'; // ✅ добавлен импорт
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
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../config/theme/custom_colors.dart';
import '../../../uikit/colors/app_colors.dart';
import '../../../uikit/widgets/errors/loading_widget.dart';
import '../../../uikit/widgets/errors/network_error_widget.dart';
import '../../catalog/bloc/catalog_bloc.dart';
import '../../catalog/bloc/catalog_event.dart';
import '../../catalog/bloc/catalog_state.dart';
import '../catalogscreen/catalog_screen.dart';
import '../catalogscreen/domain/catalog_service.dart';
import '../nearbymapscreen/nearby_map_screen.dart';

class HomePageBody extends StatefulWidget {
  final bool isMaster;
  final Function(CatalogService service)? onQuickBookRequested;

  const HomePageBody({
    super.key,
    required this.isMaster,
    this.onQuickBookRequested,
  });

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  final ScrollController _scrollController = ScrollController();
  int _servicesRefreshCounter = 0;

  void _refreshServices() {
    setState(() {
      _servicesRefreshCounter++;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _navigateToNearbyMap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const NearbyMapScreen()),
    );
  }

  void _onBookingTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BookingServiceScreen(selectedServices: const []),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    final catalogState = context.read<CatalogBloc>().state;
    if (catalogState is! CatalogSuccess) {
      context.read<CatalogBloc>().add(CatalogFetchRequested());
    }

    final reviewState = context.read<ReviewBloc>().state;
    if (reviewState is! ReviewSuccess) {
      context.read<ReviewBloc>().add(ReviewFetchRequested(1));
    }

    return Scaffold(
      backgroundColor: colors.backgroundPrimary,
      appBar: AppBarSection(isMaster: widget.isMaster),
      body: SafeArea(
        child: BlocBuilder<CatalogBloc, CatalogState>(
          builder: (context, state) {
            // ✅ Загрузка
            if (state is CatalogLoading) {
              return const LoadingWidget(message: 'Загрузка услуг...');
            }

            // ✅ Ошибка с проверкой интернета
            if (state is CatalogFailure) {
              return FutureBuilder<ConnectivityResult>(
                future: Connectivity().checkConnectivity(),
                builder: (context, snapshot) {
                  final hasInternet = snapshot.data != ConnectivityResult.none;
                  if (!hasInternet) {
                    return NetworkErrorWidget(
                      message: 'Проверьте подключение к интернету',
                      onRetry: () {
                        context.read<CatalogBloc>().add(CatalogFetchRequested());
                      },
                    );
                  }
                  // Если интернет есть, но ошибка — показываем стандартную ошибку
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.errorMessage,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: colors.statusError,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context.read<CatalogBloc>().add(CatalogFetchRequested());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colors.primaryBlue,
                              foregroundColor: colors.textOnPrimary,
                            ),
                            child: const Text(AppStrings.tryAgain),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }

            // ✅ Успех
            if (state is CatalogSuccess) {
              final salon = state.salon;
              final displaySalonName = "Студия Павла Ярошенко";

              return Stack(
                children: [
                  SingleChildScrollView(
                    controller: _scrollController,
                    padding: EdgeInsets.only(
                      bottom: widget.isMaster ? 20 : 100,
                    ),
                    child: Column(
                      children: [
                        if (!widget.isMaster)
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
                        SalonHeaderSection(
                          name: displaySalonName,
                          address: salon.address,
                          workingHours: salon.workingHours,
                          onLocationTap: () => _navigateToNearbyMap(context),
                        ),
                        const SizedBox(height: 16),
                        ServiceGridSection(
                          key: ValueKey(_servicesRefreshCounter),
                          isMaster: widget.isMaster,
                          onQuickBookRequested: widget.isMaster ? null : widget.onQuickBookRequested,
                          onServiceUpdated: _refreshServices,
                        ),
                        const SizedBox(height: 16),
                        DescriptionSection(description: salon.description),
                        const SizedBox(height: 16),
                        GallerySection(isMaster: widget.isMaster),
                        const SizedBox(height: 16),
                        const SpecialistsSection(),
                        const SizedBox(height: 20),
                        BlocBuilder<ReviewBloc, ReviewState>(
                          builder: (context, reviewState) {
                            if (reviewState is ReviewLoading || reviewState is ReviewInitial) {
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
                                isMaster: widget.isMaster,
                              );
                            }
                            if (reviewState is ReviewFailure) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                                child: Text(
                                  "Не удалось загрузить отзывы: ${reviewState.errorMessage}",
                                  style: TextStyle(
                                    color: colors.statusError,
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
                  ),
                  if (!widget.isMaster)
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: HomeBookingButtonSection(
                        key: const ValueKey('persistent_booking_button'),
                        onPressed: () => _onBookingTap(context),
                        scrollController: _scrollController,
                      ),
                    ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
