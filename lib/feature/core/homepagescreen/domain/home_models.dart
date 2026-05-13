// Одна модель для Категорий
class ServiceCategory {
  final String title;
  final String imagePath;

  const ServiceCategory({required this.title, required this.imagePath});
}

class ServiceData {
  static const List<ServiceCategory> categories = [
    ServiceCategory(
      title: 'Мужская стрижка',
      imagePath: 'assets/images/services/man/man-style.jpg',
    ),
    ServiceCategory(
      title: 'Женская стрижка',
      imagePath: 'assets/images/services/woman/woman-style.jpg',
    ),
    ServiceCategory(
      title: 'Мужское окрашивание',
      imagePath: 'assets/images/services/man/man-color.jpg',
    ),
    ServiceCategory(
      title: 'Женское окрашивание',
      imagePath: 'assets/images/services/woman/woman-color.jpeg',
    ),
    ServiceCategory(
      title: 'Стрижка бороды',
      imagePath: 'assets/images/services/man/man-barbershop.jpg',
    ),
    ServiceCategory(
      title: 'Муские Брови',
      imagePath: 'assets/images/services/man/man-brows.jpg',
    ),
    ServiceCategory(
      title: 'Женские брови',
      imagePath: 'assets/images/services/woman/woman-brows.jpeg',
    ),
  ];
}
