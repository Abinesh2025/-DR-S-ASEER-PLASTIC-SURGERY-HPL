import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_app_bar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_button.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_dropdown_button.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_phone_textfield.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_required_text.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_text_field.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/controller/hospital/edit_hospital_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class EditHospitalScreen extends StatelessWidget {
  final int hospitalId;
   EditHospitalScreen({Key? key, required this.hospitalId}) : super(key: key);

  final EditHospitalController editHospitalController = Get.put(EditHospitalController());



  final FocusNode emailFocus = FocusNode();
  final FocusNode cityFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();


  @override
  Widget build(BuildContext context) {
    var res = ModalRoute.of(context)?.settings.arguments;
    editHospitalController.arguments = res;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
            backgroundColor: ColorConst.whiteColor,
            appBar: CommonAppBar(
              title: StringUtils.editHospital,
              leadOnTap: () {
                Get.back();
              },
              leadIcon: const Icon(
                Icons.arrow_back_rounded,
                color: ColorConst.blackColor,
              ),
            ),
            body: Obx(() {
              return editHospitalController.gotData.value == false
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height * 0.02),

                      /// hospital name textfield
                      CommonRequiredText(
                        width: width,
                        text: StringUtils.hospitalName,
                      ),
                      SizedBox(height: height * 0.01),
                      CommonTextField(
                        validator: (value) {
                          return null;
                        },
                        controller: editHospitalController.hospitalNameController,
                      ),
                      SizedBox(height: height * 0.02),

                      ///hospital slug textfield
                      CommonRequiredText(
                        width: width,
                        text: StringUtils.hospitalSlug,
                      ),
                      SizedBox(height: height * 0.01),
                      Container(
                        decoration: BoxDecoration(
                          color: ColorConst.bgGreyColor,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: CommonTextField(
                          readOnly: true,
                          validator: (value) {
                            return null;
                          },
                          controller: editHospitalController.hospitalSlugController,
                        ),
                      ),
                      SizedBox(height: height * 0.02),

                      ///hospital type textfield
                      CommonRequiredText(
                        width: width,
                        text: StringUtils.hospitalType,
                      ),
                      SizedBox(height: height * 0.01),

                      CommonDropDown(
                        value: editHospitalController.hospTypeId == "N/A" ? null : editHospitalController.hospTypeId,
                        onChange: (value) {
                          editHospitalController.hospTypeId = value;
                        },
                        dropdownItems: editHospitalController.hospitalTypeModel!.data!.map((items) {
                          return DropdownMenuItem(
                            value: items.id.toString(),
                            child: Text(items.name ?? ""),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: height * 0.02),

                      ///email textfield
                      CommonRequiredText(
                        width: width,
                        text: StringUtils.email,
                      ),
                      SizedBox(height: height * 0.01),
                      CommonTextField(
                        validator: (value) {
                          return null;
                        },
                        controller: editHospitalController.emailController,
                        focusNode: emailFocus,
                        onEditingComplete: () =>
                            FocusScope.of(context).requestFocus(cityFocus),
                      ),
                      SizedBox(height: height * 0.02),

                      ///city textfield
                      CommonRequiredText(
                        width: width,
                        text: StringUtils.city,
                      ),
                      SizedBox(height: height * 0.01),
                      CommonTextField(
                        validator: (value) {
                          return null;
                        },
                        controller: editHospitalController.cityController,
                        focusNode: cityFocus,
                        onEditingComplete: () =>
                            FocusScope.of(context).requestFocus(phoneFocus),
                      ),
                      SizedBox(height: height * 0.02),

                      ///phone textfield
                      CommonRequiredText(
                        width: width,
                        text: StringUtils.phone,
                      ),
                      SizedBox(height: height * 0.01),

                      CommonPhoneTextField(
                        initialCountryCode: editHospitalController.getCountryCodeFromDialCode(editHospitalController.prefixCodeController.text),
                        controller: editHospitalController.phoneController,
                        onCountryChanged: (phoneCountry) {
                          editHospitalController.prefixCodeController.text = phoneCountry.dialCode;
                        },
                        focusNode: phoneFocus,
                        onSubmitted: (_) =>
                            FocusScope.of(context).unfocus(),
                        // validator: (value){
                        //   return null;
                        // },
                      ),
                      SizedBox(height: height * 0.05),
                    ],
                  ),
                ),
              );
            }),
          bottomNavigationBar: BottomAppBar(
              elevation: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
                ),
                height: 58.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonButton(
                      textStyleConst: TextStyleConst.mediumTextStyle(ColorConst.whiteColor, width * 0.05),
                      onTap: () {
                        editHospitalController.editHospitals(hospitalId);
                      },
                      color: ColorConst.blueColor,
                      text: StringUtils.save,
                      width: width / 2.3,
                      height: 50,
                    ),
                    CommonButton(
                      textStyleConst: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, width * 0.05),
                      onTap: () {
                        Get.back();
                      },
                      color: ColorConst.borderGreyColor,
                      text: StringUtils.cancel,
                      width: width / 2.3,
                      height: 50,
                    ),
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }
}
