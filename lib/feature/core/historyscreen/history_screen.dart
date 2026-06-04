import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../uikit/colors/app_colors.dart';
import '../../../../uikit/strings/app_strings.dart';
import '../../checkout/domain/booking_entity.dart';
import '../../checkout/domain/repository/booking_repository.dart';
import 'history_body.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<BookingEntity>> _historyFuture;

  @override
  void initState() {
    super.initState();
    // Инициируем загрузку через отдельный асинхронный метод
    final bookingRepository = context.read<BookingRepository>();
    _historyFuture = bookingRepository.fetchBookingHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      appBar: AppBar(
        title: const Text(
          AppStrings.serviceHistory,
          style: TextStyle(
            color: AppColors.primaryBlack,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primaryWhite,
        elevation: 0,
        centerTitle: true,
      ),
      body: FutureBuilder<List<BookingEntity>>(
        future: _historyFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryBlue),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Ошибка: ${snapshot.error}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.primaryRed,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          } else {
            final data = snapshot.data ?? [];

            return HistoryBody(
              allBookings: data,
              onRefresh: () async {
                setState(() {
                  // Перезапускаем Future запрос к бэкенду
                  _historyFuture =
                      context.read<BookingRepository>().fetchBookingHistory();
                });
                // Ждем завершения запроса, чтобы крутилка (индикатор) пропала вовремя
                await _historyFuture;
              },
            );
          }
        },
      ),
    );
  }
}
