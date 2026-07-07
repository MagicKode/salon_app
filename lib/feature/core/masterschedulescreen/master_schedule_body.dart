import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';
import '../../../uikit/colors/app_colors.dart';
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
    return BlocBuilder<MasterScheduleBloc, MasterScheduleState>(
      builder: (context, state) {
        if (state is MasterScheduleLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryBlue),
          );
        }

        if (state is MasterScheduleFailure) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: AppColors.primaryRed),
                  const SizedBox(height: 16),
                  Text(state.errorMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.primaryRed, fontSize: 16),
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

          return RefreshIndicator(
            color: AppColors.primaryBlue,
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
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                // Календарь – фиксированная часть (не скроллится)
                SliverToBoxAdapter(
                  child: Column(
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
                      _buildLegend(),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        child: Divider(color: AppColors.lightBorder),
                      ),
                    ],
                  ),
                ),
                // Список записей – занимает всё оставшееся место, скроллится независимо
                SliverFillRemaining(
                  hasScrollBody: true,
                  child: DaySummaryCard(
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
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildLegend() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _legendItem(AppColors.primaryGrey, AppStrings.dayIsFull),
          const SizedBox(width: 16),
          _legendItem(AppColors.primaryBlue, AppStrings.chosenDay),
          const SizedBox(width: 16),
          _legendItem(AppColors.primaryRed, AppStrings.weekend),
        ],
      ),
    );
  }

  Widget _legendItem(Color color, String text) {
    return Row(
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(fontSize: 10, color: AppColors.primaryGrey)),
      ],
    );
  }
}
