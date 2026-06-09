import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/feature/core/mastercalendarscreen/master_calendar_body.dart';
import 'package:salon_flutter/feature/core/mastercalendarscreen/sections/calendar_header_section.dart';
import '../../../uikit/colors/app_colors.dart';
import '../../auth/authblock/bloc/auth_block.dart';
import '../../auth/authblock/bloc/auth_state.dart';
import 'bloc/master_calendar_bloc.dart';
import 'bloc/master_calendar_event.dart';
import 'domain/master_calendar_repository.dart';

class MasterCalendarScreen extends StatelessWidget {
  const MasterCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        if (authState is! AuthSuccess) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final masterName = authState.user.masterName;

        return BlocProvider(
          key: ValueKey('master_calendar_$masterName'),
          create: (_) => MasterCalendarBloc(context.read<MasterCalendarRepository>())
            ..add(FetchTodayAppointments(masterName)),
          child: Scaffold(
            backgroundColor: AppColors.primaryWhite,
            appBar: CalendarHeaderSection(selectedDate: DateTime.now()),
            body: const MasterCalendarBody(),

            // ✅ Кнопка обновления
            floatingActionButton: FloatingActionButton.small(
              onPressed: () {
                final auth = context.read<AuthBloc>().state;
                if (auth is AuthSuccess) {
                  context.read<MasterCalendarBloc>().add(
                    FetchTodayAppointments(auth.user.masterName),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Обновлено"),
                      duration: Duration(seconds: 1),
                      backgroundColor: AppColors.primaryBlue,
                    ),
                  );
                }
              },
              backgroundColor: AppColors.lightBlue,
              child: const Icon(Icons.refresh, color: AppColors.primaryWhite),
            ),
          ),
        );
      },
    );
  }
}