import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_loader.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_document_model/doctor_documents_crud_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_document_model/doctor_documents_type_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/documents_model/document_update_model/document_update.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/documents_model/documents_type_model/documents_type.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class EditDocumentController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  DocumentsTypeModel? documentsTypeModel;
  DoctorDocumentsTypeModel? doctorDocumentsTypeModel;

  RxBool gotData = false.obs;

  var arguments = Get.arguments;
  String? docTypeId;
  ImagePicker imagePicker = ImagePicker();
  Rx<XFile?> file = XFile("").obs;
  String filePath = "";
  RxBool showFile = false.obs;

  String? patientId;

  void pickImage(BuildContext context) async {
    try {
      file.value = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxWidth: 1024,
        maxHeight: 1024,
      );
    } catch (e) {
      DisplaySnackBar.displaySnackBar(
          "Please give access to photos from settings", 5);
    }

    if ((file.value?.path ?? "") != "") {
      showFile.value = true;
      update();
    }
  }

  void getDocumentTypes() {
    StringUtils.client.getDocumentsType(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        documentsTypeModel = value;
        titleController.text = arguments["title"];
        notesController.text = arguments["note"];
        docTypeId = "${arguments["docType"]}";
        filePath = arguments["attachment"];
        gotData.value = true;
      })
      ..onError((DioException error, stackTrace) {
        gotData.value = true;
        return DocumentsTypeModel();
      });
  }

  void editDocuments(int documentId) {
    if (titleController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar(
          "Please enter title", 3, ColorConst.redColor);
    } else if (docTypeId == null) {
      DisplaySnackBar.displaySnackBar(
          "Please select document type", 3, ColorConst.redColor);
    } else if (notesController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar(
          "Please enter notes", 3, ColorConst.redColor);
    } else {
      if (PreferenceUtils.getStringValue("role") == "Doctor") {
        CommonLoader.showLoader();

        StringUtils.client.updateDoctorsDocuments(
          PreferenceUtils.getStringValue("token"),
          documentId.toString(),
          titleController.text.trim(),
          docTypeId ?? "",
          patientId ?? "",
          file.value!.path == "" ? null : File(file.value?.path ?? ""),
          notesController.text,
        )
          ..then((value) {
            CommonLoader.hideLoader();
            Get.back(result: "Call API");
            DisplaySnackBar.displaySnackBar(
                "Document updated successfully", 3, ColorConst.greenColor);
          })
          ..onError((DioException error, stackTrace) {
            CheckSocketException.checkSocketException(error);
            return DoctorDocumentsCRUDModel();
          });
      } else {
        CommonLoader.showLoader();
        StringUtils.client.updateDocument(
          PreferenceUtils.getStringValue("token"),
          titleController.text.trim(),
          docTypeId ?? "",
          notesController.text.trim(),
          file.value!.path == "" ? null : File(file.value?.path ?? ""),
          documentId,
        )
          ..then((value) {
            CommonLoader.hideLoader();
            if (value.success == true) {
              Get.back(result: "Call API");
              DisplaySnackBar.displaySnackBar(
                  "Document updated successfully", 3, ColorConst.greenColor);
            } else {
              DisplaySnackBar.displaySnackBar(
                  value.message ?? "Something went wrong", 3, ColorConst.redColor);
            }
          })
          ..onError((DioException error, stackTrace) {
            CheckSocketException.checkSocketException(error);
            return DocumentUpdateModel();
          });
      }
    }
  }

  /// doctor
  void getDoctorsDocumentType() {
    StringUtils.client
        .doctorDocumentType(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        doctorDocumentsTypeModel = value;
        titleController.text = arguments["title"];
        notesController.text = arguments["note"];
        docTypeId = "${arguments["docType"]}";
        filePath = arguments["attachment"];
        patientId = arguments["patientId"];
        gotData.value = true;
      })
      ..onError((error, stackTrace) {
        gotData.value = true;
        return DoctorDocumentsTypeModel();
      });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (PreferenceUtils.getStringValue("role") == "Doctor") {
      getDoctorsDocumentType();
    } else {
      getDocumentTypes();
    }
  }
}
