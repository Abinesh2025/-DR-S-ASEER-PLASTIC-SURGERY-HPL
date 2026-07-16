import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_loader.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_document_model/doctor_documents_crud_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_document_model/doctor_documents_type_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_document_model/doctor_patients_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/documents_model/document_store_model/document_store.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/documents_model/documents_type_model/documents_type.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class NewDocumentController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  DocumentsTypeModel? documentsTypeModel;

  DoctorDocumentsTypeModel? doctorDocumentsTypeModel;
  DoctorPatientsDocumentsModel? doctorPatientsDocumentsModel;
  final TextEditingController searchPatientController = TextEditingController();
  RxnString selectedDocId = RxnString();
  ImagePicker imagePicker = ImagePicker();
  Rx<XFile?> file = XFile("").obs;
  RxBool showFile = false.obs;
  RxBool gotData = false.obs;

  RxnString selectedPatientId = RxnString();

  pickImage() async {
    file.value = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 1024,
      maxHeight: 1024,
    );
    if ((file.value?.path ?? "") != "") {
      showFile.value = true;
      update();
    }
  }
// Add this inside your NewDocumentController class
  void onPatientSearch(String value) {
    // Optional: Add debounce logic here if you want to limit API calls
    getPatients(searchQuery: value);
  }
  void getDocumentTypes() {
    StringUtils.client.getDocumentsType(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        documentsTypeModel = value;
        gotData.value = true;
      })
      ..onError((DioException error, stackTrace) {
        gotData.value = true;
        CheckSocketException.checkSocketException(error);
        return DocumentsTypeModel();
      });
  }

  void createDocuments() {
    if (titleController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar(
          "Please enter title", 3, ColorConst.redColor);
    } else if (selectedDocId.value == null) {
      DisplaySnackBar.displaySnackBar(
          "Please select document type", 3, ColorConst.redColor);
    } else if (file.value!.path == "") {
      DisplaySnackBar.displaySnackBar(
          "Please attach file", 3, ColorConst.redColor);
    } else if (notesController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar(
          "Please enter notes", 3, ColorConst.redColor);
    } else {
      if (PreferenceUtils.getStringValue("role") == "Doctor") {
        if (selectedPatientId.value == null) {
          DisplaySnackBar.displaySnackBar(
              "Please select patient", 3, ColorConst.redColor);
        } else {
          CommonLoader.showLoader();
          StringUtils.client.createNewDoctorDocument(
            PreferenceUtils.getStringValue("token"),
            titleController.text.trim(),
            selectedDocId.value ?? "",
            selectedPatientId.value ?? "",
            file.value!.path == "" ? null : File(file.value?.path ?? ""),
            notesController.text,
          )
            ..then((value) {
              CommonLoader.hideLoader();
              if (value.success == true) {
                Get.back(result: "Call API");
                DisplaySnackBar.displaySnackBar(
                    "Document uploaded successfully", 3, ColorConst.greenColor);
              } else {
                DisplaySnackBar.displaySnackBar(
                    value.message ?? "Something went wrong", 3, ColorConst.redColor);
              }
            })
            ..onError((DioException error, stackTrace) {
              CheckSocketException.checkSocketException(error);
              return DoctorDocumentsCRUDModel();
            });
        }
      } else {
        CommonLoader.showLoader();
        StringUtils.client.storeDocument(
          PreferenceUtils.getStringValue("token"),
          titleController.text.trim(),
          selectedDocId.value ?? "",
          notesController.text.trim(),
          File(file.value?.path ?? ""),
        )
          ..then((value) {
            CommonLoader.hideLoader();
            if (value.success == true) {
              Get.back(result: "Call API");
              DisplaySnackBar.displaySnackBar(
                  "Document uploaded successfully", 3, ColorConst.greenColor);
            } else {
              DisplaySnackBar.displaySnackBar(
                  value.message ?? "Something went wrong", 3, ColorConst.redColor);
            }
          })
          ..onError((DioException error, stackTrace) {
            CheckSocketException.checkSocketException(error);
            return DocumentStoreModel();
          });
      }
    }
  }

  /// doctor
  void getDoctorDocumentsType() {
    StringUtils.client
        .doctorDocumentType(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        doctorDocumentsTypeModel = value;
        getPatients();
      })
      ..onError((DioException error, stackTrace) {
        getPatients();
        CheckSocketException.checkSocketException(error);
        return DoctorDocumentsTypeModel();
      });
  }

  void getPatients({String? searchQuery}) {
    StringUtils.client
        .doctorPatientsDocument(PreferenceUtils.getStringValue("token"),searchQuery,)
      ..then((value) {
        doctorPatientsDocumentsModel = value;
        gotData.value = true;
      })
      ..onError((DioException error, stackTrace) {
        gotData.value = true;
        return DoctorPatientsDocumentsModel();
      });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (PreferenceUtils.getStringValue("role") == "Doctor") {
      getDoctorDocumentsType();
    } else {
      getDocumentTypes();
    }
  }
}
