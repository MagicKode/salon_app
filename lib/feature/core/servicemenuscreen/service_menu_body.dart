import 'package:flutter/material.dart';
import 'package:salon_flutter/feature/core/servicemenuscreen/sections/servicemenucard/service_menu_card.dart';

import 'domain/menu_service.dart';
import 'domain/service_menu_category.dart';
import 'sections/categoryfiltersection/category_filter.dart';


class ServiceMenuBody extends StatelessWidget {
  const ServiceMenuBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CategoryFilter(categories: [
          ServiceMenuCategory(title: "Haircut", icon: Icons.content_cut),
          ServiceMenuCategory(title: "Facial", icon: Icons.face),
          ServiceMenuCategory(title: "Nails", icon: Icons.brush),
        ]),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: 6,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) => const ServiceMenuCard(
              service: MenuService(
                id: '1',
                title: "Woman Blunt Cut",
                price: "\$50",
                duration: "2 hour",
                description: "A blunt cut bob is a shorter hairstyle that's cut into a straight line.",
                imageUrl: "https://images.unsplash.com/photo-1562322140-8baeececf3df?q=80&w=200",
                discount: "-20%",
                isInCart: true,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
