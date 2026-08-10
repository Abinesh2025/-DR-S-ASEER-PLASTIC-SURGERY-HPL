import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/country_code_list.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_loader.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/account_model/edit_profile_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/variable_utils.dart';

import '../../../model/common/setting_model.dart';
import '../../../utils/config_utils.dart';

class EditProfileController extends GetxController {
  EditProfileModel? editProfileModel;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController regionCodeController = TextEditingController();
  final TextEditingController phoneCountryController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  bool isLoading = false;
  XFile? file;
  bool showFile = false;
  ImagePicker imagePicker = ImagePicker();
  SettingModel? settingModel;

  List<PatientCustomField> customFields = [];

  Map<int, bool> customFieldToggles = <int, bool>{};
  Map<int, TextEditingController> customFieldControllers = <int, TextEditingController>{};
  Map<int, XFile?> customFieldFiles = <int, XFile?>{};
  Map<int, String?> customFieldFileUrls = <int, String?>{};
  String? imageUrl;

  @override
  void onInit() {
    super.onInit();

    // Helper function to check for "N/A", empty spaces, or nulls
    String formatValue(String? value) {
      if (value == null ||
          value.trim().isEmpty ||
          value.trim().toUpperCase() == "N/A") {
        return ""; // Return empty string so the Hint Text shows instead
      }
      return value.trim();
    }

    // Apply the helper to all profile fields
    emailController.text = formatValue(VariableUtils.email.value);
    firstNameController.text = formatValue(VariableUtils.firstName.value);
    lastNameController.text = formatValue(VariableUtils.lastName.value);
    phoneController.text = formatValue(VariableUtils.phoneNo.value);

    // These usually don't return "N/A", but it's safer to keep them clean
    addressController.text = formatValue(VariableUtils.address.value);
    cityController.text = formatValue(VariableUtils.city.value);
    pincodeController.text = formatValue(VariableUtils.pincode.value);

    // Region code and Image URL typically have specific formats, so we keep them as is
    regionCodeController.text = VariableUtils.regionCode.value.replaceAll("+", "");
    if (regionCodeController.text.isEmpty) {
      regionCodeController.text = "91";
    }
    imageUrl = VariableUtils.imageUrl.value;
    getSettings();
  }

  @override
  void onClose() {
    customFieldControllers.forEach((key, controller) {
      controller.dispose();
    });
    super.onClose();
  }

  Future<void> getSettings() async {
    try {
      final response = await StringUtils.client.getThemeSettings(
        ConfigUtils.hospitalSku,
      );

      settingModel = response;

      customFields = response.data?.patient_custom_fields ?? [];

      // Reset and clear all maps
      customFieldToggles.clear();
      customFieldControllers.clear();
      customFieldFiles.clear();
      customFieldFileUrls.clear();

      for (var field in customFields) {
        if (field.id != null) {
          if (field.field_type_name == "toggle") {
            customFieldToggles[field.id!] = false; // default OFF
          } else if (field.field_type_name == "text" || field.field_type_name == "number") {
            customFieldControllers[field.id!] = TextEditingController();
          } else if (field.field_type_name == "fileUpload") {
            customFieldFiles[field.id!] = null;
            customFieldFileUrls[field.id!] = null;
          }
        }
      }

      // Fetch profile to pre-populate saved values
      try {
        final profileResponse = await StringUtils.client.getProfile(
          PreferenceUtils.getStringValue("token"),
        );
        final customFieldMap = profileResponse.data?.custom_field;
        if (customFieldMap != null) {
          customFieldMap.forEach((key, value) {
            // Key format: "field65" → extract numeric id "65"
            final idStr = key.replaceAll(RegExp(r'[^0-9]'), '');
            final fieldId = int.tryParse(idStr);
            if (fieldId != null) {
              // Find matching custom field to check type
              PatientCustomField? matchedField;
              for (final f in customFields) {
                if (f.id == fieldId) {
                  matchedField = f;
                  break;
                }
              }
              if (matchedField != null) {
                if (matchedField.field_type_name == "toggle") {
                  customFieldToggles[fieldId] =
                      value == 1 || value == "1" || value == true;
                } else if (matchedField.field_type_name == "text" || matchedField.field_type_name == "number") {
                  if (customFieldControllers.containsKey(fieldId)) {
                    customFieldControllers[fieldId]!.text = value?.toString() ?? "";
                  }
                } else if (matchedField.field_type_name == "fileUpload") {
                  if (value != null && value.toString().isNotEmpty) {
                    customFieldFileUrls[fieldId] = value.toString();
                  }
                }
              }
            }
          });
        }
      } catch (profileError) {
        debugPrint('Profile fetch error: $profileError');
      }

      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void pickImage(BuildContext context) async {
    file = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 1024,
      maxHeight: 1024,
    );
    if (file != null) {
      showFile = true;
      update();
    }
  }

  void pickCustomFieldFile(int fieldId) async {
    final XFile? pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 1024,
      maxHeight: 1024,
    );
    if (pickedFile != null) {
      customFieldFiles[fieldId] = pickedFile;
      update();
    }
  }

  void updateProfile({VoidCallback? onSuccess}) {
    isLoading = true;
    update(); // 🔥 important

    if (firstNameController.text.trim().isEmpty) {
      isLoading = false;
      update();
      DisplaySnackBar.displaySnackBar(
          "Please enter first name", 3, ColorConst.redColor);

    } else if (lastNameController.text.trim().isEmpty) {
      isLoading = false;
      update();
      DisplaySnackBar.displaySnackBar(
          "Please enter last name", 3, ColorConst.redColor);

    } else if (emailController.text.trim().isEmpty) {
      isLoading = false;
      update();
      DisplaySnackBar.displaySnackBar(
          "Please enter email address", 3, ColorConst.redColor);

    } else if (!RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(emailController.text)) {
      isLoading = false;
      update();
      DisplaySnackBar.displaySnackBar(
          "Please enter valid email address", 3, ColorConst.redColor);

    } else if (phoneController.text.trim().isEmpty) {
      isLoading = false;
      update();
      DisplaySnackBar.displaySnackBar(
          "Please enter phone no", 3, ColorConst.redColor);

    } else {
      // Validate custom fields
      for (final field in customFields) {
        if (field.id != null && field.is_required == true) {
          if (field.field_type_name == "text" || field.field_type_name == "number") {
            final val = customFieldControllers[field.id]?.text.trim() ?? "";
            if (val.isEmpty) {
              isLoading = false;
              update();
              DisplaySnackBar.displaySnackBar(
                  "Please enter ${field.field_name}", 3, ColorConst.redColor);
              return;
            }
          } else if (field.field_type_name == "fileUpload") {
            final fileVal = customFieldFiles[field.id];
            final urlVal = customFieldFileUrls[field.id];
            if (fileVal == null && (urlVal == null || urlVal.isEmpty)) {
              isLoading = false;
              update();
              DisplaySnackBar.displaySnackBar(
                  "Please upload ${field.field_name}", 3, ColorConst.redColor);
              return;
            }
          }
        }
      }

      // Build custom fields payload
      final Map<String, dynamic> customFieldsPayload = {};

      for (final field in customFields) {
        if (field.id != null) {
          if (field.field_type_name == "toggle") {
            customFieldsPayload["field${field.id}"] =
                (customFieldToggles[field.id] ?? false) ? "1" : "0";
          } else if (field.field_type_name == "text" || field.field_type_name == "number") {
            customFieldsPayload["field${field.id}"] =
                customFieldControllers[field.id]?.text ?? "";
          }
        }
      }

      final _data = FormData();
      _data.fields.add(MapEntry('first_name', firstNameController.text));
      _data.fields.add(MapEntry('last_name', lastNameController.text));
      _data.fields.add(MapEntry('email', emailController.text));
      _data.fields.add(MapEntry('phone', phoneController.text));
      _data.fields.add(MapEntry('region_code', "+${regionCodeController.text}"));
      _data.fields.add(MapEntry('address', addressController.text));
      _data.fields.add(MapEntry('city', cityController.text));
      _data.fields.add(MapEntry('pincode', pincodeController.text));
      if (file != null) {
        _data.files.add(
          MapEntry(
            'image',
            MultipartFile.fromFileSync(
              file!.path,
              filename: file!.name,
            ),
          ),
        );
      }
      customFieldsPayload.forEach((key, value) {
        if (value != null) {
          _data.fields.add(MapEntry(key, value.toString()));
        }
      });

      // Add custom files or clear deleted ones
      for (final field in customFields) {
        if (field.id != null && field.field_type_name == "fileUpload") {
          final xfile = customFieldFiles[field.id];
          final existingUrl = customFieldFileUrls[field.id];
          if (xfile != null) {
            _data.files.add(
              MapEntry(
                'field${field.id}',
                MultipartFile.fromFileSync(
                  xfile.path,
                  filename: xfile.name,
                ),
              ),
            );
          } else if (existingUrl == null) {
            // User explicitly cleared the existing file and didn't select a new one
            _data.fields.add(MapEntry('field${field.id}', ""));
          }
        }
      }

      // 🔍 DEBUG: Print full payload before sending
      debugPrint('===== editProfile Payload =====');
      for (final entry in _data.fields) {
        debugPrint('  [FIELD] ${entry.key}: ${entry.value}');
      }
      for (final entry in _data.files) {
        debugPrint('  [FILE]  ${entry.key}: ${entry.value.filename}');
      }
      debugPrint('================================');

      StringUtils.client
          .editProfile(
          PreferenceUtils.getStringValue("token"),
          _data)
          .then((value) {
        editProfileModel = value;

        if (editProfileModel!.success == true) {
          VariableUtils.firstName.value = editProfileModel!.data!.first_name!;
          VariableUtils.lastName.value = editProfileModel!.data!.last_name!;
          VariableUtils.email.value = editProfileModel!.data!.email!;
          VariableUtils.phoneNo.value = editProfileModel!.data!.phone!;
          VariableUtils.regionCode.value =
              editProfileModel?.data?.region_code ?? "";
          VariableUtils.address.value =
              editProfileModel?.data?.address?.toString() ?? addressController.text;
          VariableUtils.city.value =
              editProfileModel?.data?.city ?? cityController.text;
          VariableUtils.pincode.value =
              editProfileModel?.data?.pincode ?? pincodeController.text;
          VariableUtils.imageUrl.value =
              StringUtils.fixImageUrl(editProfileModel!.data!.profile_image!);

          PreferenceUtils.setStringValue(
              "first_name", editProfileModel!.data!.first_name!);
          PreferenceUtils.setStringValue(
              "last_name", editProfileModel!.data!.last_name!);
          PreferenceUtils.setStringValue(
              "email", editProfileModel!.data!.email!);
          PreferenceUtils.setStringValue(
              "phone", editProfileModel!.data!.phone!);
          PreferenceUtils.setStringValue(
              "region_code", editProfileModel?.data?.region_code ?? "");
          PreferenceUtils.setStringValue(
              "address", editProfileModel?.data?.address?.toString() ?? addressController.text);
          PreferenceUtils.setStringValue(
              "city", editProfileModel?.data?.city ?? cityController.text);
          PreferenceUtils.setStringValue(
              "pincode", editProfileModel?.data?.pincode ?? pincodeController.text);
          PreferenceUtils.setStringValue(
              "profile_image",
              StringUtils.fixImageUrl(editProfileModel!.data!.profile_image!));
        }

        // 🔥 stop loading ALWAYS
        isLoading = false;
        update();

        DisplaySnackBar.displaySnackBar(
            editProfileModel!.message!, 3, ColorConst.greenColor);

        if (onSuccess != null) {
          onSuccess();
        } else {
          Get.back();
        }

      }).onError((DioException error, stackTrace) {
        // 🔥 stop loading on API error
        isLoading = false;
        update();

        CheckSocketException.checkSocketException(error);
      });
    }
  }
  // void updateProfile({VoidCallback? onSuccess}) {
  //   isLoading = true;
  //   String pattern =
  //       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  //   RegExp regExp = RegExp(pattern);
  //   if (firstNameController.text.trim().isEmpty) {
  //     DisplaySnackBar.displaySnackBar(
  //         "Please enter first name", 3, ColorConst.redColor);
  //   } else if (lastNameController.text.trim().isEmpty) {
  //     DisplaySnackBar.displaySnackBar(
  //         "Please enter last name", 3, ColorConst.redColor);
  //   } else if (emailController.text.trim().isEmpty) {
  //     DisplaySnackBar.displaySnackBar(
  //         "Please enter email address", 3, ColorConst.redColor);
  //   } else if (!regExp.hasMatch(emailController.text)) {
  //     DisplaySnackBar.displaySnackBar(
  //         "Please enter valid email address", 3, ColorConst.redColor);
  //   } else if (phoneController.text.trim().isEmpty) {
  //     DisplaySnackBar.displaySnackBar(
  //         "Please enter phone no", 3, ColorConst.redColor);
  //   } else {
  //     StringUtils.client
  //         .editProfile(
  //             PreferenceUtils.getStringValue("token"),
  //             firstNameController.text,
  //             lastNameController.text,
  //             emailController.text,
  //             phoneController.text,
  //             "+${regionCodeController.text}",
  //             addressController.text,
  //             cityController.text,
  //             pincodeController.text,
  //             file == null ? null : File(file!.path))
  //         .then((value) {
  //       editProfileModel = value;
  //
  //       if (editProfileModel!.success == true) {
  //         // isLoading = false;
  //         VariableUtils.firstName.value = editProfileModel!.data!.first_name!;
  //         VariableUtils.lastName.value = editProfileModel!.data!.last_name!;
  //         VariableUtils.email.value = editProfileModel!.data!.email!;
  //         VariableUtils.phoneNo.value = editProfileModel!.data!.phone!;
  //         VariableUtils.regionCode.value =
  //             editProfileModel?.data?.region_code ?? "";
  //         VariableUtils.address.value =
  //             editProfileModel?.data?.address ?? addressController.text;
  //         VariableUtils.city.value =
  //             editProfileModel?.data?.city ?? cityController.text;
  //         VariableUtils.pincode.value =
  //             editProfileModel?.data?.pincode ?? pincodeController.text;
  //         VariableUtils.imageUrl.value =
  //             StringUtils.fixImageUrl(editProfileModel!.data!.profile_image!);
  //
  //         PreferenceUtils.setStringValue(
  //             "first_name", editProfileModel!.data!.first_name!);
  //         PreferenceUtils.setStringValue(
  //             "last_name", editProfileModel!.data!.last_name!);
  //         PreferenceUtils.setStringValue(
  //             "email", editProfileModel!.data!.email!);
  //         PreferenceUtils.setStringValue(
  //             "phone", editProfileModel!.data!.phone!);
  //         PreferenceUtils.setStringValue(
  //             "region_code", editProfileModel?.data?.region_code ?? "");
  //         PreferenceUtils.setStringValue(
  //             "address", editProfileModel?.data?.address ?? addressController.text);
  //         PreferenceUtils.setStringValue(
  //             "city", editProfileModel?.data?.city ?? cityController.text);
  //         PreferenceUtils.setStringValue(
  //             "pincode", editProfileModel?.data?.pincode ?? pincodeController.text);
  //         PreferenceUtils.setStringValue("profile_image",
  //             StringUtils.fixImageUrl(editProfileModel!.data!.profile_image!));
  //         // Get.back();
  //       }
  //       DisplaySnackBar.displaySnackBar(
  //           editProfileModel!.message!, 3, ColorConst.greenColor);
  //       if (onSuccess != null) {
  //         isLoading = false;
  //         onSuccess(); // Execute the specific navigation for the Complete Profile screen
  //       } else {
  //         Get.back(); // Default behavior for the regular Edit Profile screen
  //       }
  //     }).onError((DioException error, stackTrace) {
  //       isLoading = false;
  //       CheckSocketException.checkSocketException(error);
  //     });
  //   }
  // }

  String getCountryCodeFromDialCode(String dialCode) {
    for (Map<String, String> country in countryList) {
      if (country['dialCode'] == dialCode) {
        return country['code']!;
      }
    }
    return 'IN';
  }
}
