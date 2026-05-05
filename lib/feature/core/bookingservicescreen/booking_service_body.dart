import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/sections/date_selection_section.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/sections/notes_section.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/sections/order_summary_section.dart';
import 'package:salon_flutter/feature/core/bookingservicescreen/sections/time_selection_section.dart';

import '../../../uikit/assets/app_assets.dart';
import '../../../uikit/strings/app_strings.dart';

class BookingServiceBody extends StatefulWidget {
  const BookingServiceBody({super.key});

  @override
  State<BookingServiceBody> createState() => _BookingServiceBodyState();
}

class _BookingServiceBodyState extends State<BookingServiceBody> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OrderSummarySection(services: ["Woman Blunt Cut"]),

          const SizedBox(height: 10),

          _buildMasterTile(),

          const SizedBox(height: 24),

          DateSelectionSection(),

          const SizedBox(height: 24),

          TimeSelectionSection(
            onTimeChanged: (time) {
              debugPrint("Выбрано время: ${time?.format(context)}");
            },
          ),

          const SizedBox(height: 24),

          const NotesSection(),
        ],
      ),
    );
  }

  Widget _buildMasterTile() {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const CircleAvatar(
        radius: 30,
        backgroundImage: AssetImage(AppAssets.pavelImg),
      ),
      title: const Text(
        AppStrings.yourMasterPavel,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: const Text(AppStrings.topMaster),
    );
  }
}
