import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/home/notifications/notifications_management_controller.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/core/widgets/handling_data_view.dart';

class NotificationsManagement extends StatelessWidget {
  const NotificationsManagement({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NotificationsManagementControllerImp());
    return GetBuilder<NotificationsManagementControllerImp>(
        builder: (controller) {
      var res = HandlingDataView(
        loading: controller.loading,
        dataIsEmpty: controller.notifications == null,
      );
      if (res.isValid) {
        return res.response!;
      }
      return Scaffold(
          backgroundColor: AppColors.screenColor,
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Notifications",
                  style: MyText.appStyle.fs24.wBold
                      .reCustomColor(AppColors.black)
                      .responsiveStyle(context),
                ),
              ],
            ),
            centerTitle: true,
          ),
          body: (controller.notifications != null &&
                  controller.notifications!.isNotEmpty)
              ? ListView.builder(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  itemCount: controller.notifications!.length,
                  itemBuilder: (context, index) {
                    final notification = controller.notifications![index];
                    return Dismissible(
                      key: ValueKey(notification),
                      direction: DismissDirection.startToEnd,
                      onDismissed: (direction) async {
                        await controller.deleteNotification(notification.id);
                      },
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: const Text(
                          "Delete",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          controller.markAsRead(notification.id);
                        },
                        child: Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  controller.isNotificationRead(notification.id)
                                      ? Colors.grey
                                      : Colors.green,
                              child: Icon(
                                controller.isNotificationRead(notification.id)
                                    ? Icons.done
                                    : Icons.new_releases,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              notification.user.firstName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: notification.isRead
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                            subtitle: Text(notification.details.message),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                    'No notifications',
                    style: MyText.appStyle.fs20.wBold
                        .reCustomColor(AppColors.black)
                        .style,
                  ),
                ));
    });
  }
}
