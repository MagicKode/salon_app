import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/homepagescreen/sections/appbarsection/app_bar_section.dart';
import 'package:salon_flutter/feature/homepagescreen/sections/bpttomnavbarsection/bottom_nav_bar_section.dart';
import 'package:salon_flutter/feature/homepagescreen/sections/descriptionsection/description_data.dart';
import 'package:salon_flutter/feature/homepagescreen/sections/descriptionsection/description_section.dart';
import 'package:salon_flutter/feature/homepagescreen/sections/feedbacksection/presentation/FeedbackData.dart';
import 'package:salon_flutter/feature/homepagescreen/sections/feedbacksection/presentation/feedback_section.dart';
import 'package:salon_flutter/feature/homepagescreen/sections/horizontalscrollbarsection/horizontal_scroll_bar_section.dart';
import 'package:salon_flutter/feature/homepagescreen/sections/horizontalscrollbarsection/promo_data.dart';
import 'package:salon_flutter/feature/homepagescreen/sections/servicelistsection/service_list_section.dart';

import '../homepagescreen//sections/background.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // Navigation state
  int _selectedIndex = 0;

  // Constants
  static const double _verticalPadding = 24.0;
  static const double _smallSpacing = 12.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: BottomNavBarSection(
        initialIndex: _selectedIndex,
        onTabSelected: _handleTabSelected,
      ),
      body: _buildBody(),
    );
  }

  void _handleTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      color: Colors.white,
      child: Background(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: _verticalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBarSection(),

              // Add other sections here when needed
              SizedBox(height: 16.0),

              _buildPromoSection(),

              SizedBox(height: 16.0),

              // Секция с услугами
              ServiceListSection(
                onCategoryTap: (category) {
                  // Обработка нажатия на категорию
                  print('Выбрана категория: ${category.title}');
                  // Навигация или другие действия
                },
              ),
              SizedBox(height: 16.0),

              DescriptionSection(data: DescriptionData.barberShop),

              SizedBox(height: 16.0),

              FeedbackSection(feedbacks: FeedbackData.items),

              SizedBox(height: 16.0),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPromoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.symmetric(horizontal: 16.0)),
        const SizedBox(height: _smallSpacing),

        // Используем данные из отдельного класса
        HorizontalScrollBarSection(items: PromoData.promoItems),
      ],
    );
  }
}
