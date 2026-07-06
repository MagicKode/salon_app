class AppointmentModel {
  final String id;
  final String clientName;
  final List<String> servicesNames;
  final DateTime startTime;
  final DateTime endTime;
  final String? notes;
  final double totalPrice;
  final String? status;

  const AppointmentModel({
    required this.id,
    required this.clientName,
    required this.servicesNames,
    required this.startTime,
    required this.endTime,
    this.notes,
    required this.totalPrice,
    this.status,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    final price = (json['totalPrice'] as num?)?.toDouble() ?? 0.0;
    return AppointmentModel(
      id: json['id']?.toString() ?? '',
      clientName: json['clientName'] as String? ?? '',
      servicesNames: List<String>.from(json['servicesNames'] ?? []),
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      notes: json['notes'] as String?,
      totalPrice: price,
      status: json['status'] as String?,
    );
  }

  String get totalPriceFormatted {
    if (totalPrice == 0) return '0.00';
    final parts = totalPrice.toStringAsFixed(2).split('.');
    final ints = parts[0].replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ' ');
    return '$ints.${parts[1]}';
  }

  String get displayClientName {
    const names = {'+375292624381': 'Зоя', '+37529123456': 'Вадим', '+375336045766': 'Дмитрий'};
    return names[clientName] ?? 'Клиент';
  }

  String get clientPhone => clientName;
  String get priceDisplay => totalPrice > 0 ? '$totalPriceFormatted Br' : '';
  String get mainService => servicesNames.isNotEmpty ? servicesNames.first : 'Услуга';
}

extension AppointmentX on AppointmentModel {
  bool get hasDetails => (notes?.isNotEmpty ?? false) || servicesNames.length > 1;
  String get timeRange {
    final s = "${startTime.hour}:${startTime.minute.toString().padLeft(2, '0')}";
    final e = "${endTime.hour}:${endTime.minute.toString().padLeft(2, '0')}";
    return "$s — $e";
  }
}
