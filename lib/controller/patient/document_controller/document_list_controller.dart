// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_button.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_loader.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_document_model/doctor_documents_crud_model.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_document_model/doctor_documents_model.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/documents_model/document_delete_model/document_delete.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/documents_model/documents_model/documents.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/pdf_utils.dart';
//
// @pragma('vm:entry-point')
// class DocumentController extends GetxController {
//   DocumentsModel? documentsModel;
//   DoctorDocumentsModel? doctorDocumentsModel;
//   RxBool gotData = false.obs;
//
//   int? currentIndex;
//
//   List<RxBool> isCurrentDownloading = <RxBool>[];
//
//   RxInt progress = 0.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     if (PreferenceUtils.getStringValue("role") == "Doctor") {
//       getDoctorDocuments();
//     } else {
//       getDocuments();
//     }
//   }
//
//   void downloadDocument(context, int index) async {
//     if (!isCurrentDownloading.any((e) => e.value)) {
//       currentIndex = index;
//       String url;
//       if (PreferenceUtils.getStringValue("role") == "Doctor") {
//         url = doctorDocumentsModel?.data?[index].document_url ?? "";
//       } else {
//         url = documentsModel?.data?[index].document_url ?? "";
//       }
//       currentIndex = index;
//       isCurrentDownloading[index].value = true;
//       try {
//         await PDFUtils.downloadPDF(url);
//       } finally {
//         isCurrentDownloading[index].value = false;
//       }
//     }
//   }
//
//   void showDeleteDialog(context, double height, double width, int index) {
//     showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (BuildContext contextOfDialog) {
//         return Center(
//           child: Container(
//             height: height / 2.6,
//             width: width / 1.12,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15),
//               color: Colors.white,
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   height: 60,
//                   width: 60,
//                   decoration: const BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage(ImageUtils.deleteIcon),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: height * 0.03),
//                 Text(
//                   "Delete",
//                   style: TextStyleConst.boldTextStyle(
//                     ColorConst.blackColor,
//                     width * 0.05,
//                   ),
//                 ),
//                 SizedBox(height: height * 0.01),
//                 Text(
//                   "Are you sure want to delete this\n document?",
//                   textAlign: TextAlign.center,
//                   style: TextStyleConst.mediumTextStyle(
//                     ColorConst.hintGreyColor,
//                     width * 0.042,
//                   ),
//                 ),
//                 SizedBox(height: height * 0.03),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     CommonButton(
//                       textStyleConst: TextStyleConst.mediumTextStyle(
//                         ColorConst.whiteColor,
//                         width * 0.05,
//                       ),
//                       onTap: () {
//                         Get.back();
//                         if (PreferenceUtils.getStringValue("role") ==
//                             "Doctor") {
//                           deleteDoctorDocument(
//                               doctorDocumentsModel?.data?[index].id ?? 0);
//                         } else {
//                           deleteDocData(documentsModel?.data?[index].id ?? 0);
//                         }
//                       },
//                       color: ColorConst.blueColor,
//                       text: StringUtils.delete,
//                       width: width / 2.5,
//                       height: 50,
//                     ),
//                     CommonButton(
//                       textStyleConst: TextStyleConst.mediumTextStyle(
//                         ColorConst.hintGreyColor,
//                         width * 0.05,
//                       ),
//                       onTap: () {
//                         Get.back();
//                       },
//                       color: ColorConst.borderGreyColor,
//                       text: StringUtils.cancel,
//                       width: width / 2.5,
//                       height: 50,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   void deleteDocData(int id) {
//     CommonLoader.showLoader();
//     StringUtils.client
//         .deleteDocument(PreferenceUtils.getStringValue("token"), id)
//       ..then((value) {
//         Get.back();
//         DisplaySnackBar.displaySnackBar(
//             "Document has been deleted", 3, ColorConst.redColor);
//         getDocuments();
//       })
//       ..onError((DioException error, stackTrace) {
//         Get.back();
//         CheckSocketException.checkSocketException(error);
//         return DocumentDeleteModel();
//       });
//   }
//
//   void getDocuments() {
//     gotData.value = false;
//     StringUtils.client
//         .getDocuments(PreferenceUtils.getStringValue("token"))
//         .then((value) {
//       documentsModel = value;
//       isCurrentDownloading = List.generate(value.data?.length ?? 1, (index) {
//         return false.obs;
//       });
//       gotData.value = true;
//     }).onError((DioException error, stackTrace) {
//       documentsModel = DocumentsModel();
//       gotData.value = true;
//       CheckSocketException.checkSocketException(error);
//     });
//   }
//
//   /// Doctor administration
//
//   void getDoctorDocuments() {
//     gotData.value = false;
//     StringUtils.client
//         .doctorDocuments(PreferenceUtils.getStringValue("token"))
//         .then((value) {
//       doctorDocumentsModel = value;
//       isCurrentDownloading = List.generate(value.data?.length ?? 1, (index) {
//         return false.obs;
//       });
//       gotData.value = true;
//     }).onError((error, stackTrace) {
//       doctorDocumentsModel = DoctorDocumentsModel();
//       gotData.value = true;
//       //return DoctorDocumentsModel();
//     });
//   }
//
//   void deleteDoctorDocument(int id) {
//     CommonLoader.showLoader();
//     StringUtils.client.deleteDoctorDocuments(
//         PreferenceUtils.getStringValue("token"), id.toString())
//       ..then((value) {
//         Get.back();
//         DisplaySnackBar.displaySnackBar(
//             "Document has been deleted", 3, ColorConst.redColor);
//         getDoctorDocuments();
//       })
//       ..onError((DioException error, stackTrace) {
//         Get.back();
//         CheckSocketException.checkSocketException(error);
//         return DoctorDocumentsCRUDModel();
//       });
//   }
//
//   @override
//   void onClose() {
//     super.onClose();
//   }
// }
import 'dart:isolate';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_button.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_loader.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_document_model/doctor_documents_crud_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_document_model/doctor_documents_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/documents_model/document_delete_model/document_delete.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/documents_model/documents_model/documents.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/pdf_utils.dart';

@pragma('vm:entry-point')
class DocumentController extends GetxController {
  DocumentsModel? documentsModel;
  DoctorDocumentsModel? doctorDocumentsModel;
  RxBool gotData = false.obs;

  int? currentIndex;

  List<RxBool> isCurrentDownloading = <RxBool>[];

  RxInt progress = 0.obs;

  // Added ReceivePort for background downloading progress
  final ReceivePort _port = ReceivePort();

  @override
  void onInit() {
    super.onInit();

    // --- BACKGROUND DOWNLOADER PORT REGISTRATION ---
    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      int status = data[1];
      // int progress = data[2]; // You can use this later to update UI progress if needed

      if (status == 3) { // 3 means DownloadTaskStatus.complete
        FlutterDownloader.open(taskId: id); // Open the PDF automatically!
      }
    });

    FlutterDownloader.registerCallback(downloadCallback);
    // -----------------------------------------------

    if (PreferenceUtils.getStringValue("role") == "Doctor") {
      getDoctorDocuments();
    } else {
      getDocuments();
    }
  }

  // --- ADDED CALLBACK METHOD ---
  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  void downloadDocument(context, int index) async {
    if (!isCurrentDownloading.any((e) => e.value)) {
      currentIndex = index;
      String url;
      if (PreferenceUtils.getStringValue("role") == "Doctor") {
        url = doctorDocumentsModel?.data?[index].document_url ?? "";
      } else {
        url = documentsModel?.data?[index].document_url ?? "";
      }
      currentIndex = index;
      isCurrentDownloading[index].value = true;
      try {
        await PDFUtils.downloadPDF(url);
      } finally {
        isCurrentDownloading[index].value = false;
      }
    }
  }

  void showDeleteDialog(context, double height, double width, int index) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext contextOfDialog) {
        return Center(
          child: Container(
            height: height / 2.6,
            width: width / 1.12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImageUtils.deleteIcon),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.03),
                Text(
                  "Delete",
                  style: TextStyleConst.boldTextStyle(
                    ColorConst.blackColor,
                    width * 0.05,
                  ),
                ),
                SizedBox(height: height * 0.01),
                Text(
                  "Are you sure want to delete this\n document?",
                  textAlign: TextAlign.center,
                  style: TextStyleConst.mediumTextStyle(
                    ColorConst.hintGreyColor,
                    width * 0.042,
                  ),
                ),
                SizedBox(height: height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CommonButton(
                      textStyleConst: TextStyleConst.mediumTextStyle(
                        ColorConst.whiteColor,
                        width * 0.05,
                      ),
                      onTap: () {
                        Get.back();
                        if (PreferenceUtils.getStringValue("role") ==
                            "Doctor") {
                          deleteDoctorDocument(
                              doctorDocumentsModel?.data?[index].id ?? 0);
                        } else {
                          deleteDocData(documentsModel?.data?[index].id ?? 0);
                        }
                      },
                      color: ColorConst.blueColor,
                      text: StringUtils.delete,
                      width: width / 2.5,
                      height: 50,
                    ),
                    CommonButton(
                      textStyleConst: TextStyleConst.mediumTextStyle(
                        ColorConst.hintGreyColor,
                        width * 0.05,
                      ),
                      onTap: () {
                        Get.back();
                      },
                      color: ColorConst.borderGreyColor,
                      text: StringUtils.cancel,
                      width: width / 2.5,
                      height: 50,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void deleteDocData(int id) {
    CommonLoader.showLoader();
    StringUtils.client
        .deleteDocument(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        CommonLoader.hideLoader();
        DisplaySnackBar.displaySnackBar(
            "Document has been deleted", 3, ColorConst.redColor);
        getDocuments();
      })
      ..onError((DioException error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return DocumentDeleteModel();
      });
  }

  void getDocuments() {
    gotData.value = false;
    StringUtils.client
        .getDocuments(PreferenceUtils.getStringValue("token"))
        .then((value) {
      documentsModel = value;
      isCurrentDownloading = List.generate(value.data?.length ?? 1, (index) {
        return false.obs;
      });
      gotData.value = true;
    }).onError((DioException error, stackTrace) {
      documentsModel = DocumentsModel();
      gotData.value = true;
      CheckSocketException.checkSocketException(error);
    });
  }

  /// Doctor administration

  void getDoctorDocuments() {
    gotData.value = false;
    StringUtils.client
        .doctorDocuments(PreferenceUtils.getStringValue("token"))
        .then((value) {
      doctorDocumentsModel = value;
      isCurrentDownloading = List.generate(value.data?.length ?? 1, (index) {
        return false.obs;
      });
      gotData.value = true;
    }).onError((error, stackTrace) {
      doctorDocumentsModel = DoctorDocumentsModel();
      gotData.value = true;
    });
  }

  void deleteDoctorDocument(int id) {
    CommonLoader.showLoader();
    StringUtils.client.deleteDoctorDocuments(
        PreferenceUtils.getStringValue("token"), id.toString())
      ..then((value) {
        CommonLoader.hideLoader();
        DisplaySnackBar.displaySnackBar(
            "Document has been deleted", 3, ColorConst.redColor);
        getDoctorDocuments();
      })
      ..onError((DioException error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return DoctorDocumentsCRUDModel();
      });
  }

  @override
  void onClose() {
    // --- Added Cleanup for background port ---
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    _port.close();
    // -----------------------------------------
    super.onClose();
  }
}