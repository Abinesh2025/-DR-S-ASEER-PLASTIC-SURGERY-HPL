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
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/controller/hospital/add_hospital_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class AddHospitalScreen extends StatelessWidget {
  AddHospitalScreen({Key? key}) : super(key: key);
  final AddHospitalController addHospitalController = Get.put(AddHospitalController());

  final FocusNode hospitalNameFocus = FocusNode();
  final FocusNode hospitalSlugFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode cityFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode confirmPasswordFocus = FocusNode();

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
            backgroundColor: ColorConst.whiteColor,
            appBar: CommonAppBar(
              title: StringUtils.addHospital,
              leadOnTap: () {
                Get.back();
              },
              leadIcon: const Icon(
                Icons.arrow_back_rounded,
                color: ColorConst.blackColor,
              ),
            ),
            body: Obx(() {
              return addHospitalController.gotData.value == false
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            ///hospital name textfield
                            SizedBox(height: height * 0.02),
                            CommonRequiredText(
                              width: width,
                              text: StringUtils.hospitalName,
                            ),
                            SizedBox(height: height * 0.01),
                            CommonTextField(
                              hintText: "Enter Hospital Name",
                              validator: (value) {
                                return null;
                              },
                              controller: addHospitalController.hospitalNameController,
                              focusNode: hospitalNameFocus,
                              onEditingComplete: () =>
                                  FocusScope.of(context).requestFocus(hospitalSlugFocus),
                            ),

                            ///hospital slug textfield
                            SizedBox(height: height * 0.02),
                            CommonRequiredText(
                              width: width,
                              text: StringUtils.hospitalSlug,
                            ),
                            SizedBox(height: height * 0.01),
                            CommonTextField(
                              hintText: "Enter Hospital Slug",
                              validator: (value) {
                                return null;
                              },
                              controller: addHospitalController.hospitalSlugController,
                              focusNode: hospitalSlugFocus,
                              onEditingComplete: () =>
                                  FocusScope.of(context).unfocus(),
                            ),
                            SizedBox(height: height * 0.02),

                            ///select hospital type
                            CommonRequiredText(
                              width: width,
                              text: StringUtils.hospitalType,
                            ),
                            SizedBox(height: height * 0.01),
                            CommonDropDown(
                              onChange: (value) {
                                addHospitalController.hospitalTypeId = value;
                              },
                              hintText: "Select Hospital Type",
                              dropdownItems: addHospitalController.hospitalTypeModel!.data!.map((items) {
                                return DropdownMenuItem(
                                  value: items.id.toString(),
                                  child: Text(items.name ?? ""),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: height * 0.02),

                            /// email textfield
                            CommonRequiredText(
                              width: width,
                              text: StringUtils.email,
                            ),
                            SizedBox(height: height * 0.01),
                            CommonTextField(
                              hintText: "Enter Email",
                              validator: (value) {
                                return null;
                              },
                              controller: addHospitalController.emailController,
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
                              hintText: "Enter City",
                              validator: (value) {
                                return null;
                              },
                              controller: addHospitalController.cityController,
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
                              initialCountryCode: "IN",
                              controller: addHospitalController.phoneController,
                              onCountryChanged: (phoneCountry) {
                                addHospitalController.prefixCodeController.text = phoneCountry.dialCode;
                              },
                              focusNode: phoneFocus,
                              onSubmitted: (_) =>
                                  FocusScope.of(context).requestFocus(passwordFocus),
                            ),
                            SizedBox(height: height * 0.02),

                            ///password textfield
                            CommonRequiredText(
                              width: width,
                              text: StringUtils.password,
                            ),
                            SizedBox(height: height * 0.01),
                            CommonTextField(
                              hintText: "Enter Password",
                              validator: (value) {
                                return null;
                              },
                              controller: addHospitalController.passwordController,
                              focusNode: passwordFocus,
                              onEditingComplete: () =>
                                  FocusScope.of(context).requestFocus(confirmPasswordFocus),
                            ),
                            SizedBox(height: height * 0.02),

                            ///confirm password textfield
                            CommonRequiredText(
                              width: width,
                              text: StringUtils.confirmPassword,
                            ),
                            SizedBox(height: height * 0.01),
                            CommonTextField(
                              hintText: "Enter Confirm Password",
                              validator: (value) {
                                return null;
                              },
                              controller: addHospitalController.confirmPasswordController,
                              focusNode: confirmPasswordFocus,
                              onEditingComplete: () =>
                                  FocusScope.of(context).unfocus(),
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
                          addHospitalController.createHospital();
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
            ),
          ),
  ),
      ),
    );
  }
}
