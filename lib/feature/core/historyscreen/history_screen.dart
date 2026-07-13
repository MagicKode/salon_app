import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/feature/core/historyscreen/history_body.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';
import '../../checkout/domain/booking_entity.dart';
import '../../checkout/domain/repository/booking_repository.dart';
import 'domain/hidden_history_service.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<BookingEntity>> _activeFuture;
  late Future<List<BookingEntity>> _pastFuture;
  final HiddenHistoryService _hiddenService = HiddenHistoryService();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  void _loadData() {
    final repo = context.read<BookingRepository>();
    _activeFuture = repo.fetchActiveBookings().then((bookings) async {
      final hiddenIds = await _hiddenService.getHiddenIds();
      return bookings.where((b) => !hiddenIds.contains(b.id)).toList();
    });
    _pastFuture = repo.fetchPastBookings().then((bookings) async {
      final hiddenIds = await _hiddenService.getHiddenIds();
      return bookings.where((b) => !hiddenIds.contains(b.id)).toList();
    });
    setState(() {});
  }

  Future<void> _refresh() async {
    setState(() {
      _loadData();
    });
    await Future.wait([_activeFuture, _pastFuture]);
  }

  Future<void> _hideBooking(int id) async {
    await _hiddenService.hideBooking(id);
    await _refresh();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      appBar: AppBar(
        title: const Text(
          AppStrings.serviceHistory,
          style: TextStyle(color: AppColors.primaryBlack, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primaryWhite,
        elevation: 0,
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primaryBlue,
          labelColor: AppColors.primaryBlue,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: AppStrings.activeBookings),
            Tab(text: AppStrings.pastBooking),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Вкладка "Актуальные" – свайп-удаление отключено
          _buildTabContent(_activeFuture, enableDelete: false),
          // Вкладка "Прошедшие" – свайп-удаление включено
          _buildTabContent(_pastFuture, enableDelete: true),
        ],
      ),
    );
  }

  Widget _buildTabContent(Future<List<BookingEntity>> future, {required bool enableDelete}) {
    return FutureBuilder<List<BookingEntity>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primaryBlue));
        } else if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Ошибка: ${snapshot.error}",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
          );
        } else {
          final bookings = snapshot.data ?? [];
          return HistoryBody(
            bookings: bookings,
            onRefresh: _refresh,
            onDelete: _hideBooking,
            enableDelete: enableDelete,
          );
        }
      },
    );
  }
}
