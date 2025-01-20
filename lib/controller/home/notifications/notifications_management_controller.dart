import 'package:get/get.dart';
import 'package:promotion_dashboard/core/functions/snackbar.dart';
import 'package:promotion_dashboard/data/model/home/notifications/notification_model.dart';
import 'package:promotion_dashboard/data/resource/remote/home/notifications_data.dart';

abstract class NotificationsManagementController extends GetxController {
  Future<void> getNotifications();
  Future<void> markAsLastRead();
  Future<void> deleteNotification(int id);
}

class NotificationsManagementControllerImp
    extends NotificationsManagementController {
  final Map<int, bool> readNotifications = {};
  int? lastReadNotificationId;

  bool loading = false;
  NotificationsData notificationsData = NotificationsData();
  List<NotificationModel>? notifications;

  @override
  void onInit() {
    super.onInit();
    getNotifications();
  }

  @override
  Future<void> getNotifications() async {
    loading = true;
    update();
    var response = await notificationsData.get();
    if (response.isSuccess) {
      notifications = List.generate(response.data.length,
          (index) => NotificationModel.fromJson(response.data[index]));

      for (var notification in notifications!) {
        readNotifications[notification.id] = notification.isRead;
      }
    }
    loading = false;
    update();
  }

  void markAsRead(int id) async {
    if (readNotifications[id] == false) {
      readNotifications[id] = true;
      lastReadNotificationId = id;
    }
    update();
  }

  bool isNotificationRead(int id) {
    return readNotifications[id] ?? false;
  }

  @override
  Future<void> markAsLastRead() async {
    loading = true;
    update();
    if (lastReadNotificationId != null) {
      await notificationsData.markAsRead(lastReadNotificationId!);
    }

    loading = false;
    update();
  }

  @override
  Future<void> deleteNotification(int id) async {
    loading = true;
    update();
    var response = await notificationsData.delete(id);
    if (response.isSuccess) {
      notifications?.removeWhere((notification) => notification.id == id);
      customSnackBar(response.message ?? '', '');
    }
    loading = false;
    update();
  }
}
