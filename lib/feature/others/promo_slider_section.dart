// import 'package:flutter/material.dart';
// import '../core/homepagescreen/domain/home_models.dart';
//
// class PromoSliderSection extends StatelessWidget {
//   const PromoSliderSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 120,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         itemCount: PromoData.items.length,
//         itemBuilder: (context, index) {
//           final item = PromoData.items[index];
//           return Container(
//             width: 300,
//             margin: const EdgeInsets.only(right: 12),
//             decoration: BoxDecoration(
//               color: item.backgroundColor,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//                         Text(item.description, style: const TextStyle(fontSize: 12)),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const Icon(Icons.image, size: 80, color: Colors.grey), // Заглушка вместо Image.network
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
