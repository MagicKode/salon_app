import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/feature/core/mastercalendarscreen/master_calendar_body.dart';
import 'package:salon_flutter/feature/core/mastercalendarscreen/sections/calendar_header_section.dart';

import '../../../config/theme/custom_colors.dart'; // ✅ динамические цвета
import '../../auth/authblock/bloc/auth_block.dart';
import '../../auth/authblock/bloc/auth_state.dart';
import 'bloc/master_calendar_bloc.dart';
import 'bloc/master_calendar_event.dart';
import 'domain/master_calendar_repository.dart';

class MasterCalendarScreen extends StatelessWidget {
  const MasterCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем динамические цвета
    final colors = Theme.of(context).extension<CustomColors>()!;

    return BlocProvider(
      create:
          (_) => MasterCalendarBloc(context.read<MasterCalendarRepository>()),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          if (authState is! AuthSuccess) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final masterName = authState.user.masterName;

          context.read<MasterCalendarBloc>().add(
            FetchTodayAppointments(masterName),
          );

          return Scaffold(
            backgroundColor: colors.backgroundPrimary, // ✅ динамический фон
            appBar: CalendarHeaderSection(selectedDate: DateTime.now()),
            body: const MasterCalendarBody(),
            floatingActionButton: FloatingActionButton.small(
              onPressed: () {
                final auth = context.read<AuthBloc>().state;
                if (auth is AuthSuccess) {
                  context.read<MasterCalendarBloc>().add(
                    FetchTodayAppointments(auth.user.masterName),
                  );
                }
              },
              backgroundColor: colors.primaryBlue, // ✅ динамический синий
              child: Icon(
                Icons.refresh,
                color: colors.textOnPrimary, // ✅ динамический белый
              ),
            ),
          );
        },
      ),
    );
  }
}
