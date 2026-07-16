import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../config/theme/custom_colors.dart'; // ✅ импорт динамических цветов
import '../../../uikit/widgets/card/masterappointmentcard/master_appointment_card.dart';
import '../../auth/authblock/bloc/auth_block.dart';
import '../../auth/authblock/bloc/auth_state.dart';
import 'bloc/master_calendar_bloc.dart';
import 'bloc/master_calendar_event.dart';
import 'bloc/master_calendar_state.dart';

class MasterCalendarBody extends StatefulWidget {
  const MasterCalendarBody({super.key});

  @override
  State<MasterCalendarBody> createState() => _MasterCalendarBodyState();
}

class _MasterCalendarBodyState extends State<MasterCalendarBody> {
  @override
  void initState() {
    super.initState();
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
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;

    return BlocBuilder<MasterCalendarBloc, MasterCalendarState>(
      builder: (context, state) {
        if (state is MasterCalendarLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: colors.primaryBlue, // ✅ динамический синий
            ),
          );
        }

        if (state is MasterCalendarFailure) {
          return _buildError(context, colors, state.errorMessage);
        }

        if (state is MasterCalendarSuccess) {
          if (state.dailySchedule.bookings.isEmpty) {
            return _buildEmpty(context, colors);
          }

          return ListView.builder(
            padding: const EdgeInsets.only(top: 12, bottom: 20),
            itemCount: state.dailySchedule.bookings.length,
            itemBuilder: (context, index) {
              return MasterAppointmentCard(
                appointment: state.dailySchedule.bookings[index],
                onDelete:
                    () => _deleteAppointment(
                      context,
                      colors,
                      state.dailySchedule.bookings[index].id,
                    ),
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildError(
    BuildContext context,
    CustomColors colors,
    String message,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: colors.statusError, // ✅ динамический красный
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: colors.statusError, fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                final auth = context.read<AuthBloc>().state;
                if (auth is AuthSuccess) {
                  context.read<MasterCalendarBloc>().add(
                    FetchTodayAppointments(auth.user.masterName),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primaryBlue,
                foregroundColor: colors.textOnPrimary,
              ),
              icon: const Icon(Icons.refresh),
              label: const Text("Повторить"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty(BuildContext context, CustomColors colors) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.coffee,
            size: 120,
            color: colors.textSecondary.withOpacity(
              0.5,
            ), // ✅ полупрозрачный серый
          ),
          const SizedBox(height: 16),
          Text(
            AppStrings.noClientsForToday,
            style: TextStyle(
              fontSize: 16,
              color: colors.textSecondary, // ✅ динамический серый
            ),
          ),
        ],
      ),
    );
  }

  void _deleteAppointment(
    BuildContext context,
    CustomColors colors,
    String id,
  ) {
    final auth = context.read<AuthBloc>().state;
    if (auth is AuthSuccess) {
      context.read<MasterCalendarBloc>().add(
        CancelAppointmentRequested(auth.user.masterName, appointmentId: id),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Запись отменена",
            style: TextStyle(color: colors.textOnPrimary),
          ),
          backgroundColor: colors.statusError, // ✅ динамический красный
        ),
      );
    }
  }
}
