import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_detail_text.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/bed_status_model/bed_status_details_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/bed_status_model/bed_status_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class BedStatusController extends GetxController {
  List<RxBool> showData = [];
  List<RxInt> turns = [];
  BedStatusModel? bedStatusModel;
  BedStatusDetailsModel? bedStatusDetailsModel;

  RxBool isStatusApiCalled = false.obs;
  RxBool isStatusDataApiCalled = false.obs;

  void getBedDetails(String id, BuildContext context, double height, double width) {
    isStatusDataApiCalled.value = false;
    StringUtils.client.getBedStatusDetails(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        bedStatusDetailsModel = value;
        isStatusDataApiCalled.value = true;
        Get.back();
        showModelBottomSheet(context, height, width);
      })
      ..onError((DioException error, stackTrace) {
        isStatusDataApiCalled.value = true;
        Get.back();
        CheckSocketException.checkSocketException(error);
        return BedStatusDetailsModel();
      });
  }

  void changeIcon(int index) {
    if (showData[index].value) {
      showData[index].value = false;
      turns[index].value = 0;
    } else {
      showData[index].value = true;
      turns[index].value = 2;
    }
  }

  // void getBedStatusData() {
  //   StringUtils.client.getBedStatus(PreferenceUtils.getStringValue("token"))
  //     ..then((value) {
  //       bedStatusModel = value;
  //       showData = List.generate(value.data?.length ?? 0, (index) => false.obs);
  //       turns = List.generate(value.data?.length ?? 0, (index) => 0.obs);
  //       isStatusApiCalled.value = true;
  //       update();
  //     })
  //     ..onError((DioException error, stackTrace) {
  //       isStatusApiCalled.value = true;
  //       CheckSocketException.checkSocketException(error);
  //       return BedStatusModel();
  //     });
  // }
  Future<void> getBedStatusData() async {
    try {
      isStatusApiCalled.value = false;
      final value = await StringUtils.client.getBedStatus(PreferenceUtils.getStringValue("token"));

      bedStatusModel = value;
      showData.assignAll(List.generate(value.data?.length ?? 0, (index) => false.obs));
      turns.assignAll(List.generate(value.data?.length ?? 0, (index) => 0.obs));
    } catch (e) {
      if (e is DioException) {
        CheckSocketException.checkSocketException(e);
      }
    } finally {
      isStatusApiCalled.value = true;
    }
  }
  void showModelBottomSheet(BuildContext context, double height, double width) {
    showModalBottomSheet(
      shape: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          constraints: BoxConstraints(minHeight: height * 0.3),
          margin: const EdgeInsets.only(right: 25, top: 15, left: 25),
          child: Obx(() {
            return isStatusDataApiCalled.value == false
                ? const Center(child: CircularProgressIndicator())
                : bedStatusDetailsModel!.data == null
                    ? Center(
                        child: Text(
                          "No data found",
                          style: TextStyleConst.mediumTextStyle(
                            ColorConst.blackColor,
                            width * 0.04,
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                height: 5,
                                width: 60,
                                decoration: BoxDecoration(color: const Color(0xffE7E9EB), borderRadius: BorderRadius.circular(5)),
                              ),
                            ),
                            const SizedBox(height: 40),
                            CommonDetailText(width: width, titleText: "Bed Name:", descriptionText: bedStatusDetailsModel?.data?.bed_name ?? ""),
                            const SizedBox(height: 15),
                            CommonDetailText(width: width, titleText: "Patient:", descriptionText: bedStatusDetailsModel?.data?.patient ?? ""),
                            const SizedBox(height: 15),
                            CommonDetailText(width: width, titleText: "Phone:", descriptionText: bedStatusDetailsModel?.data?.phone ?? ""),
                            const SizedBox(height: 15),
                            CommonDetailText(
                                width: width, titleText: "Admission Date:", descriptionText: bedStatusDetailsModel?.data?.admission_date ?? ""),
                            const SizedBox(height: 15),
                            CommonDetailText(width: width, titleText: "Gender:", descriptionText: bedStatusDetailsModel?.data?.gender ?? ""),
                            const SizedBox(height: 15),
                          ],
                        ),
                      );
          }),
        );
      },
    );
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getBedStatusData();
  }
}
