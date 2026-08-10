import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
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

  String _getFileName(String url, String fieldName, int fieldId) {
    try {
      final uri = Uri.parse(url);
      if (uri.pathSegments.isNotEmpty) {
        final last = uri.pathSegments.last;
        if (last.isNotEmpty && last != fieldId.toString() && !RegExp(r'^\d+$').hasMatch(last)) {
          return last;
        }
        if (uri.pathSegments.length > 1) {
          final secondLast = uri.pathSegments[uri.pathSegments.length - 2];
          if (secondLast.isNotEmpty && secondLast != fieldId.toString() && !RegExp(r'^\d+$').hasMatch(secondLast)) {
            return secondLast;
          }
        }
      }
    } catch (_) {}
    return "$fieldName (Uploaded)";
  }

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
                            if (field.id == null) return const SizedBox();

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
                                        value: editProfileController.customFieldToggles[field.id] ?? false,
                                        activeColor: ColorConst.primaryColor,
                                        onChanged: (value) {
                                          editProfileController
                                              .customFieldToggles[field.id!] = value;
                                          editProfileController.update();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else if (field.field_type_name == "text" || field.field_type_name == "number") {
                              final textController = editProfileController.customFieldControllers[field.id];
                              if (textController == null) return const SizedBox();
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (field.is_required == true)
                                      CommonRequiredText(
                                        width: width,
                                        text: field.field_name ?? "",
                                      )
                                    else
                                      Text(
                                        field.field_name ?? "",
                                        style: TextStyle(
                                          fontSize: width * 0.038,
                                          fontWeight: FontWeight.w500,
                                          color: ColorConst.blackColor,
                                        ),
                                      ),
                                    const SizedBox(height: 8),
                                    CommonTextField(
                                      validator: (value) {
                                        if (field.is_required == true && (value == null || value.trim().isEmpty)) {
                                          return "Please enter ${field.field_name}";
                                        }
                                        return null;
                                      },
                                      controller: textController,
                                      keyBoardType: field.field_type_name == "number" ? TextInputType.number : TextInputType.text,
                                      hintText: "Enter ${field.field_name}",
                                    ),
                                  ],
                                ),
                              );
                            } else if (field.field_type_name == "fileUpload") {
                              final pickedFile = editProfileController.customFieldFiles[field.id];
                              final existingUrl = editProfileController.customFieldFileUrls[field.id];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (field.is_required == true)
                                      CommonRequiredText(
                                        width: width,
                                        text: field.field_name ?? "",
                                      )
                                    else
                                      Text(
                                        field.field_name ?? "",
                                        style: TextStyle(
                                          fontSize: width * 0.038,
                                          fontWeight: FontWeight.w500,
                                          color: ColorConst.blackColor,
                                        ),
                                      ),
                                    const SizedBox(height: 8),
                                    InkWell(
                                      onTap: () {
                                        editProfileController.pickCustomFieldFile(field.id!);
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 14,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                            color: ColorConst.borderGreyColor,
                                            width: 1.5,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.upload_file,
                                              color: ColorConst.primaryColor,
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                pickedFile != null
                                                    ? pickedFile.name
                                                    : (existingUrl != null && existingUrl.isNotEmpty)
                                                        ? _getFileName(existingUrl, field.field_name ?? "Document", field.id!)
                                                        : "Choose File (Image/Document)",
                                                style: TextStyle(
                                                  color: (pickedFile != null || existingUrl != null)
                                                      ? ColorConst.blackColor
                                                      : ColorConst.hintGreyColor,
                                                  fontSize: width * 0.038,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            if (existingUrl != null && existingUrl.isNotEmpty && pickedFile == null) ...[
                                              GestureDetector(
                                                onTap: () async {
                                                  final uri = Uri.tryParse(existingUrl);
                                                  if (uri != null) {
                                                    if (await canLaunchUrl(uri)) {
                                                      await launchUrl(uri, mode: LaunchMode.externalApplication);
                                                    } else {
                                                      DisplaySnackBar.displaySnackBar(
                                                          "Could not open document link", 3, ColorConst.redColor);
                                                    }
                                                  }
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                                                  child: Icon(
                                                    Icons.visibility,
                                                    color: ColorConst.primaryColor,
                                                    size: 22,
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  editProfileController.customFieldFileUrls[field.id!] = null;
                                                  editProfileController.update();
                                                },
                                                child: const Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 6.0),
                                                  child: Icon(
                                                    Icons.delete_outline,
                                                    color: Colors.red,
                                                    size: 22,
                                                  ),
                                                ),
                                              ),
                                            ],
                                            if (pickedFile != null)
                                              IconButton(
                                                padding: EdgeInsets.zero,
                                                constraints: const BoxConstraints(),
                                                icon: const Icon(Icons.close, color: Colors.red, size: 20),
                                                onPressed: () {
                                                  editProfileController.customFieldFiles[field.id!] = null;
                                                  editProfileController.update();
                                                },
                                              ),
                                          ],
                                        ),
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
