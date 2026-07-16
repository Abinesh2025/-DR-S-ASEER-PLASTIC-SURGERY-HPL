import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_app_bar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_button.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_phone_textfield.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_required_text.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_text_field.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/my_account_controller/edit_profile_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  final FocusNode firstNameFocus = FocusNode();
  final FocusNode lastNameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode addressFocus = FocusNode();
  final FocusNode cityFocus = FocusNode();
  final FocusNode pincodeFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GetBuilder<EditProfileController>(
      init: EditProfileController(),
      builder: (editProfileController) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
            backgroundColor: ColorConst.whiteColor,
            appBar: CommonAppBar(
              isGradient: true,
              title: StringUtils.editProfile,
              leadOnTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
                if (MediaQuery.of(context).viewInsets.bottom == 0.0) {
                  Navigator.pop(context);
                }
                editProfileController.showFile = false;
                if (editProfileController.file != null) {
                  editProfileController.file = null;
                }
                // editProfileController.update();
              },
              leadIcon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.04),
                    Center(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorConst.borderGreyColor,
                            ),
                            child: ClipOval(
                              child: editProfileController.showFile == true
                                  ? Image.file(
                                      File(editProfileController.file!.path),
                                      fit: BoxFit.cover,
                                    )
                                  : (editProfileController.imageUrl == null ||
                                          editProfileController
                                              .imageUrl!.isEmpty
                                      ? Image.asset(
                                          ImageUtils.patientIcon,
                                          fit: BoxFit.cover,
                                        )
                                      : FadeInImage(
                                          placeholder: const AssetImage(
                                              ImageUtils.patientIcon),
                                          image: NetworkImage(
                                              editProfileController.imageUrl!
                                                  .replaceAll(" ", "")),
                                          imageErrorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                              ImageUtils.patientIcon,
                                              fit: BoxFit.cover,
                                            );
                                          },
                                          fit: BoxFit.cover,
                                        )),
                            ),
                          ),
                          Positioned(
                            bottom: -5,
                            right: -8,
                            child: Container(
                              height: 45,
                              width: 45,
                              decoration: const BoxDecoration(
                                color: ColorConst.whiteColor,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    editProfileController.pickImage(context);
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    decoration:  BoxDecoration(
                                      color: ColorConst.primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.camera_alt,
                                      color: ColorConst.whiteColor,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.04),
                    CommonRequiredText(
                      width: width,
                      text: StringUtils.firstName,
                    ),
                    SizedBox(height: height * 0.01),
                    CommonTextField(
                      validator: (value) {
                        return null;
                      },
                      controller: editProfileController.firstNameController,
                      focusNode: firstNameFocus,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(lastNameFocus),
                    ),
                    SizedBox(height: height * 0.02),
                    CommonRequiredText(
                      width: width,
                      text: StringUtils.lastName,
                    ),
                    SizedBox(height: height * 0.01),
                    CommonTextField(
                      validator: (value) {
                        return null;
                      },
                      controller: editProfileController.lastNameController,
                      focusNode: lastNameFocus,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(emailFocus),
                    ),
                    SizedBox(height: height * 0.02),
                    CommonRequiredText(
                      width: width,
                      text: StringUtils.email,
                    ),
                    SizedBox(height: height * 0.01),
                    CommonTextField(
                      validator: (value) {
                        return null;
                      },
                      controller: editProfileController.emailController,
                      focusNode: emailFocus,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(phoneFocus),
                    ),
                    SizedBox(height: height * 0.02),
                    CommonRequiredText(
                      width: width,
                      text: StringUtils.phone,
                    ),
                    SizedBox(height: height * 0.01),
                    CommonPhoneTextField(
                      initialCountryCode: editProfileController
                          .getCountryCodeFromDialCode(editProfileController
                              .regionCodeController.text),
                      controller: editProfileController.phoneController,
                      onCountryChanged: (phoneCountry) {
                        editProfileController.regionCodeController.text =
                            phoneCountry.dialCode;
                        editProfileController.update();
                      },
                      focusNode: phoneFocus,
                      onSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(addressFocus),
                    ),
                    SizedBox(height: height * 0.02),
                    CommonRequiredText(
                      width: width,
                      text: StringUtils.address,
                    ),
                    SizedBox(height: height * 0.01),
                    CommonTextField(
                      validator: (value) {
                        return null;
                      },
                      controller: editProfileController.addressController,
                      focusNode: addressFocus,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(cityFocus),
                    ),
                    SizedBox(height: height * 0.02),
                    CommonRequiredText(
                      width: width,
                      text: StringUtils.cityLabel,
                    ),
                    SizedBox(height: height * 0.01),
                    CommonTextField(
                      validator: (value) {
                        return null;
                      },
                      controller: editProfileController.cityController,
                      focusNode: cityFocus,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(pincodeFocus),
                    ),
                    SizedBox(height: height * 0.02),
                    CommonRequiredText(
                      width: width,
                      text: StringUtils.pincode,
                    ),
                    SizedBox(height: height * 0.01),
                    CommonTextField(
                      validator: (value) {
                        return null;
                      },
                      controller: editProfileController.pincodeController,
                      focusNode: pincodeFocus,
                      onEditingComplete: () =>
                          FocusScope.of(context).unfocus(),
                    ),
                    SizedBox(height: height * 0.02),

                    if (editProfileController.customFields.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Additional Information",
                            style: TextStyle(
                              fontSize: width * 0.045,
                              fontWeight: FontWeight.w600,
                              color: ColorConst.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 12),

                          ...editProfileController.customFields.map((field) {
                            if (field.field_type_name == "toggle") {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: ColorConst.borderGreyColor,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        field.field_name ?? "",
                                        style: TextStyle(
                                          fontSize: width * 0.04,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Transform.scale(
                                      scale: 0.8,
                                      child: Switch(
                                        value: editProfileController.customFieldValues[field.id] ?? false,
                                        activeColor: ColorConst.primaryColor,
                                        onChanged: (value) {
                                          editProfileController
                                              .customFieldValues[field.id!] = value;
                                          editProfileController.update();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }

                            return const SizedBox();
                          }).toList(),
                        ],
                      ),


                    SizedBox(height: height * 0.05),
                  ],
                ),
              ),
            ),
            bottomNavigationBar:SafeArea(
              child:Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonButton(
                    textStyleConst: TextStyleConst.mediumTextStyle(
                        ColorConst.whiteColor, width * 0.05),
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      editProfileController.updateProfile();
                    },
                    isLoading: editProfileController.isLoading,
                    color: ColorConst.primaryColor,
                    text: StringUtils.save,
                    width: width / 2.3,
                    height: 50,
                  ),
                  CommonButton(
                    textStyleConst: TextStyleConst.mediumTextStyle(
                        ColorConst.hintGreyColor, width * 0.05),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      if (MediaQuery.of(context).viewInsets.bottom ==
                          0.0) {
                        Navigator.pop(context);
                      }
                      editProfileController.showFile = false;
                      if (editProfileController.file != null) {
                        editProfileController.file = null;
                      }
                    },

                    color: ColorConst.borderGreyColor,
                    text: StringUtils.cancel,
                    width: width / 2.3,
                    height: 50,
                  ),
                ],
              ),
            ),),
          ),
        );
      },
    );
  }
}
