import 'package:flutter/material.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:flutter/services.dart';

class CommonTextField extends StatelessWidget {
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final VoidCallback? onTap;
  final String? Function(String?) validator;
  final TextEditingController controller;
  final int? maxLine;
  final int? minLine;
  final TextInputType? keyBoardType;
  final bool readOnly;
  final bool? obscureText;
  final TextInputAction? textInputAction;
  final Function(String)? onSubmitted;
  final FocusNode? focusNode;
  final Function()? onEditingComplete;
  final double? borderRadius;
  final List<TextInputFormatter>? inputFormatters;

  const CommonTextField({
    Key? key,
    this.maxLine,
    this.readOnly = false,
    this.minLine,
    this.keyBoardType,
    this.hintText,
    required this.validator,
    this.suffixIcon,
    this.prefixIcon,
    required this.controller,
    this.onTap,
    this.obscureText,
    this.textInputAction,
    this.onSubmitted,
    this.focusNode,
    this.onEditingComplete,
    this.borderRadius,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return TextFormField(
      style: TextStyleConst.mediumTextStyle(
       readOnly == false ? ColorConst.blackColor : ColorConst.hintGreyColor,
        width * 0.04,
      ),
      obscureText: obscureText ?? false,
      readOnly: readOnly,
      keyboardType: keyBoardType,
      maxLines: maxLine ?? 1,
      minLines: minLine,
      onTap: onTap,
      controller: controller,
      validator: validator,
      textInputAction: textInputAction,
      focusNode: focusNode,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onSubmitted,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorConst.borderGreyColor, width: 1.5),
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorConst.borderGreyColor, width: 1.5),
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorConst.borderGreyColor, width: 1.5),
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorConst.borderGreyColor, width: 1.5),
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorConst.borderGreyColor, width: 1.5),
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorConst.borderGreyColor, width: 1.5),
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
        ),
        hintText: hintText,
        hintStyle: TextStyleConst.hintTextStyle(ColorConst.hintGreyColor),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon
      ),
    );
  }
}