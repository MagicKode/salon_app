import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/feature/core/masterschedulescreen/sections/schedule_header_section.dart';

import '../../../config/theme/custom_colors.dart';
import '../../auth/authblock/bloc/auth_block.dart';
import '../../auth/authblock/bloc/auth_state.dart';
import 'bloc/master_schedule_bloc.dart';
import 'bloc/master_schedule_event.dart';
import 'domain/master_schedule_repository.dart';
import 'master_schedule_body.dart';

class MasterScheduleScreen extends StatelessWidget {
  const MasterScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Получаем динамические цвета
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
          create:
              (_) =>
                  MasterScheduleBloc(context.read<MasterScheduleRepository>())
                    ..add(
                      LoadScheduleMonth(
                        masterName: masterName,
                        month: DateTime.now(),
                      ),
                    ),
          child: Scaffold(
            backgroundColor: colors.backgroundPrimary,
            appBar: const ScheduleHeaderSection(),
            body: const MasterScheduleBody(),
          ),
        );
      },
    );
  }
}
