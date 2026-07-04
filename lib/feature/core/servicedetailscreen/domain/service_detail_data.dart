import '../../../../uikit/strings/app_strings.dart';

class ServiceDetail {
  final String id;
  final String title;
  final String imageUrl;
  final String duration;
  final String price;
  final String description;

  const ServiceDetail({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.duration,
    required this.price,
    required this.description,
  });
}

class ServiceDetailData {}
