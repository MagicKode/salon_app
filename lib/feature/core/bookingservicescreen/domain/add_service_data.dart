class AddServiceData {
  final String id;
  final String name;
  final double price;
  final int durationMinutes;

  const AddServiceData({
    required this.id,
    required this.name,
    required this.price,
    this.durationMinutes = 30,
  });
}