class DescriptionData {
  final String title;
  final String shortDescription;
  final String fullDescription;

  const DescriptionData({
    required this.title,
    required this.shortDescription,
    required this.fullDescription,
  });

  // Статический метод для получения данных о парикмахерской
  static const DescriptionData barberShop = DescriptionData(
    title: 'О нас',
    shortDescription:
    'Профессиональная парикмахерская с многолетним опытом работы. '
        'Мы предлагаем качественные услуги по доступным ценам.',
    fullDescription:
    'Наша парикмахерская работает с 2010 года. За это время мы заслужили '
        'доверие клиентов благодаря профессионализму наших мастеров и '
        'индивидуальному подходу к каждому посетителю.\n'
        'У нас уютная атмосфера, приветливый персонал и демократичные цены. '
        'Мы гарантируем качество каждой услуги и дарим приятные эмоции '
        'нашим клиентам!',
  );

  // Метод для получения комбинированного описания (если нужно показывать полный текст)
  String get fullText => fullDescription;
}