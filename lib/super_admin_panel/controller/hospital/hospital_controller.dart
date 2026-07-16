import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_button.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_loader.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/super_admin_model/hospital_model/delete_hospital_model/delete_hospital_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/super_admin_model/hospital_model/filter_hospital_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/super_admin_model/hospital_model/hospital_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class HospitalController extends GetxController {
  HospitalModel? hospitalModel;
  FilterHospitalModel? filterHospitalModel;
  RxBool isGotData = false.obs;

  RxList hospitalStatus = ["All", "Active", "Deactive"].obs;
  RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getHospitals();
    // if (currentIndex.value == 0) {
    //   getFilterHospitals("all");
    // }
  }

  void changeIndex(int index) {
    isGotData.value = false;
    switch (index) {
      case 0:
        currentIndex.value = 0;
        getFilterHospitals("all");
        break;
      case 1:
        currentIndex.value = 1;
        getFilterHospitals("active");
        break;
      case 2:
        currentIndex.value = 2;
        getFilterHospitals("deactive");
        break;
    }
  }

  void getFilterHospitals(String filter) {
    StringUtils.client.getFilterHospitals(PreferenceUtils.getStringValue("token"), filter).then((value) {
      filterHospitalModel = value;
      isGotData.value = true;
    }).onError((DioException error, stackTrace) {
      CheckSocketException.checkSocketException(error);
    });
  }

  void getHospitals() {
    isGotData.value = false;
    StringUtils.client.getFilterHospitals(PreferenceUtils.getStringValue("token"), "all")
      ..then((value) {
        filterHospitalModel = value;
        isGotData.value = true;
      })
      ..onError((DioException error, stackTrace) {
        isGotData.value = true;
        filterHospitalModel = FilterHospitalModel(data: []);
        CheckSocketException.checkSocketException(error);
        return FilterHospitalModel();
      });
  }

  void deleteHospital(int id, int index) {
    CommonLoader.showLoader();
    StringUtils.client.deleteHospital(PreferenceUtils.getStringValue("token"), id.toString())
      ..then((value) {
        Get.back();
        DisplaySnackBar.displaySnackBar("Hospital has been deleted", 3, ColorConst.redColor);
        //getHospitals();
        getFilterHospitals("all");
        changeIndex(index);
      })
      ..onError((DioException error, stackTrace) {
        Get.back();
        CheckSocketException.checkSocketException(error);
        return DeleteHospitalModel();
      });
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
                  "Are you sure want to delete this\n hospital?",
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
                        deleteHospital(filterHospitalModel?.data?[index].id ?? 0, currentIndex.value);
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
}