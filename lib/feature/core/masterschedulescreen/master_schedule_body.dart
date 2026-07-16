import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';
import '../../../config/theme/custom_colors.dart';
import '../../../uikit/widgets/card/calendar_view_card.dart';
import '../../../uikit/widgets/card/daysummery/day_summary_card.dart';
import '../../auth/authblock/bloc/auth_block.dart';
import '../../auth/authblock/bloc/auth_state.dart';
import 'bloc/master_schedule_bloc.dart';
import 'bloc/master_schedule_event.dart';
import 'bloc/master_schedule_state.dart';
import 'domain/day_availability_model.dart';

class MasterScheduleBody extends StatelessWidget {
  const MasterScheduleBody({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return BlocBuilder<MasterScheduleBloc, MasterScheduleState>(
      builder: (context, state) {
        if (state is MasterScheduleLoading) {
          return Center(
            child: CircularProgressIndicator(color: colors.primaryBlue),
          );
        }

        if (state is MasterScheduleFailure) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 48, color: colors.statusError),
                  const SizedBox(height: 16),
                  Text(
                    state.errorMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: colors.statusError, fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      final auth = context.read<AuthBloc>().state;
                      if (auth is AuthSuccess) {
                        context.read<MasterScheduleBloc>().add(
                          LoadScheduleMonth(
                            masterName: auth.user.masterName,
                            month: DateTime.now(),
                          ),
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

        if (state is MasterScheduleSuccess) {
          final availabilityMap = <DateTime, DayStatus>{
            for (var item in state.availability)
              DateTime.utc(
                DateTime.parse(item.date).year,
                DateTime.parse(item.date).month,
                DateTime.parse(item.date).day,
              ): item.status,
          };

          // ✅ Календарь и легенда – статическая верхняя часть
          final calendarWidget = Column(
            children: [
              CalendarViewCard(
                focusedDay: state.selectedDay,
                onDaySelected: (day) {
                  final auth = context.read<AuthBloc>().state;
                  if (auth is AuthSuccess) {
                    context.read<MasterScheduleBloc>().add(
                      ChangeSelectedDay(auth.user.masterName, day),
                    );
                  }
                },
                availability: availabilityMap,
              ),
              _buildLegend(colors),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Divider(color: colors.borderLight),
              ),
            ],
          );

          // ✅ Заявки – скроллится только этот блок
          final appointmentsWidget = DaySummaryCard(
            appointments: state.selectedDayAppointments,
            selectedDate: state.selectedDay,
            availability: availabilityMap,
            onRefresh: () {
              final auth = context.read<AuthBloc>().state;
              if (auth is AuthSuccess) {
                context.read<MasterScheduleBloc>().add(
                  LoadScheduleMonth(
                    masterName: auth.user.masterName,
                    month: state.selectedDay,
                  ),
                );
              }
            },
          );

          // 📏 Вычисляем высоту экрана для корректного скролла
          final screenHeight = MediaQuery.of(context).size.height;
          final appBarHeight = kToolbarHeight + MediaQuery.of(context).padding.top;
          final calendarHeight = 350.0; // высота календаря + легенда

          return RefreshIndicator(
            color: colors.primaryBlue,
            onRefresh: () async {
              final auth = context.read<AuthBloc>().state;
              if (auth is AuthSuccess) {
                context.read<MasterScheduleBloc>().add(
                  LoadScheduleMonth(
                    masterName: auth.user.masterName,
                    month: state.selectedDay,
                  ),
                );
              }
            },
            child: Container(
              height: screenHeight - appBarHeight - 10, // ✅ фиксированная высота для Column
              child: Column(
                children: [
                  calendarWidget,
                  Expanded(
                    child: appointmentsWidget, // ✅ занимает всё оставшееся место
                  ),
                ],
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildLegend(CustomColors colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _legendItem(colors, colors.textSecondary, AppStrings.dayIsFull),
          const SizedBox(width: 16),
          _legendItem(colors, colors.primaryBlue, AppStrings.chosenDay),
          const SizedBox(width: 16),
          _legendItem(colors, colors.statusError, AppStrings.weekend),
        ],
      ),
    );
  }

  Widget _legendItem(CustomColors colors, Color color, String text) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            fontSize: 10,
            color: colors.textSecondary,
          ),
        ),
      ],
    );
  }
}
