import 'package:flutter/material.dart';
import '../../../../uikit/strings/app_strings.dart';
import '../../../bookingcard/bookinghistory/domain/booking_mock_data.dart';
import '../../../bookingcard/bookinghistory/feature/widgets/booking_card.dart';

class HistoryListSection extends StatelessWidget {
  const HistoryListSection({super.key});

  @override
  Widget build(BuildContext context) {
    final historyItems = BookingMockData.history;

    if (historyItems.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.only(top: 100),
          child: Text(AppStrings.historyIsEmpty),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: historyItems.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        return BookingCard(booking: historyItems[index]);
      },
    );
  }
}
