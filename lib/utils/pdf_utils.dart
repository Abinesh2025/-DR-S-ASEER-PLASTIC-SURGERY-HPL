// // // import 'dart:io';
// // // import 'package:flutter_downloader/flutter_downloader.dart';
// // // import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
// // // import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
// // // import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
// // // import 'package:path_provider/path_provider.dart';
// // // import 'package:permission_handler/permission_handler.dart';
// // // import 'package:url_launcher/url_launcher.dart';
// // // import 'package:path/path.dart' as p;
// // //
// // // class PDFUtils {
// // //   static Future<void> downloadPDF(String url) async {
// // //     if (url.isEmpty) {
// // //       DisplaySnackBar.displaySnackBar(
// // //           "Invalid PDF URL", 3, ColorConst.redColor);
// // //       return;
// // //     }
// // //
// // //     // Fix URL if it's using a local domain that needs rewriting
// // //     final fixedUrl = StringUtils.fixImageUrl(url);
// // //
// // //     if (Platform.isIOS) {
// // //       final uri = Uri.parse(fixedUrl);
// // //       if (await canLaunchUrl(uri)) {
// // //         await launchUrl(uri);
// // //       } else {
// // //         DisplaySnackBar.displaySnackBar(
// // //             "Could not open PDF", 3, ColorConst.redColor);
// // //       }
// // //       return;
// // //     }
// // //
// // //     if (Platform.isAndroid) {
// // //       // 1. Request Permissions
// // //       // For Android 13+ (SDK 33), WRITE_EXTERNAL_STORAGE is not used
// // //       // We check for photos/videos/audio or just hope for the best if it's a public dir
// // //       // However, for FlutterDownloader to saveInPublicStorage: true, it often needs permission on older versions.
// // //
// // //       var status = await Permission.storage.request();
// // //       if (!status.isGranted) {
// // //         // Try requesting manageExternalStorage if storage failed on newer Androids
// // //         if (await Permission.manageExternalStorage.isRestricted) {
// // //           // On Android 11+, storage permission might be restricted.
// // //         }
// // //       }
// // //
// // //       // 2. Determine saved directory
// // //       Directory? directory;
// // //       try {
// // //         if (Platform.isAndroid) {
// // //           directory = Directory('/storage/emulated/0/Download');
// // //           if (!await directory.exists()) {
// // //             directory = await getExternalStorageDirectory();
// // //           }
// // //         } else {
// // //           directory = await getApplicationDocumentsDirectory();
// // //         }
// // //       } catch (e) {
// // //         directory = await getApplicationDocumentsDirectory();
// // //       }
// // //
// // //       if (directory == null) {
// // //         DisplaySnackBar.displaySnackBar(
// // //             "Could not access storage", 3, ColorConst.redColor);
// // //         return;
// // //       }
// // //
// // //       final hmsDir = Directory(p.join(directory.path, "HMS"));
// // //       if (!await hmsDir.exists()) {
// // //         await hmsDir.create(recursive: true);
// // //       }
// // //
// // //       // 3. Enqueue download
// // //       try {
// // //         final taskId = await FlutterDownloader.enqueue(
// // //           url: fixedUrl,
// // //           savedDir: hmsDir.path,
// // //           showNotification: true,
// // //           openFileFromNotification: true,
// // //           saveInPublicStorage: true,
// // //           fileName: "Document_${DateTime.now().millisecondsSinceEpoch}.pdf",
// // //         );
// // //
// // //         if (taskId != null) {
// // //           DisplaySnackBar.displaySnackBar(
// // //               "Download started...", 3, ColorConst.greenColor);
// // //         } else {
// // //           throw Exception("Failed to enqueue download");
// // //         }
// // //       } catch (e) {
// // //         print("Download error: $e");
// // //         DisplaySnackBar.displaySnackBar(
// // //             "Failed to download PDF", 3, ColorConst.redColor);
// // //       }
// // //     }
// // //   }
// // // }
// // import 'dart:io';
// // import 'package:flutter_downloader/flutter_downloader.dart';
// // import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
// // import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
// // import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'package:permission_handler/permission_handler.dart';
// // import 'package:url_launcher/url_launcher.dart';
// // import 'package:path/path.dart' as p;
// //
// // class PDFUtils {
// //   static Future<void> downloadPDF(String url) async {
// //     if (url.isEmpty) {
// //       DisplaySnackBar.displaySnackBar("Invalid PDF URL", 3, ColorConst.redColor);
// //       return;
// //     }
// //
// //     final fixedUrl = StringUtils.fixImageUrl(url);
// //
// //     if (Platform.isIOS) {
// //       final uri = Uri.parse(fixedUrl);
// //       if (await canLaunchUrl(uri)) {
// //         await launchUrl(uri, mode: LaunchMode.externalApplication);
// //       } else {
// //         DisplaySnackBar.displaySnackBar("Could not open PDF", 3, ColorConst.redColor);
// //       }
// //       return;
// //     }
// //
// //     if (Platform.isAndroid) {
// //       // 1. Handle Permissions for Android
// //       if (await Permission.storage.request().isGranted ||
// //           await Permission.manageExternalStorage.request().isGranted) {
// //
// //         // 2. Get a safe directory
// //         // Instead of hardcoded '/storage/emulated/0', use path_provider
// //         // Directory? baseDir = await getExternalStorageDirectory(); // App-specific external storage
// //         //
// //         // // If you want it in the public "Downloads" folder specifically,
// //         // // you often have to use the package's internal logic or different permissions.
// //         // // For now, let's use a safe path:
// //         // String savedPath = baseDir!.path;
// //         //
// //         // final hmsDir = Directory(p.join(savedPath, "HMS"));
// //         // if (!await hmsDir.exists()) {
// //         //   await hmsDir.create(recursive: true);
// //         // }
// // // 2. Get a safe directory
// //         Directory? baseDir = await getExternalStorageDirectory();
// //         String savedPath = baseDir!.path;
// //
// //         final hmsDir = Directory(p.join(savedPath, "HMS"));
// //         if (!await hmsDir.exists()) {
// //           await hmsDir.create(recursive: true);
// //         }
// //         try {
// //           final taskId = await FlutterDownloader.enqueue(
// //             url: fixedUrl,
// //             savedDir: hmsDir.path,
// //             fileName: "Document_${DateTime.now().millisecondsSinceEpoch}.pdf",
// //             showNotification: true, // show download progress in status bar
// //             openFileFromNotification: true, // click notification to open
// //             saveInPublicStorage: true, // This attempts to put it in the public Downloads folder
// //           );
// //
// //           if (taskId != null) {
// //             DisplaySnackBar.displaySnackBar("Download started...", 3, ColorConst.greenColor);
// //           }
// //         } catch (e) {
// //           DisplaySnackBar.displaySnackBar("Download error: $e", 3, ColorConst.redColor);
// //         }
// //       } else {
// //         DisplaySnackBar.displaySnackBar("Storage permission denied", 3, ColorConst.redColor);
// //       }
// //     }
// //   }
// // }
// // import 'dart:io';
// // import 'package:device_info_plus/device_info_plus.dart';
// // import 'package:flutter_downloader/flutter_downloader.dart';
// // import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
// // import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
// // import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'package:permission_handler/permission_handler.dart';
// // import 'package:url_launcher/url_launcher.dart';
// // import 'package:path/path.dart' as p;
// //
// // class PDFUtils {
// //   static Future<void> downloadPDF(String url) async {
// //     if (url.isEmpty) {
// //       DisplaySnackBar.displaySnackBar("Invalid PDF URL", 3, ColorConst.redColor);
// //       return;
// //     }
// //
// //     final fixedUrl = StringUtils.fixImageUrl(url);
// //
// //     if (Platform.isIOS) {
// //       final uri = Uri.parse(fixedUrl);
// //       if (await canLaunchUrl(uri)) {
// //         await launchUrl(uri, mode: LaunchMode.externalApplication);
// //       } else {
// //         DisplaySnackBar.displaySnackBar("Could not open PDF", 3, ColorConst.redColor);
// //       }
// //       return;
// //     }
// //
// //     if (Platform.isAndroid) {
// //       bool hasPermission = await _requestPermissions();
// //
// //       if (hasPermission) {
// //         // 2. Get a safe directory
// //         Directory? baseDir = await getExternalStorageDirectory();
// //
// //         if (baseDir == null) {
// //           DisplaySnackBar.displaySnackBar("Could not access storage", 3, ColorConst.redColor);
// //           return;
// //         }
// //
// //         String savedPath = baseDir.path;
// //
// //         final hmsDir = Directory(p.join(savedPath, "HMS"));
// //         if (!await hmsDir.exists()) {
// //           await hmsDir.create(recursive: true);
// //         }
// //
// //         try {
// //           final taskId = await FlutterDownloader.enqueue(
// //             url: fixedUrl,
// //             savedDir: hmsDir.path,
// //             fileName: "Document_${DateTime.now().millisecondsSinceEpoch}.pdf",
// //             showNotification: true, // show download progress in status bar
// //             openFileFromNotification: true, // click notification to open
// //             saveInPublicStorage: true, // Moves it to the public Downloads folder
// //           );
// //
// //           if (taskId != null) {
// //             DisplaySnackBar.displaySnackBar("Download started...", 3, ColorConst.greenColor);
// //           }
// //         } catch (e) {
// //           DisplaySnackBar.displaySnackBar("Download error: $e", 3, ColorConst.redColor);
// //         }
// //       } else {
// //         DisplaySnackBar.displaySnackBar("Permissions required to download files", 3, ColorConst.redColor);
// //       }
// //     }
// //   }
// //
// //   /// Handles permissions dynamically based on the Android version
// //   static Future<bool> _requestPermissions() async {
// //     if (Platform.isAndroid) {
// //       final androidInfo = await DeviceInfoPlugin().androidInfo;
// //
// //       // Request Notification Permission (Required for Android 13+)
// //       if (androidInfo.version.sdkInt >= 33) {
// //         var notificationStatus = await Permission.notification.request();
// //         // On Android 13+, we don't need WRITE_EXTERNAL_STORAGE to save to public directories
// //         return notificationStatus.isGranted || notificationStatus.isLimited;
// //       }
// //       // For Android 12 and below
// //       else {
// //         var storageStatus = await Permission.storage.request();
// //         return storageStatus.isGranted;
// //       }
// //     }
// //     return true;
// //   }
// // }
// import 'dart:io';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:path/path.dart' as p;
//
// class PDFUtils {
//   static Future<void> downloadPDF(String url) async {
//     if (url.isEmpty) {
//       DisplaySnackBar.displaySnackBar("Invalid PDF URL", 3, ColorConst.redColor);
//       return;
//     }
//
//     final fixedUrl = StringUtils.fixImageUrl(url);
//
//     // --- iOS Logic ---
//     if (Platform.isIOS) {
//       final uri = Uri.parse(fixedUrl);
//       if (await canLaunchUrl(uri)) {
//         await launchUrl(uri, mode: LaunchMode.externalApplication);
//       } else {
//         DisplaySnackBar.displaySnackBar("Could not open PDF", 3, ColorConst.redColor);
//       }
//       return;
//     }
//
//     // --- Android Logic ---
//     if (Platform.isAndroid) {
//       bool hasPermission = await _requestPermissions();
//
//       if (hasPermission) {
//         // Use App-specific external storage (Safest for all Android versions)
//         Directory? baseDir = await getExternalStorageDirectory();
//
//         if (baseDir == null) {
//           DisplaySnackBar.displaySnackBar("Could not access storage", 3, ColorConst.redColor);
//           return;
//         }
//
//         String savedPath = baseDir.path;
//         final hmsDir = Directory(p.join(savedPath, "HMS"));
//
//         if (!await hmsDir.exists()) {
//           await hmsDir.create(recursive: true);
//         }
//
//         try {
//           final taskId = await FlutterDownloader.enqueue(
//             url: fixedUrl,
//             savedDir: hmsDir.path,
//             fileName: "Document_${DateTime.now().millisecondsSinceEpoch}.pdf",
//             showNotification: true,
//             openFileFromNotification: true,
//             // Setting this to FALSE is much safer on strict devices.
//             // The user can still open the PDF by tapping the notification.
//             saveInPublicStorage: false,
//           );
//
//           if (taskId != null) {
//             DisplaySnackBar.displaySnackBar("Download started...", 3, ColorConst.greenColor);
//           }
//         } catch (e) {
//           DisplaySnackBar.displaySnackBar("Download error: $e", 3, ColorConst.redColor);
//         }
//       }
//     }
//   }
//
//   /// Bulletproof Permission Handler for Android
//   static Future<bool> _requestPermissions() async {
//     if (Platform.isAndroid) {
//       final androidInfo = await DeviceInfoPlugin().androidInfo;
//
//       // Android 13+ (API 33+)
//       if (androidInfo.version.sdkInt >= 33) {
//         var notificationStatus = await Permission.notification.request();
//
//         if (notificationStatus.isPermanentlyDenied) {
//           DisplaySnackBar.displaySnackBar("Please allow notifications to see download progress", 3, ColorConst.redColor);
//           await openAppSettings();
//           return false;
//         }
//         return notificationStatus.isGranted || notificationStatus.isLimited;
//       }
//       // Android 12 and below (API < 33)
//       else {
//         var storageStatus = await Permission.storage.request();
//
//         if (storageStatus.isGranted) {
//           return true;
//         } else if (storageStatus.isPermanentlyDenied) {
//           // THIS fixes the "some mobiles" issue. If the phone blocks the popup, we route them to settings.
//           DisplaySnackBar.displaySnackBar("Storage permission is required. Please enable it in Settings.", 4, ColorConst.redColor);
//           await Future.delayed(const Duration(seconds: 1)); // Small delay so they read the snackbar
//           await openAppSettings();
//           return false;
//         } else {
//           DisplaySnackBar.displaySnackBar("Storage permission denied", 3, ColorConst.redColor);
//           return false;
//         }
//       }
//     }
//     return true;
//   }
// }

// // import 'dart:io';
// // import 'package:flutter_downloader/flutter_downloader.dart';
// // import 'package:Sujatha_patient/component/common_snackbar.dart';
// // import 'package:Sujatha_patient/constant/color_const.dart';
// // import 'package:Sujatha_patient/utils/string_utils.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'package:permission_handler/permission_handler.dart';
// // import 'package:url_launcher/url_launcher.dart';
// // import 'package:path/path.dart' as p;
// //
// // class PDFUtils {
// //   static Future<void> downloadPDF(String url) async {
// //     if (url.isEmpty) {
// //       DisplaySnackBar.displaySnackBar(
// //           "Invalid PDF URL", 3, ColorConst.redColor);
// //       return;
// //     }
// //
// //     // Fix URL if it's using a local domain that needs rewriting
// //     final fixedUrl = StringUtils.fixImageUrl(url);
// //
// //     if (Platform.isIOS) {
// //       final uri = Uri.parse(fixedUrl);
// //       if (await canLaunchUrl(uri)) {
// //         await launchUrl(uri);
// //       } else {
// //         DisplaySnackBar.displaySnackBar(
// //             "Could not open PDF", 3, ColorConst.redColor);
// //       }
// //       return;
// //     }
// //
// //     if (Platform.isAndroid) {
// //       // 1. Request Permissions
// //       // For Android 13+ (SDK 33), WRITE_EXTERNAL_STORAGE is not used
// //       // We check for photos/videos/audio or just hope for the best if it's a public dir
// //       // However, for FlutterDownloader to saveInPublicStorage: true, it often needs permission on older versions.
// //
// //       var status = await Permission.storage.request();
// //       if (!status.isGranted) {
// //         // Try requesting manageExternalStorage if storage failed on newer Androids
// //         if (await Permission.manageExternalStorage.isRestricted) {
// //           // On Android 11+, storage permission might be restricted.
// //         }
// //       }
// //
// //       // 2. Determine saved directory
// //       Directory? directory;
// //       try {
// //         if (Platform.isAndroid) {
// //           directory = Directory('/storage/emulated/0/Download');
// //           if (!await directory.exists()) {
// //             directory = await getExternalStorageDirectory();
// //           }
// //         } else {
// //           directory = await getApplicationDocumentsDirectory();
// //         }
// //       } catch (e) {
// //         directory = await getApplicationDocumentsDirectory();
// //       }
// //
// //       if (directory == null) {
// //         DisplaySnackBar.displaySnackBar(
// //             "Could not access storage", 3, ColorConst.redColor);
// //         return;
// //       }
// //
// //       final hmsDir = Directory(p.join(directory.path, "HMS"));
// //       if (!await hmsDir.exists()) {
// //         await hmsDir.create(recursive: true);
// //       }
// //
// //       // 3. Enqueue download
// //       try {
// //         final taskId = await FlutterDownloader.enqueue(
// //           url: fixedUrl,
// //           savedDir: hmsDir.path,
// //           showNotification: true,
// //           openFileFromNotification: true,
// //           saveInPublicStorage: true,
// //           fileName: "Document_${DateTime.now().millisecondsSinceEpoch}.pdf",
// //         );
// //
// //         if (taskId != null) {
// //           DisplaySnackBar.displaySnackBar(
// //               "Download started...", 3, ColorConst.greenColor);
// //         } else {
// //           throw Exception("Failed to enqueue download");
// //         }
// //       } catch (e) {
// //         print("Download error: $e");
// //         DisplaySnackBar.displaySnackBar(
// //             "Failed to download PDF", 3, ColorConst.redColor);
// //       }
// //     }
// //   }
// // }
// import 'dart:io';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:Sujatha_patient/component/common_snackbar.dart';
// import 'package:Sujatha_patient/constant/color_const.dart';
// import 'package:Sujatha_patient/utils/string_utils.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:path/path.dart' as p;
//
// class PDFUtils {
//   static Future<void> downloadPDF(String url) async {
//     if (url.isEmpty) {
//       DisplaySnackBar.displaySnackBar("Invalid PDF URL", 3, ColorConst.redColor);
//       return;
//     }
//
//     final fixedUrl = StringUtils.fixImageUrl(url);
//
//     if (Platform.isIOS) {
//       final uri = Uri.parse(fixedUrl);
//       if (await canLaunchUrl(uri)) {
//         await launchUrl(uri, mode: LaunchMode.externalApplication);
//       } else {
//         DisplaySnackBar.displaySnackBar("Could not open PDF", 3, ColorConst.redColor);
//       }
//       return;
//     }
//
//     if (Platform.isAndroid) {
//       // 1. Handle Permissions for Android
//       if (await Permission.storage.request().isGranted ||
//           await Permission.manageExternalStorage.request().isGranted) {
//
//         // 2. Get a safe directory
//         // Instead of hardcoded '/storage/emulated/0', use path_provider
//         // Directory? baseDir = await getExternalStorageDirectory(); // App-specific external storage
//         //
//         // // If you want it in the public "Downloads" folder specifically,
//         // // you often have to use the package's internal logic or different permissions.
//         // // For now, let's use a safe path:
//         // String savedPath = baseDir!.path;
//         //
//         // final hmsDir = Directory(p.join(savedPath, "HMS"));
//         // if (!await hmsDir.exists()) {
//         //   await hmsDir.create(recursive: true);
//         // }
// // 2. Get a safe directory
//         Directory? baseDir = await getExternalStorageDirectory();
//         String savedPath = baseDir!.path;
//
//         final hmsDir = Directory(p.join(savedPath, "HMS"));
//         if (!await hmsDir.exists()) {
//           await hmsDir.create(recursive: true);
//         }
//         try {
//           final taskId = await FlutterDownloader.enqueue(
//             url: fixedUrl,
//             savedDir: hmsDir.path,
//             fileName: "Document_${DateTime.now().millisecondsSinceEpoch}.pdf",
//             showNotification: true, // show download progress in status bar
//             openFileFromNotification: true, // click notification to open
//             saveInPublicStorage: true, // This attempts to put it in the public Downloads folder
//           );
//
//           if (taskId != null) {
//             DisplaySnackBar.displaySnackBar("Download started...", 3, ColorConst.greenColor);
//           }
//         } catch (e) {
//           DisplaySnackBar.displaySnackBar("Download error: $e", 3, ColorConst.redColor);
//         }
//       } else {
//         DisplaySnackBar.displaySnackBar("Storage permission denied", 3, ColorConst.redColor);
//       }
//     }
//   }
// }

// // import 'dart:io';
// // import 'package:flutter_downloader/flutter_downloader.dart';
// // import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
// // import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
// // import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'package:permission_handler/permission_handler.dart';
// // import 'package:url_launcher/url_launcher.dart';
// // import 'package:path/path.dart' as p;
// //
// // class PDFUtils {
// //   static Future<void> downloadPDF(String url) async {
// //     if (url.isEmpty) {
// //       DisplaySnackBar.displaySnackBar(
// //           "Invalid PDF URL", 3, ColorConst.redColor);
// //       return;
// //     }
// //
// //     // Fix URL if it's using a local domain that needs rewriting
// //     final fixedUrl = StringUtils.fixImageUrl(url);
// //
// //     if (Platform.isIOS) {
// //       final uri = Uri.parse(fixedUrl);
// //       if (await canLaunchUrl(uri)) {
// //         await launchUrl(uri);
// //       } else {
// //         DisplaySnackBar.displaySnackBar(
// //             "Could not open PDF", 3, ColorConst.redColor);
// //       }
// //       return;
// //     }
// //
// //     if (Platform.isAndroid) {
// //       // 1. Request Permissions
// //       // For Android 13+ (SDK 33), WRITE_EXTERNAL_STORAGE is not used
// //       // We check for photos/videos/audio or just hope for the best if it's a public dir
// //       // However, for FlutterDownloader to saveInPublicStorage: true, it often needs permission on older versions.
// //
// //       var status = await Permission.storage.request();
// //       if (!status.isGranted) {
// //         // Try requesting manageExternalStorage if storage failed on newer Androids
// //         if (await Permission.manageExternalStorage.isRestricted) {
// //           // On Android 11+, storage permission might be restricted.
// //         }
// //       }
// //
// //       // 2. Determine saved directory
// //       Directory? directory;
// //       try {
// //         if (Platform.isAndroid) {
// //           directory = Directory('/storage/emulated/0/Download');
// //           if (!await directory.exists()) {
// //             directory = await getExternalStorageDirectory();
// //           }
// //         } else {
// //           directory = await getApplicationDocumentsDirectory();
// //         }
// //       } catch (e) {
// //         directory = await getApplicationDocumentsDirectory();
// //       }
// //
// //       if (directory == null) {
// //         DisplaySnackBar.displaySnackBar(
// //             "Could not access storage", 3, ColorConst.redColor);
// //         return;
// //       }
// //
// //       final hmsDir = Directory(p.join(directory.path, "HMS"));
// //       if (!await hmsDir.exists()) {
// //         await hmsDir.create(recursive: true);
// //       }
// //
// //       // 3. Enqueue download
// //       try {
// //         final taskId = await FlutterDownloader.enqueue(
// //           url: fixedUrl,
// //           savedDir: hmsDir.path,
// //           showNotification: true,
// //           openFileFromNotification: true,
// //           saveInPublicStorage: true,
// //           fileName: "Document_${DateTime.now().millisecondsSinceEpoch}.pdf",
// //         );
// //
// //         if (taskId != null) {
// //           DisplaySnackBar.displaySnackBar(
// //               "Download started...", 3, ColorConst.greenColor);
// //         } else {
// //           throw Exception("Failed to enqueue download");
// //         }
// //       } catch (e) {
// //         print("Download error: $e");
// //         DisplaySnackBar.displaySnackBar(
// //             "Failed to download PDF", 3, ColorConst.redColor);
// //       }
// //     }
// //   }
// // }
// import 'dart:io';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:path/path.dart' as p;
//
// class PDFUtils {
//   static Future<void> downloadPDF(String url) async {
//     if (url.isEmpty) {
//       DisplaySnackBar.displaySnackBar("Invalid PDF URL", 3, ColorConst.redColor);
//       return;
//     }
//
//     final fixedUrl = StringUtils.fixImageUrl(url);
//
//     if (Platform.isIOS) {
//       final uri = Uri.parse(fixedUrl);
//       if (await canLaunchUrl(uri)) {
//         await launchUrl(uri, mode: LaunchMode.externalApplication);
//       } else {
//         DisplaySnackBar.displaySnackBar("Could not open PDF", 3, ColorConst.redColor);
//       }
//       return;
//     }
//
//     if (Platform.isAndroid) {
//       // 1. Handle Permissions for Android
//       if (await Permission.storage.request().isGranted ||
//           await Permission.manageExternalStorage.request().isGranted) {
//
//         // 2. Get a safe directory
//         // Instead of hardcoded '/storage/emulated/0', use path_provider
//         // Directory? baseDir = await getExternalStorageDirectory(); // App-specific external storage
//         //
//         // // If you want it in the public "Downloads" folder specifically,
//         // // you often have to use the package's internal logic or different permissions.
//         // // For now, let's use a safe path:
//         // String savedPath = baseDir!.path;
//         //
//         // final hmsDir = Directory(p.join(savedPath, "HMS"));
//         // if (!await hmsDir.exists()) {
//         //   await hmsDir.create(recursive: true);
//         // }
// // 2. Get a safe directory
//         Directory? baseDir = await getExternalStorageDirectory();
//         String savedPath = baseDir!.path;
//
//         final hmsDir = Directory(p.join(savedPath, "HMS"));
//         if (!await hmsDir.exists()) {
//           await hmsDir.create(recursive: true);
//         }
//         try {
//           final taskId = await FlutterDownloader.enqueue(
//             url: fixedUrl,
//             savedDir: hmsDir.path,
//             fileName: "Document_${DateTime.now().millisecondsSinceEpoch}.pdf",
//             showNotification: true, // show download progress in status bar
//             openFileFromNotification: true, // click notification to open
//             saveInPublicStorage: true, // This attempts to put it in the public Downloads folder
//           );
//
//           if (taskId != null) {
//             DisplaySnackBar.displaySnackBar("Download started...", 3, ColorConst.greenColor);
//           }
//         } catch (e) {
//           DisplaySnackBar.displaySnackBar("Download error: $e", 3, ColorConst.redColor);
//         }
//       } else {
//         DisplaySnackBar.displaySnackBar("Storage permission denied", 3, ColorConst.redColor);
//       }
//     }
//   }
// }
// import 'dart:io';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:path/path.dart' as p;
//
// class PDFUtils {
//   static Future<void> downloadPDF(String url) async {
//     if (url.isEmpty) {
//       DisplaySnackBar.displaySnackBar("Invalid PDF URL", 3, ColorConst.redColor);
//       return;
//     }
//
//     final fixedUrl = StringUtils.fixImageUrl(url);
//
//     if (Platform.isIOS) {
//       final uri = Uri.parse(fixedUrl);
//       if (await canLaunchUrl(uri)) {
//         await launchUrl(uri, mode: LaunchMode.externalApplication);
//       } else {
//         DisplaySnackBar.displaySnackBar("Could not open PDF", 3, ColorConst.redColor);
//       }
//       return;
//     }
//
//     if (Platform.isAndroid) {
//       bool hasPermission = await _requestPermissions();
//
//       if (hasPermission) {
//         // 2. Get a safe directory
//         Directory? baseDir = await getExternalStorageDirectory();
//
//         if (baseDir == null) {
//           DisplaySnackBar.displaySnackBar("Could not access storage", 3, ColorConst.redColor);
//           return;
//         }
//
//         String savedPath = baseDir.path;
//
//         final hmsDir = Directory(p.join(savedPath, "HMS"));
//         if (!await hmsDir.exists()) {
//           await hmsDir.create(recursive: true);
//         }
//
//         try {
//           final taskId = await FlutterDownloader.enqueue(
//             url: fixedUrl,
//             savedDir: hmsDir.path,
//             fileName: "Document_${DateTime.now().millisecondsSinceEpoch}.pdf",
//             showNotification: true, // show download progress in status bar
//             openFileFromNotification: true, // click notification to open
//             saveInPublicStorage: true, // Moves it to the public Downloads folder
//           );
//
//           if (taskId != null) {
//             DisplaySnackBar.displaySnackBar("Download started...", 3, ColorConst.greenColor);
//           }
//         } catch (e) {
//           DisplaySnackBar.displaySnackBar("Download error: $e", 3, ColorConst.redColor);
//         }
//       } else {
//         DisplaySnackBar.displaySnackBar("Permissions required to download files", 3, ColorConst.redColor);
//       }
//     }
//   }
//
//   /// Handles permissions dynamically based on the Android version
//   static Future<bool> _requestPermissions() async {
//     if (Platform.isAndroid) {
//       final androidInfo = await DeviceInfoPlugin().androidInfo;
//
//       // Request Notification Permission (Required for Android 13+)
//       if (androidInfo.version.sdkInt >= 33) {
//         var notificationStatus = await Permission.notification.request();
//         // On Android 13+, we don't need WRITE_EXTERNAL_STORAGE to save to public directories
//         return notificationStatus.isGranted || notificationStatus.isLimited;
//       }
//       // For Android 12 and below
//       else {
//         var storageStatus = await Permission.storage.request();
//         return storageStatus.isGranted;
//       }
//     }
//     return true;
//   }
// }
// import 'dart:io';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:Sujatha_patient/component/common_snackbar.dart';
// import 'package:Sujatha_patient/constant/color_const.dart';
// import 'package:Sujatha_patient/utils/string_utils.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:path/path.dart' as p;
//
// class PDFUtils {
//   static Future<void> downloadPDF(String url) async {
//     if (url.isEmpty) {
//       DisplaySnackBar.displaySnackBar("Invalid PDF URL", 3, ColorConst.redColor);
//       return;
//     }
//
//     final fixedUrl = StringUtils.fixImageUrl(url);
//
//     // --- iOS Logic ---
//     if (Platform.isIOS) {
//       final uri = Uri.parse(fixedUrl);
//       if (await canLaunchUrl(uri)) {
//         await launchUrl(uri, mode: LaunchMode.externalApplication);
//       } else {
//         DisplaySnackBar.displaySnackBar("Could not open PDF", 3, ColorConst.redColor);
//       }
//       return;
//     }
//
//     // --- Android Logic ---
//     if (Platform.isAndroid) {
//       bool hasPermission = await _requestPermissions();
//
//       if (hasPermission) {
//         // Use App-specific external storage (Safest for all Android versions)
//         Directory? baseDir = await getExternalStorageDirectory();
//
//         if (baseDir == null) {
//           DisplaySnackBar.displaySnackBar("Could not access storage", 3, ColorConst.redColor);
//           return;
//         }
//
//         String savedPath = baseDir.path;
//         final hmsDir = Directory(p.join(savedPath, "HMS"));
//
//         if (!await hmsDir.exists()) {
//           await hmsDir.create(recursive: true);
//         }
//
//         try {
//           final taskId = await FlutterDownloader.enqueue(
//             url: fixedUrl,
//             savedDir: hmsDir.path,
//             fileName: "Document_${DateTime.now().millisecondsSinceEpoch}.pdf",
//             showNotification: true,
//             openFileFromNotification: true,
//             // Setting this to FALSE is much safer on strict devices.
//             // The user can still open the PDF by tapping the notification.
//             saveInPublicStorage: false,
//           );
//
//           if (taskId != null) {
//             DisplaySnackBar.displaySnackBar("Download started...", 3, ColorConst.greenColor);
//           }
//         } catch (e) {
//           DisplaySnackBar.displaySnackBar("Download error: $e", 3, ColorConst.redColor);
//         }
//       }
//     }
//   }
//
//   /// Bulletproof Permission Handler for Android
//   static Future<bool> _requestPermissions() async {
//     if (Platform.isAndroid) {
//       final androidInfo = await DeviceInfoPlugin().androidInfo;
//
//       // Android 13+ (API 33+)
//       if (androidInfo.version.sdkInt >= 33) {
//         var notificationStatus = await Permission.notification.request();
//
//         if (notificationStatus.isPermanentlyDenied) {
//           DisplaySnackBar.displaySnackBar("Please allow notifications to see download progress", 3, ColorConst.redColor);
//           await openAppSettings();
//           return false;
//         }
//         return notificationStatus.isGranted || notificationStatus.isLimited;
//       }
//       // Android 12 and below (API < 33)
//       else {
//         var storageStatus = await Permission.storage.request();
//
//         if (storageStatus.isGranted) {
//           return true;
//         } else if (storageStatus.isPermanentlyDenied) {
//           // THIS fixes the "some mobiles" issue. If the phone blocks the popup, we route them to settings.
//           DisplaySnackBar.displaySnackBar("Storage permission is required. Please enable it in Settings.", 4, ColorConst.redColor);
//           await Future.delayed(const Duration(seconds: 1)); // Small delay so they read the snackbar
//           await openAppSettings();
//           return false;
//         } else {
//           DisplaySnackBar.displaySnackBar("Storage permission denied", 3, ColorConst.redColor);
//           return false;
//         }
//       }
//     }
//     return true;
//   }
// }
// import 'dart:io';
// import 'dart:isolate';
// import 'dart:ui';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:Sujatha_patient/component/common_snackbar.dart';
// import 'package:Sujatha_patient/constant/color_const.dart';
// import 'package:Sujatha_patient/utils/string_utils.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:path/path.dart' as p;
// import 'package:open_file_plus/open_file_plus.dart';
//
// class PDFUtils {
//   static ReceivePort? _port;
//   static bool _isListening = false;
//
//   /// Call this ONCE in your main.dart (inside main function) after FlutterDownloader.initialize()
//   /// Example:
//   /// await FlutterDownloader.initialize();
//   /// PDFUtils.initDownloaderListener();
//   static void initDownloaderListener() {
//     if (_isListening) return;
//
//     _port = ReceivePort();
//     IsolateNameServer.registerPortWithName(_port!.sendPort, 'downloader_send_port');
//
//     _port!.listen((dynamic data) async {
//       String id = data[0];
//       DownloadTaskStatus status = DownloadTaskStatus(data[1]);
//       int progress = data[2];
//
//       if (status == DownloadTaskStatus.complete) {
//         // Find the completed task to get its saved directory and filename
//         final tasks = await FlutterDownloader.loadTasks();
//         final task = tasks?.firstWhere((task) => task.taskId == id);
//
//         if (task != null && task.status == DownloadTaskStatus.complete) {
//           String filePath = p.join(task.savedDir, task.filename);
//
//           // Open the file immediately on the screen
//           final result = await OpenFile.open(filePath);
//           if (result.type != ResultType.done) {
//             DisplaySnackBar.displaySnackBar("Could not open PDF. No PDF viewer installed.", 3, ColorConst.redColor);
//           }
//         }
//       } else if (status == DownloadTaskStatus.failed) {
//         DisplaySnackBar.displaySnackBar("Download failed", 3, ColorConst.redColor);
//       }
//     });
//
//     FlutterDownloader.registerCallback(downloadCallback);
//     _isListening = true;
//   }
//
//   /// Required static callback for FlutterDownloader
//   @pragma('vm:entry-point')
//   static void downloadCallback(String id, int status, int progress) {
//     final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
//     send?.send([id, status, progress]);
//   }
//
//   /// Main method to trigger the download
//   static Future<void> downloadPDF(String url) async {
//     if (url.isEmpty) {
//       DisplaySnackBar.displaySnackBar("Invalid PDF URL", 3, ColorConst.redColor);
//       return;
//     }
//
//     final fixedUrl = StringUtils.fixImageUrl(url);
//
//     // --- iOS Logic ---
//     if (Platform.isIOS) {
//       final uri = Uri.parse(fixedUrl);
//       if (await canLaunchUrl(uri)) {
//         await launchUrl(uri, mode: LaunchMode.externalApplication);
//       } else {
//         DisplaySnackBar.displaySnackBar("Could not open PDF", 3, ColorConst.redColor);
//       }
//       return;
//     }
//
//     // --- Android Logic ---
//     if (Platform.isAndroid) {
//       bool hasPermission = await _requestPermissions();
//
//       if (hasPermission) {
//         // Use App-specific external storage (Safest for all Android versions)
//         Directory? baseDir = await getExternalStorageDirectory();
//
//         if (baseDir == null) {
//           DisplaySnackBar.displaySnackBar("Could not access storage", 3, ColorConst.redColor);
//           return;
//         }
//
//         String savedPath = baseDir.path;
//         final hmsDir = Directory(p.join(savedPath, "HMS"));
//
//         if (!await hmsDir.exists()) {
//           await hmsDir.create(recursive: true);
//         }
//
//         try {
//           // Make sure listener is initialized in case they forgot to put it in main.dart
//           initDownloaderListener();
//
//           final taskId = await FlutterDownloader.enqueue(
//             url: fixedUrl,
//             savedDir: hmsDir.path,
//             fileName: "Document_${DateTime.now().millisecondsSinceEpoch}.pdf",
//             showNotification: true,
//             openFileFromNotification: true,
//             saveInPublicStorage: false, // Keep false for maximum device compatibility
//           );
//
//           if (taskId != null) {
//             DisplaySnackBar.displaySnackBar("Downloading PDF...", 2, ColorConst.greenColor);
//           }
//         } catch (e) {
//           DisplaySnackBar.displaySnackBar("Download error: $e", 3, ColorConst.redColor);
//         }
//       }
//     }
//   }
//
//   /// Bulletproof Permission Handler for Android
//   static Future<bool> _requestPermissions() async {
//     if (Platform.isAndroid) {
//       final androidInfo = await DeviceInfoPlugin().androidInfo;
//
//       // Android 13+ (API 33+)
//       if (androidInfo.version.sdkInt >= 33) {
//         var notificationStatus = await Permission.notification.request();
//
//         if (notificationStatus.isPermanentlyDenied) {
//           DisplaySnackBar.displaySnackBar("Please allow notifications to see download progress", 3, ColorConst.redColor);
//           await openAppSettings();
//           return false;
//         }
//         return notificationStatus.isGranted || notificationStatus.isLimited;
//       }
//       // Android 12 and below (API < 33)
//       else {
//         var storageStatus = await Permission.storage.request();
//
//         if (storageStatus.isGranted) {
//           return true;
//         } else if (storageStatus.isPermanentlyDenied) {
//           DisplaySnackBar.displaySnackBar("Storage permission is required. Please enable it in Settings.", 4, ColorConst.redColor);
//           await Future.delayed(const Duration(seconds: 1));
//           await openAppSettings();
//           return false;
//         } else {
//           DisplaySnackBar.displaySnackBar("Storage permission denied", 3, ColorConst.redColor);
//           return false;
//         }
//       }
//     }
//     return true;
//   }
//
//   /// Clean up ports when app closes
//   static void dispose() {
//     IsolateNameServer.removePortNameMapping('downloader_send_port');
//     _port?.close();
//     _isListening = false;
//   }
// }
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart' as p;

// 1. Updated Import to use open_filex
import 'package:open_filex/open_filex.dart';

class PDFUtils {
  static ReceivePort? _port;
  static bool _isListening = false;

  /// Call this ONCE in your main.dart (inside main function) after FlutterDownloader.initialize()
  static void initDownloaderListener() {
    if (_isListening) return;

    _port = ReceivePort();
    IsolateNameServer.registerPortWithName(_port!.sendPort, 'downloader_send_port');

    _port!.listen((dynamic data) async {
      String id = data[0];
      int statusInt = data[1]; // Get the raw integer
      int progress = data[2];

      // safely convert the integer using the package's built-in fromInt method
      DownloadTaskStatus status = DownloadTaskStatus.fromInt(statusInt);

      if (status == DownloadTaskStatus.complete) {
        // Find the completed task to get its saved directory and filename
        final tasks = await FlutterDownloader.loadTasks();
        final task = tasks?.firstWhere((task) => task.taskId == id);

        if (task != null) {
          String filePath = p.join(task.savedDir, task.filename);

          // 2. Updated class name to OpenFilex
          final result = await OpenFilex.open(filePath);

          if (result.type != ResultType.done) {
            DisplaySnackBar.displaySnackBar("Could not open PDF. No PDF viewer installed.", 3, ColorConst.redColor);
          }
        }
      } else if (status == DownloadTaskStatus.failed) {
        DisplaySnackBar.displaySnackBar("Download failed", 3, ColorConst.redColor);
      }
    });
    FlutterDownloader.registerCallback(downloadCallback);
    _isListening = true;
  }

  /// Required static callback for FlutterDownloader
  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  /// Main method to trigger the download
  static Future<void> downloadPDF(String url) async {
    if (url.isEmpty) {
      DisplaySnackBar.displaySnackBar("Invalid PDF URL", 3, ColorConst.redColor);
      return;
    }

    final fixedUrl = StringUtils.fixImageUrl(url);

    // --- iOS Logic ---
    if (Platform.isIOS) {
      final uri = Uri.parse(fixedUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        DisplaySnackBar.displaySnackBar("Could not open PDF", 3, ColorConst.redColor);
      }
      return;
    }

    // --- Android Logic ---
    if (Platform.isAndroid) {
      bool hasPermission = await _requestPermissions();

      if (hasPermission) {
        // Use App-specific external storage (Safest for all Android versions)
        Directory? baseDir = await getExternalStorageDirectory();

        if (baseDir == null) {
          DisplaySnackBar.displaySnackBar("Could not access storage", 3, ColorConst.redColor);
          return;
        }

        String savedPath = baseDir.path;
        final hmsDir = Directory(p.join(savedPath, "HMS"));

        if (!await hmsDir.exists()) {
          await hmsDir.create(recursive: true);
        }

        try {
          // Make sure listener is initialized in case they forgot to put it in main.dart
          initDownloaderListener();

          final taskId = await FlutterDownloader.enqueue(
            url: fixedUrl,
            savedDir: hmsDir.path,
            fileName: "Document_${DateTime.now().millisecondsSinceEpoch}.pdf",
            showNotification: true,
            openFileFromNotification: true,
            saveInPublicStorage: false, // Keep false for maximum device compatibility
          );

          if (taskId != null) {
            DisplaySnackBar.displaySnackBar("Downloading PDF...", 2, ColorConst.greenColor);
          }
        } catch (e) {
          DisplaySnackBar.displaySnackBar("Download error: $e", 3, ColorConst.redColor);
        }
      }
    }
  }

  /// Bulletproof Permission Handler for Android
  static Future<bool> _requestPermissions() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;

      // Android 13+ (API 33+)
      if (androidInfo.version.sdkInt >= 33) {
        var notificationStatus = await Permission.notification.request();

        if (notificationStatus.isPermanentlyDenied) {
          DisplaySnackBar.displaySnackBar("Please allow notifications to see download progress", 3, ColorConst.redColor);
          await openAppSettings();
          return false;
        }
        return notificationStatus.isGranted || notificationStatus.isLimited;
      }
      // Android 12 and below (API < 33)
      else {
        var storageStatus = await Permission.storage.request();

        if (storageStatus.isGranted) {
          return true;
        } else if (storageStatus.isPermanentlyDenied) {
          DisplaySnackBar.displaySnackBar("Storage permission is required. Please enable it in Settings.", 4, ColorConst.redColor);
          await Future.delayed(const Duration(seconds: 1));
          await openAppSettings();
          return false;
        } else {
          DisplaySnackBar.displaySnackBar("Storage permission denied", 3, ColorConst.redColor);
          return false;
        }
      }
    }
    return true;
  }

  /// Clean up ports when app closes
  static void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    _port?.close();
    _isListening = false;
  }
}