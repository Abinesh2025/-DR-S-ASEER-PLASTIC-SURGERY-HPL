// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_app_bar.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_button.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_dropdown_button.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_required_text.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_text.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_text_field.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/bed_assign_controller/new_bed_controller.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
//
// class NewBedScreen extends StatelessWidget {
//   final String? bedId;
//   NewBedScreen({Key? key, this.bedId}) : super(key: key);
//   final NewBedController newBedController = Get.put(NewBedController());
//
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     return SafeArea(
//       child: GestureDetector(
//         onTap: () {
//           FocusScope.of(context).requestFocus(FocusNode());
//         },
//         child: Scaffold(
//             backgroundColor: ColorConst.whiteColor,
//             appBar: CommonAppBar(
//               title: "New Bed Assign",
//               leadOnTap: () {
//                 Get.back();
//               },
//               leadIcon: const Icon(
//                 Icons.arrow_back_rounded,
//                 color: ColorConst.blackColor,
//               ),
//             ),
//             body: Obx(
//               () => newBedController.gotDropDownData.value == false
//                   ? const Center(child: CircularProgressIndicator())
//                   : SingleChildScrollView(
//                       physics: const BouncingScrollPhysics(),
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             CommonRequiredText(width: width, text: StringUtils.newCase),
//                             const SizedBox(height: 10),
//
//                             /// Case
//                             CommonDropDown(
//                               color: newBedController.patientCases?.data?.isEmpty ?? true ? ColorConst.bgGreyColor : ColorConst.whiteColor,
//                               onChange: newBedController.patientCases?.data?.isEmpty ?? true
//                                   ? null
//                                   : (value) {
//                                       newBedController.caseChoice(value ?? "");
//                                     },
//                               dropdownItems: newBedController.patientCases?.data?.map((value) {
//                                     return DropdownMenuItem<String>(
//                                       value: value.patient_case.toString(),
//                                       child: Text(
//                                         value.patient_case ?? "",
//                                       ),
//                                     );
//                                   }).toList() ?? [],
//                               hintText: "Select Case",
//                             ),
//                             SizedBox(height: height * 0.02),
//                             CommonRequiredText(width: width, text: StringUtils.ipdPatient),
//                             SizedBox(height: height * 0.01),
//
//                             /// IPD Patient
//                             CommonDropDown(
//                               color: ColorConst.bgGreyColor,
//                                value: newBedController.patientId.value,
//                               onChange: (value){
//                                 newBedController.patientId.value = value!;
//                                 newBedController.update();
//                               },
//                               dropdownItems: newBedController.gotDropDownData.value != false
//                                   ? newBedController.ipdPatientsModel?.data?.map((value) {
//                                     return DropdownMenuItem<String>(
//                                       value: value.id.toString(),
//                                       child: Text(
//                                         value.ipd_number ?? "",
//                                       ),
//                                     );
//                                   }).toList() ?? [] : [],
//                               hintText: "Select IPD Patient",
//                             ),
//                             SizedBox(height: height * 0.02),
//                             CommonRequiredText(width: width, text: StringUtils.bedInEditBed),
//                             SizedBox(height: height * 0.01),
//
//                             /// Bed
//                             CommonDropDown(
//                               onChange: (value) {
//                                 newBedController.bedId = value ?? "";
//                               },
//                               value: bedId ,
//                               dropdownItems: newBedController.bedsModel?.data?.map((value) {
//                                     return DropdownMenuItem<String>(
//                                       value: value.id.toString(),
//                                       child: Text(
//                                         value.name ?? "",
//                                       ),
//                                     );
//                                   }).toList() ?? [],
//                               hintText: "Select Bed",
//                             ),
//                             SizedBox(height: height * 0.02),
//                             CommonRequiredText(width: width, text: StringUtils.assignDate),
//                             SizedBox(height: height * 0.01),
//                             GestureDetector(
//                               onTap: () {
//                                 newBedController.selectAssignDate(context);
//                               },
//                               child: AbsorbPointer(
//                                 child: CommonTextField(
//                                   validator: (value) {
//                                     return null;
//                                   },
//                                   controller: newBedController.dateController,
//                                   hintText: StringUtils.selectDate,
//                                     suffixIcon: const Icon(
//                                       Icons.calendar_month,
//                                       color: ColorConst.blueColor,
//                                     ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: height * 0.02),
//                             CommonText(width: width, text: StringUtils.description),
//                             SizedBox(height: height * 0.01),
//                             CommonTextField(
//                               hintText: StringUtils.typeHere,
//                               maxLine: 4,
//                               validator: (value) {
//                                 return null;
//                               },
//                               controller: newBedController.notesController,
//                             ),
//                             SizedBox(height: height * 0.03),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 CommonButton(
//                                   textStyleConst: TextStyleConst.mediumTextStyle(ColorConst.whiteColor, width * 0.05),
//                                   onTap: () {
//                                     newBedController.createNewBedAssign();
//                                   },
//                                   color: ColorConst.blueColor,
//                                   text: StringUtils.save,
//                                   width: width / 2.3,
//                                   height: 50,
//                                 ),
//                                 CommonButton(
//                                   textStyleConst: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, width * 0.05),
//                                   onTap: () {
//                                     Get.back();
//                                   },
//                                   color: ColorConst.borderGreyColor,
//                                   text: StringUtils.cancel,
//                                   width: width / 2.3,
//                                   height: 50,
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: height * 0.03),
//                           ],
//                         ),
//                       ),
//                     ),
//             )),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_app_bar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_button.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_dropdown_button.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_required_text.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_text.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_text_field.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/bed_assign_controller/new_bed_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class NewBedScreen extends StatelessWidget {
  final String? bedId;
  NewBedScreen({Key? key, this.bedId}) : super(key: key);

  final NewBedController newBedController = Get.put(NewBedController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
          backgroundColor: ColorConst.whiteColor,
          appBar: CommonAppBar(
            title: "New Bed Assign",
            leadOnTap: () {
              Get.back();
            },
            leadIcon: const Icon(
              Icons.arrow_back_rounded,
              color: ColorConst.blackColor,
            ),
          ),
          body: Obx(
                () => newBedController.gotDropDownData.value == false
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonRequiredText(width: width, text: StringUtils.newCase),
                    const SizedBox(height: 10),
    
                    /// Case DropDown
                    CommonDropDown(
                      // 🔥 ADDED VALUE BINDING HERE
                      value: newBedController.selectedCase.value,
                      color: newBedController.patientCases?.data?.isEmpty ?? true ? ColorConst.bgGreyColor : ColorConst.whiteColor,
                      onChange: newBedController.patientCases?.data?.isEmpty ?? true
                          ? null
                          : (value) {
                        newBedController.caseChoice(value ?? "");
                      },
                      dropdownItems: newBedController.patientCases?.data?.map((value) {
                        return DropdownMenuItem<String>(
                          value: value.patient_case.toString(),
                          child: Text(
                            value.patient_case ?? "",
                          ),
                        );
                      }).toList() ?? [],
                      hintText: "Select Case",
                    ),
    
                    SizedBox(height: height * 0.02),
                    CommonRequiredText(width: width, text: StringUtils.ipdPatient),
                    SizedBox(height: height * 0.01),
    
                    /// IPD Patient DropDown
                    CommonDropDown(
                      // 🔥 FIXED VALUE BINDING HERE
                      value: newBedController.patientId.value,
                      color: ColorConst.bgGreyColor,
                      onChange: (value){
                        newBedController.patientId.value = value;
                      },
                      dropdownItems: newBedController.gotDropDownData.value != false
                          ? newBedController.ipdPatientsModel?.data?.map((value) {
                        return DropdownMenuItem<String>(
                          value: value.id.toString(),
                          child: Text(
                            value.ipd_number ?? "",
                          ),
                        );
                      }).toList() ?? [] : [],
                      hintText: "Select IPD Patient",
                    ),
    
                    SizedBox(height: height * 0.02),
                    CommonRequiredText(width: width, text: StringUtils.bedInEditBed),
                    SizedBox(height: height * 0.01),
    
                    /// Bed DropDown
                    CommonDropDown(
                      // 🔥 FIXED VALUE BINDING HERE (Fallbacks to the param passed from the previous screen)
                      value: newBedController.bedId.value ?? bedId,
                      onChange: (value) {
                        newBedController.bedId.value = value;
                      },
                      dropdownItems: newBedController.bedsModel?.data?.map((value) {
                        return DropdownMenuItem<String>(
                          value: value.id.toString(),
                          child: Text(
                            value.name ?? "",
                          ),
                        );
                      }).toList() ?? [],
                      hintText: "Select Bed",
                    ),
    
                    SizedBox(height: height * 0.02),
                    CommonRequiredText(width: width, text: StringUtils.assignDate),
                    SizedBox(height: height * 0.01),
    
                    GestureDetector(
                      onTap: () {
                        newBedController.selectAssignDate(context);
                      },
                      child: AbsorbPointer(
                        child: CommonTextField(
                          validator: (value) {
                            return null;
                          },
                          controller: newBedController.dateController,
                          hintText: StringUtils.selectDate,
                          suffixIcon: const Icon(
                            Icons.calendar_month,
                            color: ColorConst.blueColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    CommonText(width: width, text: StringUtils.description),
                    SizedBox(height: height * 0.01),
                    CommonTextField(
                      hintText: StringUtils.typeHere,
                      maxLine: 4,
                      validator: (value) {
                        return null;
                      },
                      controller: newBedController.notesController,
                    ),
                    SizedBox(height: height * 0.03),
    
                  
                    // SizedBox(height: height * 0.03),
                  ],
                ),
              ),
            ),
          ),bottomNavigationBar:   SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top:2.0,bottom:10, left: 8,right: 8 ),
              child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
              Expanded(
                child: CommonButton(
                  textStyleConst: TextStyleConst.mediumTextStyle(ColorConst.whiteColor, width * 0.05),
                  onTap: () {
                    // 🔥 pass bedId here in case user didn't change the dropdown
                    newBedController.createNewBedAssign(bedId);
                  },
                  color: ColorConst.blueColor,
                  text: StringUtils.save,
                  width: width / 2.3,
                  height: 50,
                ),
              ),
              SizedBox(width: 10,),

              Expanded(
                child: CommonButton(
                  textStyleConst: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, width * 0.05),
                  onTap: () {
                    Get.back();
                  },
                  color: ColorConst.borderGreyColor,
                  text: StringUtils.cancel,
                  width: width / 2.3,
                  height: 50,
                ),
              ),
                      ],
                    ),
            ),
          ),),
      
      
    );
  }
}