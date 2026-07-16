import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/home_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/newsletters_model/newsletters_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/newsletters/newsletter_details_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/notification/notification_screen.dart';

import '../controller/patient/appointment_controller/appointment_controller.dart';

// Top-level function for background message handling
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Handling a background message: ${message.messageId}');
  // If you need to access other services/plugins here, ensure they are initialized
  // await Firebase.initializeApp(); // usually technically required if using other Firebase services
}

class NotificationService {
  // Singleton pattern
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() => _instance;

  NotificationService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Initialize the notification service
  Future<void> init() async {
    // 1. Initialize Firebase Messaging
    await _requestPermission();
    
    // 2. Setup Background Handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // 3. Initialize Local Notifications
    await _initLocalNotifications();

    // 4. Handle different notification states
    await _setupInteractedMessage();

    // 5. Get FCM Token
    await getToken();
  }

  /// Request Notification Permissions
  Future<void> _requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
    } else {
      debugPrint('User declined or has not accepted permission');
    }
  }

  /// Generate and return FCM Token
  Future<String?> getToken() async {
    // iOS requires APNS token first
    if (Platform.isIOS) {
      String? apnsToken = await _firebaseMessaging.getAPNSToken();
      if (apnsToken == null) {
        debugPrint('APNS token is null. FCM token might not be generated yet.');
        return null; // Exit and wait for token refresh or next init
      }
    }

    String? token;
    try {
      token = await _firebaseMessaging.getToken();
    } catch (e) {
      debugPrint('Error getting FCM token: $e');
    }

    debugPrint('FCM Token: $token');
    if (token != null) {
      PreferenceUtils.setStringValue("fcm_token", token);
    }

    // Listen for token refresh
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      debugPrint('FCM Token Refreshed: $newToken');
      PreferenceUtils.setStringValue("fcm_token", newToken);
    });

    return token;
  }

  /// Initialize Local Notifications
  Future<void> _initLocalNotifications() async {
    // Android Setup
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS Setup
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestSoundPermission: false, 
      requestBadgePermission: false, 
      requestAlertPermission: false,
    );

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {
        if (details.payload != null) {
          debugPrint('Notification Payload: ${details.payload}');
          _handleMessagePayload(details.payload!);
        }
      },
    );

    // Setup the Android Notification Channel
    await _setupAndroidChannel();

    // Setup Foreground Listener
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showForegroundNotification(message);
    });
  }

  /// Create Android Notification Channel
  Future<void> _setupAndroidChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.', // description
      importance: Importance.max,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  /// Show Local Notification when app is in foreground
  Future<void> _showForegroundNotification(RemoteMessage message) async {
    debugPrint('Got a message whilst in the foreground!');
    debugPrint('Message data: ${message.data}');

    if (message.notification != null) {
      debugPrint('Message also contained a notification: ${message.notification}');
      
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      AppleNotification? apple = message.notification?.apple;

      // Handle Big Picture Style
      BigPictureStyleInformation? bigPictureStyleInformation;
      String? imageUrl = (Platform.isAndroid && android?.imageUrl != null)
          ? android?.imageUrl
          : (Platform.isIOS && apple?.imageUrl != null)
              ? apple?.imageUrl
              : message.data['image'];

      if (imageUrl != null) {
        final String? bigPicturePath = await _downloadAndSaveFile(imageUrl, 'bigPicture.jpg');
        if (bigPicturePath != null) {
          bigPictureStyleInformation = BigPictureStyleInformation(
            FilePathAndroidBitmap(bigPicturePath),
            hideExpandedLargeIcon: true,
          );
        }
      }

      // Android Notification Details
      AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        channelDescription: 'This channel is used for important notifications.',
        importance: Importance.max,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
        styleInformation: bigPictureStyleInformation,
      );

      // iOS Notification Details
      const DarwinNotificationDetails darwinNotificationDetails =
          DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: darwinNotificationDetails,
      );

      // We use the message.data encoded as payload so we can handle it on tap
      String payload = jsonEncode(message.data);

      await _flutterLocalNotificationsPlugin.show(
        id: notification.hashCode,
        title: notification?.title,
        body: notification?.body,
        notificationDetails: notificationDetails,
        payload: payload,
      );
    }
  }

  /// Helper to download image for notification
  Future<String?> _downloadAndSaveFile(String url, String fileName) async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final String filePath = '${directory.path}/$fileName';
      final http.Response response = await http.get(Uri.parse(url));
      final File file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return filePath;
    } catch (e) {
      debugPrint('Error downloading image: $e');
      return null;
    }
  }

  /// Handle Notification Tap Logic
  void _handleMessagePayload(String payload) {
    try {
      Map<String, dynamic> data = jsonDecode(payload);
      _navigateBasedOnPayload(data);
    } catch (e) {
      debugPrint('Error parsing payload: $e');
    }
  }

  void _handleRemoteMessage(RemoteMessage message) {
    _navigateBasedOnPayload(message.data);
  }

  void _navigateBasedOnPayload(Map<String, dynamic> data) {
    debugPrint('Navigating based on payload: $data');
    if (data.containsKey('type')) {
      String type = data['type'].toString();

      if (type == 'offer') {
        if (Get.context != null) {
          GoRouter.of(Get.context!).push('/offer', extra: data);
        }
      } else if (type == 'newsletter') {
        if (data.containsKey('newsletter_id')) {
          final int? newsletterId = int.tryParse(data['newsletter_id'].toString());
          if (newsletterId != null && Get.context != null) {
           
            final Newsletter dummyArticle = Newsletter(id: newsletterId);
            
            Get.to(() => NewsletterDetailsScreen(article: dummyArticle));
          }
        }
      } else if (type == 'appointment') {
        // Handle Appointment Navigation
        if (Get.isRegistered<HomeController>()) {
          HomeController homeController = Get.find<HomeController>();
          String role = PreferenceUtils.getStringValue("role");

          if (role == "Doctor") {
            homeController.changeDoctorWidget(0); // 0 is Appointment for Doctor
          } else {
            // Patient Navigation based on status
            int tabIndex = 0; // Default to Upcoming
            debugPrint('--- NOTIFICATION DEBUG ---');
            debugPrint('Full Payload: $data');
            
            if (data.containsKey('status')) {
              String status = data['status'].toString().toLowerCase();
              debugPrint('Received Status: $status');
              
              if (status == 'pending' || status == 'upcoming') {
                tabIndex = 0; // Upcoming
              } else if (status == 'confirmed' || status == 'checked') {
                tabIndex = 1; // Confirmed
              } else if (status == 'completed' || status == 'checked_out' || status == 'checked out') {
                tabIndex = 2; // Completed
              } else if (status == 'cancelled') {
                tabIndex = 3; // Cancelled
              }
            }
            debugPrint('Target Tab Index: $tabIndex');
            debugPrint('--------------------------');

            // 1. Set the sub-tab index in AppointmentController FIRST
            // 🔥 Use Get.put to ensure it's initialized even if not previously registered
            AppointmentController appointmentController = Get.put(AppointmentController());
            appointmentController.currentIndex.value = tabIndex;

            // 2. Change bottom nav to Appointment tab (Index 1)
            homeController.changeBottomNavIndex(1);
          }

          // Ensure we are on the home screen to see the changed widget
          if (Get.context != null) {
            GoRouter.of(Get.context!).go('/home');
          }
        }
      } else if (type == 'regular' || type == 'regular_update') {
        Get.to(() => NotificationScreen());
      }
    }
  }

  /// Setup Interacted Message (Terminated & Background-open)
  Future<void> _setupInteractedMessage() async {
    // 1. Get any message which caused the application to open from a terminated state.
    RemoteMessage? initialMessage =
        await _firebaseMessaging.getInitialMessage();

    if (initialMessage != null) {
      _handleRemoteMessage(initialMessage);
    }

    // 2. Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleRemoteMessage);
  }
}
