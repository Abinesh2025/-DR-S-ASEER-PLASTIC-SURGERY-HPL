// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/document_controller/document_list_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/document/edit_document_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/document/new_document_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class DocumentScreen extends StatelessWidget {
  DocumentScreen({Key? key}) : super(key: key);
  DocumentController documentController = Get.put(DocumentController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    if (PreferenceUtils.getStringValue("role") == "Doctor") {
      return Stack(
        children: [
          Container(
            color: Colors.white,
            child: Obx(() {
              return documentController.gotData.value == false
                  ?  Center(
                      child: CircularProgressIndicator(
                          color: ColorConst.primaryColor))
                  : documentController.doctorDocumentsModel?.data?.isEmpty ??
                          true
                      ? Center(
                          child: Text(
                            "No documents found",
                            style: TextStyleConst.mediumTextStyle(
                              ColorConst.blackColor,
                              width * 0.04,
                            ),
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () async {
                            documentController.getDoctorDocuments();
                          },
                          child: AnimationLimiter(
                            child: ListView.builder(
                              itemCount: documentController
                                  .doctorDocumentsModel!.data!.length,
                              physics: const AlwaysScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics()),
                              itemBuilder: (context, index) {
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 1000),
                                  child: SlideAnimation(
                                    verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: Column(
                                        children: [
                                          Slidable(
                                            startActionPane: ActionPane(
                                              extentRatio: 0.25,
                                              motion: const ScrollMotion(),
                                              children: [
                                                SlidableAction(
                                                  onPressed:
                                                      (contextAction) async {
                                                    final message = await Get.to(
                                                        () => EditDocumentScreen(
                                                            documentId:
                                                                documentController
                                                                        .doctorDocumentsModel
                                                                        ?.data?[
                                                                            index]
                                                                        .id ??
                                                                    0),
                                                        transition: Transition
                                                            .leftToRight,
                                                        arguments: {
                                                          "title":
                                                              documentController
                                                                  .doctorDocumentsModel
                                                                  ?.data?[index]
                                                                  .title,
                                                          "docType": documentController
                                                              .doctorDocumentsModel
                                                              ?.data?[index]
                                                              .document_type_id,
                                                          "attachment":
                                                              documentController
                                                                  .doctorDocumentsModel
                                                                  ?.data?[index]
                                                                  .document_url,
                                                          "note": documentController
                                                              .doctorDocumentsModel
                                                              ?.data?[index]
                                                              .notes,
                                                          "patientId":
                                                              documentController
                                                                  .doctorDocumentsModel
                                                                  ?.data?[index]
                                                                  .patient_id
                                                                  .toString(),
                                                        });
                                                    if (message == "Call API") {
                                                      documentController
                                                          .getDoctorDocuments();
                                                    }
                                                  },
                                                  backgroundColor: ColorConst
                                                      .orangeColor
                                                      .withOpacity(0.15),
                                                  label: StringUtils.edit,
                                                  foregroundColor:
                                                      ColorConst.orangeColor,
                                                ),
                                              ],
                                            ),
                                            endActionPane: ActionPane(
                                              extentRatio: 0.25,
                                              motion: const ScrollMotion(),
                                              children: [
                                                SlidableAction(
                                                  onPressed: (contextAction) {
                                                    documentController
                                                        .showDeleteDialog(
                                                            context,
                                                            height,
                                                            width,
                                                            index);
                                                  },
                                                  backgroundColor:
                                                      const Color(0xFFFCE5E5),
                                                  label: StringUtils.delete,
                                                  foregroundColor:
                                                      ColorConst.redColor,
                                                  // lableColor: Colors.red,
                                                ),
                                              ],
                                            ),
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  top: index == 0 ? 15 : 8,
                                                  bottom: 8),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.04),
                                                    blurRadius: 10,
                                                    spreadRadius: 2,
                                                    offset: const Offset(0, 4),
                                                  ),
                                                ],
                                                border: Border.all(
                                                    color:
                                                        Colors.grey.shade100),
                                              ),
                                              child: Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  onTap: () {},
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        // Document Icon
                                                        Container(
                                                          height: 50,
                                                          width: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: ColorConst
                                                                .primaryColor
                                                                .withOpacity(
                                                                    0.1),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Center(
                                                            child: Image.asset(
                                                              "assets/icon/imageIcon.png",
                                                              height: 24,
                                                              width: 24,
                                                              color: ColorConst
                                                                  .primaryColor,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 16),

                                                        // Text Info Column
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                documentController
                                                                        .doctorDocumentsModel
                                                                        ?.data?[
                                                                            index]
                                                                        .title ??
                                                                    "",
                                                                style: TextStyleConst
                                                                    .boldTextStyle(
                                                                        ColorConst
                                                                            .blackColor,
                                                                        width *
                                                                            0.042),
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                              const SizedBox(
                                                                  height: 6),
                                                              Text(
                                                                documentController
                                                                        .doctorDocumentsModel
                                                                        ?.data?[
                                                                            index]
                                                                        .notes ??
                                                                    "",
                                                                style: TextStyleConst
                                                                    .mediumTextStyle(
                                                                        Colors
                                                                            .grey
                                                                            .shade600,
                                                                        width *
                                                                            0.035),
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 12),

                                                        // Download Button
                                                        Obx(() {
                                                          return documentController
                                                                  .isCurrentDownloading[
                                                                      index]
                                                                  .value
                                                              ?  SizedBox(
                                                                  height: 24,
                                                                  width: 24,
                                                                  child: CircularProgressIndicator(
                                                                      color: ColorConst
                                                                          .primaryColor,
                                                                      strokeWidth:
                                                                          2),
                                                                )
                                                              : InkWell(
                                                                  onTap: () {
                                                                    documentController
                                                                        .downloadDocument(
                                                                            context,
                                                                            index);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            6),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: ColorConst
                                                                          .bgGreyColor,
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      border: Border.all(
                                                                          color: Colors
                                                                              .grey
                                                                              .shade200),
                                                                    ),
                                                                    child: Icon(
                                                                        Icons
                                                                            .file_download_outlined,
                                                                        color: Colors
                                                                            .grey
                                                                            .shade700,
                                                                        size:
                                                                            20),
                                                                  ),
                                                                );
                                                        }),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          index ==
                                                  documentController
                                                          .doctorDocumentsModel!
                                                          .data!
                                                          .length -
                                                      1
                                              ? const SizedBox(
                                                  height: 70,
                                                )
                                              : const SizedBox()
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
            }),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 25, bottom: 25, left: 25), // Adjusted for safe area
                child: GestureDetector(
                  onTap: () async {
                    final message = await Get.to(() => NewDocumentScreen(),
                        transition: Transition.rightToLeft);
                    if (message == "Call API") {
                      if (PreferenceUtils.getStringValue("role") == "Doctor") {
                        documentController.getDoctorDocuments();
                      } else {
                        documentController.getDocuments();
                      }
                    }
                  },
                  child: Container(
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorConst.primaryColor,
                      boxShadow: [
                        BoxShadow(
                          color: ColorConst.primaryColor.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.add_rounded,
                        color: Colors.white, size: 30),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Stack(
        children: [
          Container(
            color: Colors.white,
            child: Obx(() {
              return documentController.gotData.value == false
                  ?  Center(
                      child: CircularProgressIndicator(
                          color: ColorConst.primaryColor))
                  : documentController.documentsModel?.data?.isEmpty ?? true
                      ? Center(
                          child: Text(
                            "No documents found",
                            style: TextStyleConst.mediumTextStyle(
                              ColorConst.blackColor,
                              width * 0.04,
                            ),
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () async {
                            documentController.getDocuments();
                          },
                          child: AnimationLimiter(
                            child: ListView.builder(
                              itemCount: documentController
                                      .documentsModel?.data?.length ??
                                  0,
                              physics: const AlwaysScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics()),
                              itemBuilder: (context, index) {
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 1000),
                                  child: SlideAnimation(
                                    verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: Column(
                                        children: [
                                          Slidable(
                                            startActionPane: ActionPane(
                                              extentRatio: 0.25,
                                              motion: const ScrollMotion(),
                                              children: [
                                                SlidableAction(
                                                  onPressed:
                                                      (contextAction) async {
                                                    final message = await Get.to(
                                                        () => EditDocumentScreen(
                                                            documentId:
                                                                documentController
                                                                        .documentsModel
                                                                        ?.data?[
                                                                            index]
                                                                        .id ??
                                                                    0),
                                                        transition: Transition
                                                            .leftToRight,
                                                        arguments: {
                                                          "title":
                                                              documentController
                                                                  .documentsModel
                                                                  ?.data?[index]
                                                                  .title,
                                                          "docType":
                                                              documentController
                                                                  .documentsModel
                                                                  ?.data?[index]
                                                                  .document_type_id,
                                                          "attachment":
                                                              documentController
                                                                  .documentsModel
                                                                  ?.data?[index]
                                                                  .document_url,
                                                          "note":
                                                              documentController
                                                                  .documentsModel
                                                                  ?.data?[index]
                                                                  .notes,
                                                        });
                                                    if (message == "Call API") {
                                                      documentController
                                                          .getDocuments();
                                                    }
                                                  },
                                                  backgroundColor: ColorConst
                                                      .orangeColor
                                                      .withOpacity(0.15),
                                                  label: StringUtils.edit,
                                                  foregroundColor:
                                                      ColorConst.orangeColor,
                                                  // lableColor: ColorConst.orangeColor,
                                                ),
                                              ],
                                            ),
                                            endActionPane: ActionPane(
                                              extentRatio: 0.25,
                                              motion: const ScrollMotion(),
                                              children: [
                                                SlidableAction(
                                                  onPressed: (contextAction) {
                                                    documentController
                                                        .showDeleteDialog(
                                                            context,
                                                            height,
                                                            width,
                                                            index);
                                                  },
                                                  backgroundColor:
                                                      const Color(0xFFFCE5E5),
                                                  label: StringUtils.delete,
                                                  foregroundColor:
                                                      ColorConst.redColor,
                                                ),
                                              ],
                                            ),
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  top: index == 0 ? 15 : 8,
                                                  bottom: 8),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.04),
                                                    blurRadius: 10,
                                                    spreadRadius: 2,
                                                    offset: const Offset(0, 4),
                                                  ),
                                                ],
                                                border: Border.all(
                                                    color:
                                                        Colors.grey.shade100),
                                              ),
                                              child: Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  onTap: () {},
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        // Document Icon
                                                        Container(
                                                          height: 50,
                                                          width: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: ColorConst
                                                                .primaryColor
                                                                .withOpacity(
                                                                    0.1),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Center(
                                                            child: Image.asset(
                                                              "assets/icon/imageIcon.png",
                                                              height: 24,
                                                              width: 24,
                                                              color: ColorConst
                                                                  .primaryColor,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 16),

                                                        // Text Info Column
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                documentController
                                                                        .documentsModel
                                                                        ?.data?[
                                                                            index]
                                                                        .title ??
                                                                    "",
                                                                style: TextStyleConst
                                                                    .boldTextStyle(
                                                                        ColorConst
                                                                            .blackColor,
                                                                        width *
                                                                            0.042),
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                              const SizedBox(
                                                                  height: 6),
                                                              Text(
                                                                documentController
                                                                        .documentsModel
                                                                        ?.data?[
                                                                            index]
                                                                        .notes ??
                                                                    "",
                                                                style: TextStyleConst
                                                                    .mediumTextStyle(
                                                                        Colors
                                                                            .grey
                                                                            .shade600,
                                                                        width *
                                                                            0.035),
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 12),

                                                        // Download Button
                                                        Obx(() {
                                                          return documentController
                                                                  .isCurrentDownloading[
                                                                      index]
                                                                  .value
                                                              ?  SizedBox(
                                                                  height: 24,
                                                                  width: 24,
                                                                  child: CircularProgressIndicator(
                                                                      color: ColorConst
                                                                          .primaryColor,
                                                                      strokeWidth:
                                                                          2),
                                                                )
                                                              : InkWell(
                                                                  onTap: () {
                                                                    documentController
                                                                        .downloadDocument(
                                                                            context,
                                                                            index);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            6),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: ColorConst
                                                                          .bgGreyColor,
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      border: Border.all(
                                                                          color: Colors
                                                                              .grey
                                                                              .shade200),
                                                                    ),
                                                                    child: Icon(
                                                                        Icons
                                                                            .file_download_outlined,
                                                                        color: Colors
                                                                            .grey
                                                                            .shade700,
                                                                        size:
                                                                            20),
                                                                  ),
                                                                );
                                                        }),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
            }),
          ),
          // SafeArea(
          //   child: Align(
          //     alignment: Alignment.bottomRight,
          //     child: Padding(
          //       padding: const EdgeInsets.only(
          //           right: 25, bottom: 25, left: 25), // Adjusted for safe area
          //       child: GestureDetector(
          //         onTap: () async {
          //           final message = await Get.to(() => NewDocumentScreen(),
          //               transition: Transition.rightToLeft);
          //           if (message == "Call API") {
          //             if (PreferenceUtils.getStringValue("role") == "Doctor") {
          //               documentController.getDoctorDocuments();
          //             } else {
          //               documentController.getDocuments();
          //             }
          //           }
          //         },
          //         child: Container(
          //           height: 56,
          //           width: 56,
          //           decoration: BoxDecoration(
          //             shape: BoxShape.circle,
          //             color: ColorConst.primaryColor,
          //             boxShadow: [
          //               BoxShadow(
          //                 color: ColorConst.primaryColor.withOpacity(0.3),
          //                 blurRadius: 10,
          //                 offset: const Offset(0, 4),
          //               ),
          //             ],
          //           ),
          //           child: const Icon(Icons.add_rounded,
          //               color: Colors.white, size: 30),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      );
    }
  }
}
