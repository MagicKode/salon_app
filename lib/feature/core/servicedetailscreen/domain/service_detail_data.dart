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

class ServiceDetailData {
  // Статическая константа для конкретной услуги (например, для тестов или дефолтного отображения)
  static const ServiceDetail mensHaircut = ServiceDetail(
    id: '1',
    title: AppStrings.dummyServiceTitle,
    imageUrl: 'assets/images/services/man/man-style.jpg',
    duration: '45-60 ${AppStrings.durationUnit}',
    price: '30 ${AppStrings.currency}',
    description: AppStrings.dummyServiceDescription,
  );

  // Здесь в будущем может быть список всех детальных описаний
  static const List<ServiceDetail> allDetails = [
    mensHaircut,
    // ... другие услуги
  ];
}