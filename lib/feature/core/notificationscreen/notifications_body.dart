import 'package:flutter/material.dart';
import 'domain/notification_model.dart';
import 'sections/notification_tile.dart';

class NotificationsBody extends StatelessWidget {
  const NotificationsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final List<NotificationModel> notifications = [
      NotificationModel(
        title: "Запись подтверждена",
        body: "Ваша запись на 'Женская стрижка' к мастеру Павел на 4 мая успешно подтверждена.",
        time: "10 мин. назад",
        isRead: false,
      ),
      NotificationModel(
        title: "Напоминание",
        body: "Не забудьте о вашем визите завтра в 10:00. Ждем вас!",
        time: "Вчера",
        isRead: true,
      ),
      NotificationModel(
        title: "Акция 1+1",
        body: "Только на этой неделе: при записи на маникюр — уход в подарок!",
        time: "2 дня назад",
        isRead: true,
      ),
    ];

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      itemCount: notifications.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) => NotificationTile(notification: notifications[index]),
    );
  }
}
