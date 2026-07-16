import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_app_bar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_button.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_dropdown_button.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_required_text.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_text_field.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/document_controller/new_document_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class NewDocumentScreen extends StatelessWidget {
  NewDocumentScreen({Key? key}) : super(key: key);
  final NewDocumentController newDocumentController =
  Get.put(NewDocumentController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CommonAppBar(
            title: StringUtils.newDocument,
            leadOnTap: () {
              Get.back();
            },
            leadIcon: const Icon(
              Icons.arrow_back_rounded,
              color: ColorConst.blackColor,
            ),
          ),
          body: Obx(() {
            return newDocumentController.gotData.value == false
                ? const Center(child: CircularProgressIndicator())
                : Padding(
              padding:
              const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 15,
                        spreadRadius: 2,
                        offset: const Offset(0, 5),
                      )
                    ],
                    border: Border.all(color: Colors.grey.shade100),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonRequiredText(
                          width: width, text: StringUtils.title),
                      SizedBox(height: height * 0.01),
                      CommonTextField(
                        validator: (value) {
                          return null;
                        },
                        controller: newDocumentController.titleController,
                      ),
                      SizedBox(height: height * 0.02),
                      CommonRequiredText(
                          width: width, text: StringUtils.documentType),
                      SizedBox(height: height * 0.01),

                      /// Document Type
                      PreferenceUtils.getStringValue("role") == "Doctor"
                          ? CommonDropDown(
                        value: newDocumentController.selectedDocId.value,
                        onChange: (value) {
                          newDocumentController.selectedDocId.value = value;
                        },
                        hintText: "Select Document Type",
                        dropdownItems: newDocumentController
                            .doctorDocumentsTypeModel!.data!
                            .map((items) {
                          return DropdownMenuItem(
                            value: items.id.toString(),
                            child: Text(items.name ?? ""),
                          );
                        }).toList(),
                      )
                          : CommonDropDown(
                        value: newDocumentController.selectedDocId.value,
                        onChange: (value) {
                          newDocumentController.selectedDocId.value = value;
                        },
                        hintText: "Select Document Type",
                        dropdownItems: newDocumentController
                            .documentsTypeModel!.data!
                            .map((items) {
                          return DropdownMenuItem(
                            value: items.id.toString(),
                            child: Text(items.name ?? ""),
                          );
                        }).toList(),
                      ),
                      PreferenceUtils.getStringValue("role") == "Doctor"
                          ? SizedBox(height: height * 0.02)
                          : const SizedBox(),
                      PreferenceUtils.getStringValue("role") == "Doctor"
                          ? CommonRequiredText(
                          width: width, text: "Patient:")
                          : const SizedBox(),

                      if (PreferenceUtils.getStringValue("role") ==
                          "Doctor")
                        SizedBox(height: height * 0.01),

                      /// Patient
                      PreferenceUtils.getStringValue("role") == "Doctor"
                          ? CommonDropDown(
                        value:
                        newDocumentController.selectedPatientId.value,
                        onChange: (value) {
                          newDocumentController.selectedPatientId
                              .value = value;
                        },
                        hintText: "Select Patient",
                        dropdownItems: newDocumentController
                            .doctorPatientsDocumentsModel!.data!
                            .map((items) {
                          return DropdownMenuItem(
                            value: items.id.toString(),
                            child: Text(items.patient_name ?? ""),
                          );
                        }).toList(),
                      )
                          : const SizedBox(),
                      SizedBox(height: height * 0.02),
                      CommonRequiredText(
                          width: width, text: StringUtils.attachment),
                      SizedBox(height: height * 0.01),
                      InkWell(
                        onTap: () {
                          newDocumentController.pickImage();
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color:
                            ColorConst.primaryColor.withOpacity(0.02),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: ColorConst.primaryColor
                                  .withOpacity(0.5),
                              width: 1.5,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Obx(() {
                            return Container(
                              height:
                              !newDocumentController.showFile.value
                                  ? 120
                                  : 200,
                              child: !newDocumentController.showFile.value
                                  ? Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.cloud_upload_outlined,
                                      size: 40,
                                      color: ColorConst.primaryColor
                                          .withOpacity(0.7)),
                                  const SizedBox(height: 12),
                                  Text(
                                    "Tap to upload document",
                                    style: TextStyleConst
                                        .mediumTextStyle(
                                        Colors.grey.shade600,
                                        width * 0.038),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Supported formats: JPG, PNG, PDF",
                                    style: TextStyleConst
                                        .mediumTextStyle(
                                        Colors.grey.shade400,
                                        width * 0.03),
                                  ),
                                ],
                              )
                                  : ClipRRect(
                                borderRadius:
                                BorderRadius.circular(16),
                                child: Image.file(
                                  File(newDocumentController
                                      .file.value?.path ??
                                      ""),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      CommonRequiredText(
                          width: width, text: StringUtils.note),
                      SizedBox(height: height * 0.01),
                      CommonTextField(
                        hintText: StringUtils.typeHere,
                        maxLine: 4,
                        validator: (value) {
                          return null;
                        },
                        controller: newDocumentController.notesController,
                      ),
                      SizedBox(height: height * 0.04),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonButton(
                            textStyleConst:
                            TextStyleConst.mediumTextStyle(
                                ColorConst.whiteColor, width * 0.045),
                            onTap: () {
                              newDocumentController.createDocuments();
                            },
                            color: ColorConst.primaryColor,
                            text: StringUtils.save,
                            width: width * 0.4,
                            height: 52,
                          ),
                          CommonButton(
                            textStyleConst:
                            TextStyleConst.mediumTextStyle(
                                ColorConst.hintGreyColor,
                                width * 0.045),
                            onTap: () {
                              Get.back();
                            },
                            color: ColorConst.borderGreyColor,
                            text: StringUtils.cancel,
                            width: width * 0.4,
                            height: 52,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

