import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../feature/auth/authblock/bloc/auth_block.dart';
import '../../feature/auth/authblock/bloc/auth_event.dart';
import '../../feature/auth/authblock/data/datasources/auth_remote_data_source.dart';
import '../../feature/auth/authblock/data/repositories/auth_repository_impl.dart';
import '../../feature/auth/authblock/domain/repositories/auth_repository.dart';
import '../../feature/catalog/bloc/catalog_bloc.dart';
import '../../feature/catalog/data/datasources/catalog_remote_data_source.dart';
import '../../feature/catalog/data/repositories/catalog_repository_impl.dart';
import '../../feature/catalog/domain/repositories/catalog_repository.dart';
import '../../feature/checkout/domain/repository/booking_repository.dart';
import '../../feature/core/bookingservicescreen/bookingblock/booking_slots_bloc.dart';
import '../../feature/core/homepagescreen/sections/feedback/bloc/review_bloc.dart';
import '../../feature/core/homepagescreen/sections/feedback/data/review_api_service.dart';
import '../../feature/core/mastercalendarscreen/domain/master_calendar_repository.dart';
import '../../feature/core/masterschedulescreen/domain/master_schedule_repository.dart';
import '../../feature/navigation/app_root_router.dart';

/// Переключай одной кнопкой: true — для эмулятора, false — для смартфона
// const bool isEmulator = false;
const bool isEmulator = true;

// Определяем базовый IP и порты для сервисов
const String _host = isEmulator ? '10.0.2.2' : '192.168.1.223';
const String authBaseUrl = 'http://$_host:8082/api/v1/auth';
const String catalogBaseUrl = 'http://$_host:8081/api/v1/catalog/salon';
const String bookingBaseUrl = 'http://$_host:8083/api/v1/bookings';
const String masterScheduleBaseUrl = 'http://$_host:8083/api/v1/master/schedule';
const String historyBaseUrl = 'http://$_host:8084/api/v1/history';
const String reviewBaseUrl = 'http://$_host:8086/api/v1/reviews';
const String clientBaseUrl = 'http://$_host:8082/api/v1/clients';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ru', null);

  // Auth
  final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  );
  dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  const secureStorage = FlutterSecureStorage();

  // Auth
  final authRemoteDataSource = AuthRemoteDataSourceImpl(
    dio: dio,
    baseUrl: authBaseUrl,
  );
  final authRepository = AuthRepositoryImpl(
    remoteDataSource: authRemoteDataSource,
    secureStorage: secureStorage,
  );

  // Catalog
  final catalogRemoteDataSource = CatalogRemoteDataSourceImpl(
    dio: dio,
    baseUrl: catalogBaseUrl,
  );
  final catalogRepository = CatalogRepositoryImpl(
    remoteDataSource: catalogRemoteDataSource,
  );

  // Booking
  final bookingRepository = BookingRepository(
    dio: dio,
    baseUrl: bookingBaseUrl,
    historyUrl: historyBaseUrl,
    secureStorage: const FlutterSecureStorage(),
  );

  // Review
  final reviewApiService = ReviewApiService(dio: dio, baseUrl: reviewBaseUrl);

  final masterCalendarRepo = MasterCalendarRepository(
    dio: dio,
    scheduleBaseUrl: masterScheduleBaseUrl,
    bookingBaseUrl: bookingBaseUrl,
    clientBaseUrl: clientBaseUrl,
  );

  final masterScheduleRepo = MasterScheduleRepository(
    dio: dio,
    scheduleBaseUrl: masterScheduleBaseUrl,
  );

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>.value(value: authRepository),
        RepositoryProvider<CatalogRepository>.value(value: catalogRepository),
        RepositoryProvider<BookingRepository>.value(value: bookingRepository),
        RepositoryProvider<ReviewApiService>.value(value: reviewApiService),
        RepositoryProvider<MasterScheduleRepository>.value(value: masterScheduleRepo),
        RepositoryProvider<MasterCalendarRepository>.value(value: masterCalendarRepo),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create:
                (context) =>
                    AuthBloc(authRepository: authRepository)
                      ..add(AuthCheckStatusRequested()),
          ),
          BlocProvider<CatalogBloc>(
            create:
                (context) => CatalogBloc(catalogRepository: catalogRepository),
          ),
          BlocProvider<BookingSlotsBloc>(
            create:
                (context) => BookingSlotsBloc(
                  bookingRepository: RepositoryProvider.of<BookingRepository>(
                    context,
                  ),
                ),
          ),
          BlocProvider<ReviewBloc>(
            create: (context) => ReviewBloc(RepositoryProvider.of<ReviewApiService>(context)),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryBlue),
        scaffoldBackgroundColor: AppColors.primaryWhite,
        useMaterial3: true,
        fontFamily: 'Montserrat',
      ),
      home: const AppRootRouter(),
    );
  }
}
