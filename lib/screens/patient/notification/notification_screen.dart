import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';

import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/notification_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/notification/notification_model.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/home_controller.dart';

import '../../../utils/string_utils.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF9FAFB),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight + 15),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ColorConst.primaryColor,
                    ColorConst.primaryColor.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorConst.primaryColor.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Get.back(),
                ),
                title: Row(
                  children: [
                    Text(
                      StringUtils.notifications,
                      style: TextStyleConst.boldTextStyle(Colors.white, 20),
                    ),
                    const SizedBox(width: 8),
                    if (controller.unreadCount > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "${controller.unreadCount}",
                          style: TextStyleConst.boldTextStyle(ColorConst.primaryColor, 12),
                        ),
                      ),
                  ],
                ),
                actions: [
                  if (controller.notifications.isNotEmpty)
                    TextButton(
                      onPressed: () => _showClearAllDialog(context, controller),
                      child: Text(
                        StringUtils.clearAll,
                        style: TextStyleConst.boldTextStyle(Colors.white, 14),
                      ),
                    ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ),
          body: controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: () => controller.getNotifications(),
                  child: controller.notifications.isEmpty
                      ? ListView(
                          children: [
                            SizedBox(height: Get.height * 0.3),
                             Center(child: Text(StringUtils.noNotificationsFound)),
                          ],
                        )
                      : ListView(
                          padding: const EdgeInsets.all(16),
                          children: _buildGroupedNotifications(controller.notifications),
                        ),
                ),
        );
      },
    );
  }

  List<Widget> _buildGroupedNotifications(List<NotificationItem> notifications) {
    Map<String, List<NotificationItem>> grouped = {
      "TODAY": [],
      "YESTERDAY": [],
      "THIS WEEK": [],
      "OLDER": [],
    };

    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = today.subtract(const Duration(days: 1));
    DateTime thisWeek = today.subtract(Duration(days: now.weekday));

    for (var item in notifications) {
      if (item.createdAt == null) continue;
      try {
        DateTime date = DateFormat("yyyy-MM-dd HH:mm:ss").parse(item.createdAt!);
        DateTime itemDate = DateTime(date.year, date.month, date.day);

        if (itemDate == today) {
          grouped["TODAY"]!.add(item);
        } else if (itemDate == yesterday) {
          grouped["YESTERDAY"]!.add(item);
        } else if (itemDate.isAfter(thisWeek)) {
          grouped["THIS WEEK"]!.add(item);
        } else {
          grouped["OLDER"]!.add(item);
        }
      } catch (e) {
        grouped["OLDER"]!.add(item);
      }
    }

    List<Widget> children = [];
    grouped.forEach((key, items) {
      if (items.isNotEmpty) {
        String headerTitle = key;
        if (key == "TODAY") headerTitle = StringUtils.today;
        if (key == "YESTERDAY") headerTitle = StringUtils.yesterday;
        if (key == "THIS WEEK") headerTitle = StringUtils.thisWeek;
        if (key == "OLDER") headerTitle = StringUtils.older;
        
        children.add(_buildSectionHeader(headerTitle));
        children.addAll(items.map((item) => _buildNotification(item)));
        children.add(const SizedBox(height: 10));
      }
    });

    return children;
  }

  Widget _buildNotification(NotificationItem item) {
    String timeStr = "";
    if (item.createdAt != null) {
      try {
        DateTime date = DateFormat("yyyy-MM-dd HH:mm:ss").parse(item.createdAt!);
        timeStr = _formatTime(date);
      } catch (e) {
        timeStr = item.createdAt!;
      }
    }

    return _buildNotificationItem(
      id: item.id.toString(),
      title: item.title ?? "",
      description: item.body ?? item.typeLabel ?? "",
      time: timeStr,
      isUnread: item.readAt == null,
      image: item.image,
      icon: Icons.notifications,
      onTap: () {
        _showNotificationDetails(item);
      },
    );
  }

  void _showNotificationDetails(NotificationItem item) {
    bool isAppointment = item.title?.toLowerCase().contains("appointment") ?? false;

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle for bottom sheet
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: ColorConst.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    item.typeLabel ?? (isAppointment ? StringUtils.appointment : StringUtils.notification),
                    style: TextStyleConst.boldTextStyle(ColorConst.primaryColor, 12),
                  ),
                ),
                Builder(
                  builder: (context) {
                    DateTime date;
                    try {
                      date = DateFormat("yyyy-MM-dd HH:mm:ss").parse(item.createdAt!);
                    } catch (e) {
                      date = DateTime.now();
                    }
                    return Text(
                      _formatTime(date),
                      style: TextStyleConst.mediumTextStyle(Colors.grey, 12),
                    );
                  }
                ),
              ],
            ),
            const SizedBox(height: 20),

            Text(
              item.title ?? StringUtils.notificationDetails,
              style: TextStyleConst.boldTextStyle(Colors.black87, 22),
            ),
            const SizedBox(height: 15),

            Text(
              item.body ?? item.text ?? "No details provided.",
              style: TextStyleConst.regularTextStyle(Colors.black54, 16),
            ),
            const SizedBox(height: 20),

            if (item.image != null && item.image!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  item.image!,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                ),
              ),
            const SizedBox(height: 35),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();

                  if (isAppointment) {
                    try {
                      final homeController = Get.find<HomeController>();
                      Get.until((route) => route.isFirst);
                      homeController.changeBottomNavIndex(1);
                    } catch (e) {
                      print(e);
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConst.primaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 0,
                ),
                child: Text(
                  isAppointment ? StringUtils.viewAppointments : StringUtils.dismiss,
                  style: TextStyleConst.boldTextStyle(Colors.white, 16),
                ),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  void _showClearAllDialog(BuildContext context, NotificationController controller) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(StringUtils.clearAllNotifications, style: TextStyleConst.boldTextStyle(Colors.black, 18)),
        content: Text(StringUtils.clearAllNotificationsConfirm, 
          style: TextStyleConst.mediumTextStyle(Colors.black54, 14)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(StringUtils.cancel, style: TextStyleConst.mediumTextStyle(Colors.grey, 14)),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              controller.clearAllNotifications();
            },
            child: Text(StringUtils.clearAll, style: TextStyleConst.boldTextStyle(ColorConst.redColor, 14)),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime date) {
    DateTime now = DateTime.now();
    Duration diff = now.difference(date);
    if (diff.inMinutes < 60) {
      return "${diff.inMinutes}${StringUtils.mAgo}";
    } else if (diff.inHours < 24) {
      return "${diff.inHours}${StringUtils.hAgo}";
    } else {
      return DateFormat("MMM dd").format(date);
    }
  }

  IconData _getIconForType(int? type) {
    switch (type) {
      case 1:
        return Icons.event_note;
      case 2:
        return Icons.shopping_cart;
      case 3:
        return Icons.security;
      default:
        return Icons.notifications;
    }
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: TextStyleConst.boldTextStyle(ColorConst.hintGreyColor, 12),
      ),
    );
  }

  Widget _buildNotificationItem({
    IconData? icon,
    String? image,
    Color? iconColor,
    required String title,
    required String description,
    required String time,
    bool isUnread = false,
    bool hasImage = false,
    String id = "0",
    VoidCallback? onTap,
  }) {
    return Dismissible(
      key: Key(id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: ColorConst.redColor,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: ColorConst.whiteColor),
      ),
      onDismissed: (direction) {
        if (onTap == null) return; // Should not happen for notifications
        Get.find<NotificationController>().deleteNotification(int.parse(id));
      },
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isUnread ? ColorConst.primaryColor.withOpacity(0.05) : ColorConst.whiteColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              if (!isUnread)
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isUnread)
                Container(
                  width: 3,
                  height: 40,
                  decoration: BoxDecoration(
                    color: ColorConst.primaryColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  margin: const EdgeInsets.only(right: 12),
                ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: image == null
                      ? (isUnread
                      ? ColorConst.primaryColor.withOpacity(0.1)
                      : ColorConst.primaryColor.withOpacity(0.05))
                      : Colors.transparent,
                  image: image != null
                      ? DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  )
                      : null,
                ),
                child: image == null
                    ? Icon(
                  icon ?? Icons.notifications,
                  color: ColorConst.primaryColor,
                  size: 20,
                )
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 14),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          time,
                          style: TextStyleConst.mediumTextStyle(ColorConst.primaryColor, 10),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, 12),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
