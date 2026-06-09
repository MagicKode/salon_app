import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';
import '../../../uikit/colors/app_colors.dart';
import '../../../uikit/widgets/card/master_appointment_card.dart';
import '../../auth/authblock/bloc/auth_block.dart';
import '../../auth/authblock/bloc/auth_state.dart';
import 'bloc/master_calendar_bloc.dart';
import 'bloc/master_calendar_event.dart';
import 'bloc/master_calendar_state.dart';

class MasterCalendarBody extends StatefulWidget  {
  const MasterCalendarBody({super.key});

  @override
  State<MasterCalendarBody> createState() => _MasterCalendarBodyState();
}

class _MasterCalendarBodyState extends State<MasterCalendarBody> {

  @override
  void initState() {
    super.initState();
    // ✅ Автообновление при возврате на экран
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshData();
    });
  }

  void _refreshData() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccess) {
      context.read<MasterCalendarBloc>().add(
        FetchTodayAppointments(authState.user.masterName),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MasterCalendarBloc, MasterCalendarState>(
      builder: (context, state) {
        if (state is MasterCalendarLoading) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primaryBlue));
        }

        if (state is MasterCalendarFailure) {
          return _buildError(context, state.errorMessage);
        }

        if (state is MasterCalendarSuccess) {
          if (state.dailySchedule.bookings.isEmpty) {
            return _buildEmpty();
          }

          return ListView.builder(
            padding: const EdgeInsets.only(top: 12, bottom: 20),
            itemCount: state.dailySchedule.bookings.length,
            itemBuilder: (context, index) {
              return MasterAppointmentCard(
                appointment: state.dailySchedule.bookings[index],
                onDelete: () => _deleteAppointment(context, state.dailySchedule.bookings[index].id),
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildError(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppColors.primaryRed),
            const SizedBox(height: 16),
            Text(message, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.primaryRed, fontSize: 16)),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                final auth = context.read<AuthBloc>().state;
                if (auth is AuthSuccess) {
                  context.read<MasterCalendarBloc>().add(FetchTodayAppointments(auth.user.masterName));
                }
              },
              icon: const Icon(Icons.refresh),
              label: const Text("Повторить"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.coffee, size: 120, color: AppColors.primaryGrey.withOpacity(0.5)),
          const SizedBox(height: 16),
          const Text(AppStrings.noClientsForToday, style: TextStyle(fontSize: 16, color: AppColors.dateGrey)),
        ],
      ),
    );
  }

  void _deleteAppointment(BuildContext context, String id) {
    final auth = context.read<AuthBloc>().state;
    if (auth is AuthSuccess) {
      context.read<MasterCalendarBloc>().add(CancelAppointmentRequested(auth.user.masterName, appointmentId: id));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Запись отменена"), backgroundColor: AppColors.primaryRed),
      );
    }
  }
}
