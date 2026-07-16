import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/api_request/api_request.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/notification/notification_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class NotificationController extends GetxController {
  bool isLoading = false;
  NotificationModel? notificationModel;
  List<NotificationItem> notifications = [];
  int unreadCount = 0;

  @override
  void onInit() {
    super.onInit();
    getNotifications();
  }

  Future<void> getNotifications() async {
    isLoading = true;
    update();
    try {
      final response = await StringUtils.client.getNotifications(PreferenceUtils.getStringValue("token"));
      notificationModel = response;
      if (notificationModel?.success == true) {
        notifications = notificationModel?.data ?? [];
        unreadCount = 0; // Simple list response does not provide unread count
      }
    } catch (e) {
      print("Error fetching notifications: $e");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> markAllAsRead() async {
    try {
      final response = await StringUtils.client.readAllNotifications(PreferenceUtils.getStringValue("token"));
      if (response != null) {
        // Refresh notifications after marking as read
        getNotifications();
      }
    } catch (e) {
      print("Error marking notifications as read: $e");
    }
  }

  Future<void> deleteNotification(int id) async {
    try {
      final response = await StringUtils.client.deleteNotification(PreferenceUtils.getStringValue("token"), id);
      if (response != null) {
        // Remove locally for immediate UI update then refresh
        notifications.removeWhere((element) => element.id == id);
        update();
        getNotifications();
      }
    } catch (e) {
      print("Error deleting notification: $e");
    }
  }

  Future<void> clearAllNotifications() async {
    isLoading = true;
    update();
    try {
      final response = await StringUtils.client.clearAllNotifications(PreferenceUtils.getStringValue("token"));
      if (response != null) {
        notifications.clear();
        update();
        getNotifications();
      }
    } catch (e) {
      print("Error clearing all notifications: $e");
    } finally {
      isLoading = false;
      update();
    }
  }
}
