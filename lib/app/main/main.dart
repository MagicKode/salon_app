import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:salon_flutter/feature/auth/splashscreen/splash_screen.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../feature/auth/authblock/bloc/auth_block.dart';
import '../../feature/auth/authblock/data/datasources/auth_remote_data_source.dart';
import '../../feature/auth/authblock/data/repositories/auth_repository_impl.dart';
import '../../feature/auth/authblock/domain/repositories/auth_repository.dart';
import '../../feature/catalog/bloc/catalog_bloc.dart';
import '../../feature/catalog/data/datasources/catalog_remote_data_source.dart';
import '../../feature/catalog/data/repositories/catalog_repository_impl.dart';
import '../../feature/catalog/domain/repositories/catalog_repository.dart';
import '../../feature/checkout/domain/repository/booking_repository.dart';
import '../../feature/core/bookingservicescreen/bookingblock/booking_slots_bloc.dart';
import '../../feature/core/network/auth_interceptor.dart';

// Переключай одной кнопкой: true — для эмулятора, false — для смартфона
const bool isEmulator = false;

// Определяем базовый IP и порты для сервисов
const String _host = isEmulator ? '10.0.2.2' : '192.168.1.223';
const String authBaseUrl = 'http://$_host:8082/api/v1/auth';
const String catalogBaseUrl = 'http://$_host:8080/api/v1/catalog/salon';
const String bookingBaseUrl = 'http://$_host:8083/api/v1/bookings';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('ru', null);

  // 1. Создаем инфраструктурные зависимости
  final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 5), // Запрос упадет через 5 сек, если сервер недоступен
      receiveTimeout: const Duration(seconds: 5),
    ),
  );
  dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  const secureStorage = FlutterSecureStorage();

  // Добавляем наш новенький перехватчик в Dio!
  dio.interceptors.add(AuthInterceptor(secureStorage: secureStorage));

  // 2. Инициализируем слои данных по Clean Architecture
  final authRemoteDataSource = AuthRemoteDataSourceImpl(
    dio: dio,
    baseUrl: authBaseUrl,
  );
  final authRepository = AuthRepositoryImpl(
    remoteDataSource: authRemoteDataSource,
    secureStorage: secureStorage,
  );

  // Инициализируем новые слои каталога
  final catalogRemoteDataSource = CatalogRemoteDataSourceImpl(
    dio: dio,
    baseUrl: catalogBaseUrl,
  );
  final catalogRepository = CatalogRepositoryImpl(
    remoteDataSource: catalogRemoteDataSource,
  );
  final bookingRepository = BookingRepository(dio: dio, baseUrl: bookingBaseUrl);

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>.value(value: authRepository),
        RepositoryProvider<CatalogRepository>.value(value: catalogRepository),
        RepositoryProvider<BookingRepository>.value(value: bookingRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(authRepository: authRepository),
          ),
          BlocProvider<CatalogBloc>(
            create: (context) => CatalogBloc(catalogRepository: catalogRepository),
          ),
          BlocProvider<BookingSlotsBloc>(
            create: (context) => BookingSlotsBloc(
              bookingRepository: RepositoryProvider.of<BookingRepository>(context),
            ),
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
      home: const SplashScreen(),
    );
  }
}
