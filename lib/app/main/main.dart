import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:salon_flutter/feature/auth/splashscreen/splash_screen.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../feature/auth/fakeauth/bloc/auth_block.dart';
import '../../feature/auth/fakeauth/data/datasources/auth_remote_data_source.dart';
import '../../feature/auth/fakeauth/data/repositories/auth_repository_impl.dart';
import '../../feature/auth/fakeauth/domain/repositories/auth_repository.dart';
import '../../feature/catalog/bloc/catalog_bloc.dart';
import '../../feature/catalog/data/datasources/catalog_remote_data_source.dart';
import '../../feature/catalog/data/repositories/catalog_repository_impl.dart';
import '../../feature/catalog/domain/repositories/catalog_repository.dart';
import '../../feature/core/network/auth_interceptor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('ru', null);

  // 1. Создаем инфраструктурные зависимости
  final dio = Dio();
  const secureStorage = FlutterSecureStorage();

  // Добавляем наш новенький перехватчик в Dio!
  dio.interceptors.add(AuthInterceptor(secureStorage: secureStorage));

  // 2. Инициализируем слои данных по Clean Architecture
  final authRemoteDataSource = AuthRemoteDataSourceImpl(dio: dio);
  final authRepository = AuthRepositoryImpl(
    remoteDataSource: authRemoteDataSource,
    secureStorage: secureStorage,
  );

  // Инициализируем новые слои каталога
  final catalogRemoteDataSource = CatalogRemoteDataSourceImpl(dio: dio);
  final catalogRepository = CatalogRepositoryImpl(remoteDataSource: catalogRemoteDataSource);

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>.value(value: authRepository),
        RepositoryProvider<CatalogRepository>.value(value: catalogRepository), // Новый репозиторий
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(authRepository: authRepository),
          ),
          BlocProvider<CatalogBloc>(
            // Новый БЛок, который сразу готов к работе
            create: (context) => CatalogBloc(catalogRepository: catalogRepository),
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
