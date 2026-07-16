import 'package:flutter/material.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class CommonPhoneTextField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(PhoneNumber?)? onChanged;
  final void Function(Country)? onCountryChanged;
  final String? initialCountryCode;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Function(String)? onSubmitted;

  const CommonPhoneTextField({
    Key? key,
    required this.controller,
    this.onChanged,
    this.onCountryChanged,
    this.initialCountryCode,
    this.textInputAction,
    this.focusNode,
    this.onSubmitted
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return IntlPhoneField(
    disableLengthCheck: false,
    initialCountryCode: initialCountryCode,
    textInputAction: textInputAction,
    focusNode: focusNode,
    validator: (PhoneNumber? phonenumber){
      if(phonenumber == null || phonenumber.countryCode != initialCountryCode) {
        return "Please enter valid phone number";
      }
        return null;
    },
      onSubmitted : onSubmitted,
    onChanged: onChanged,
      onCountryChanged: onCountryChanged,
    flagsButtonPadding: const EdgeInsets.all(8),
    dropdownIcon: const Icon(Icons.arrow_drop_down,color: ColorConst.blackColor,),
    dropdownIconPosition: IconPosition.trailing,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    decoration: InputDecoration(
      counter: const SizedBox(),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: ColorConst.borderGreyColor, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: ColorConst.borderGreyColor, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: ColorConst.borderGreyColor, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: ColorConst.borderGreyColor, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: ColorConst.borderGreyColor, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: ColorConst.borderGreyColor, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    style: TextStyleConst.mediumTextStyle(
      ColorConst.blackColor,
      width * 0.04,
    ),
    controller: controller,
      );
  }
}
