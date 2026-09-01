import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/theme/custom_colors.dart';
import '../../auth/authblock/bloc/auth_block.dart';
import '../../auth/authblock/bloc/auth_state.dart';
import 'bloc/master_schedule_bloc.dart';
import 'bloc/master_schedule_event.dart';
import 'bloc/master_schedule_state.dart';
import 'domain/master_schedule_repository.dart';
import 'master_schedule_body.dart';
import 'sections/schedule_header_section.dart';

class MasterScheduleScreen extends StatelessWidget {
  const MasterScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        if (authState is! AuthSuccess) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final masterName = authState.user.masterName;

        return BlocProvider(
          create: (_) => MasterScheduleBloc(
            context.read<MasterScheduleRepository>(),
          ),
          child: Builder(
            builder: (context) {
              return Scaffold(
                backgroundColor: colors.backgroundPrimary,
                appBar: const ScheduleHeaderSection(),
                body: const MasterScheduleBody(),
                floatingActionButton: FloatingActionButton.small(
                  heroTag: 'master_schedule_refresh_btn', // ✅ Уникальный тег
                  onPressed: () {
                    final bloc = context.read<MasterScheduleBloc>();
                    final state = bloc.state;

                    DateTime currentDate;
                    if (state is MasterScheduleSuccess) {
                      currentDate = state.selectedDay;
                    } else if (state is MasterScheduleLoading) {
                      currentDate = state.selectedDate;
                    } else {
                      currentDate = DateTime.now();
                    }

                    bloc.add(LoadScheduleMonth(
                      masterName: masterName,
                      month: currentDate,
                    ));

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('🔄 Обновление расписания...'),
                        backgroundColor: colors.primaryBlue,
                        duration: const Duration(milliseconds: 800),
                      ),
                    );
                  },
                  backgroundColor: colors.primaryBlue,
                  child: Icon(
                    Icons.refresh,
                    color: colors.textOnPrimary,
                    size: 22,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
