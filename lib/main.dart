import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/account/CompleteProfileScreen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/appointment/appointment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/auth/reset_password_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/welcome/splash_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/firebase_options.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/services/notification_service.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/offer_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/home_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/auth/login_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/home/doctor_details_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/appointment/new_appointment_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/config_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/newsletters_model/newsletters_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/newsletters/newsletter_details_screen.dart';


import 'l10n/app_localizations.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/language_controller/language_controller.dart';
// REQUIRED: Must be a top-level function annotated with @pragma('vm:entry-point')
// so flutter_downloader's background isolate can locate it by name.
@pragma('vm:entry-point')
void downloadCallback(String id, int status, int progress) {
  // Callback runs in a different isolate — keep it lightweight.
  print('[Downloader] Task $id - Status: $status - Progress: $progress%');
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await PreferenceUtils.init();
//   await initializeDateFormatting();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   await NotificationService().init();
//   await FlutterDownloader.initialize(ignoreSsl: true, debug: true);
//   FlutterDownloader.registerCallback(downloadCallback);
//
//   // Request essential permissions for SOS and core features on startup
//   await [
//     Permission.microphone,
//     Permission.location,
//   ].request();
//
//   Get.put(LanguageController(), permanent: true);
//
//   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
//     (_) {
//       runApp(const MyApp());
//     },
//   );
// }
// @pragma('vm:entry-point')
// void downloadCallback(String id, int status, int progress) {
//   // Callback runs in a different isolate — keep it lightweight.
//   print('[Downloader] Task $id - Status: $status - Progress: $progress%');
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceUtils.init();
  await initializeDateFormatting();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService().init();
  await FlutterDownloader.initialize(ignoreSsl: true, debug: true);
  FlutterDownloader.registerCallback(downloadCallback);
  final token = await FirebaseMessaging.instance.getToken();
  print("PROJECT ID: ${DefaultFirebaseOptions.android.projectId}");
  print("SENDER ID: ${DefaultFirebaseOptions.android.messagingSenderId}");
  print("TOKEN: $token");
  // Request essential permissions for SOS and core features on startup
  await [
    Permission.microphone,
    Permission.location,
  ].request();

  Get.put(LanguageController(), permanent: true);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(const MyApp());
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final String savedLang = PreferenceUtils.getStringValue(PreferenceUtils.languageCode, "en");
    return GetMaterialApp.router(
      theme: ThemeData(useMaterial3: true),
      translationsKeys: AppLocalizations.supportedLocales.fold({}, (map, locale) => map), // Placeholder if using GetX translations
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(savedLang),
      fallbackLocale: const Locale('en'),
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
      backButtonDispatcher: router.backButtonDispatcher,
      debugShowCheckedModeBanner: false,
    );
  }
}

final router = GoRouter(
  initialLocation: '/',
  navigatorKey: Get.key,
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => const SplashScreen(),
    ),
    GoRoute(
      path: '/createNewPassword',
      builder: (context, params) => ResetPasswordScreen(
        state: params,
      ),
    ),
    GoRoute(
      path: '/offer',
      builder: (context, state) => OfferPage(
        arguments: state.extra as Map<String, dynamic>?,
      ),
    ),
    GoRoute(
      path: '/phone',
      builder: (_, __) => CompleteProfileScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (_, __) => LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (_, __) => const HomeScreen(),
    ),
    GoRoute(
      path: '/doctor-details',
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>;
        return DoctorDetailsScreen(
          doctor: extras['doctor'],
          doctorId: extras['doctorId'],
        );
      },
    ),
    // GoRoute(
    //   path: '/new-appointment',
    //   builder: (context, state) => const NewAppointmentScreen(),
    // ),
    GoRoute(
      path: '/appointments',
      builder: (context, state) => const AppointmentScreen(),
    ),
    GoRoute(
      path: '/${ConfigUtils.hospitalSku}/newsletters/:slug',
      redirect: (context, state) {
        final isLoggedIn = PreferenceUtils.getBoolValue("is_login");
        final token = PreferenceUtils.getStringValue("token");
        if (!isLoggedIn || token.isEmpty) {
          print("====== DEEP LINK BLOCKED: USER NOT LOGGED IN ======");
          return '/login';
        }
        return null; // Proceed if logged in
      },
      builder: (context, state) {
        final slug = state.pathParameters['slug'];
        print("====== DEEP LINK ROUTE MATCHED ======");
        print("====== URI: ${state.uri.toString()} ======");
        print("====== EXTRACTED SLUG: $slug ======");
        return NewsletterDetailsScreen(
          article: Newsletter(slug: slug),
        );
      },
    ),
  ],
);







