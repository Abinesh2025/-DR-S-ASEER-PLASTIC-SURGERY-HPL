import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/home_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/list_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/variable_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_button.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Drawer(
          width: width / 1.3,
          backgroundColor:ColorConst.primaryColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  child: Row(
                    children: [
                      Obx(
                        () {
                          String placeholder =
                              PreferenceUtils.getStringValue("role") == "Doctor"
                                  ? ImageUtils.doctorIcon
                                  : ImageUtils.patientIcon;
                          return Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.9),
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: ClipOval(
                              child: VariableUtils.imageUrl.value.isEmpty
                                  ? Image.asset(
                                      placeholder,
                                      fit: BoxFit.contain,
                                    )
                                  : FadeInImage(
                                      placeholder: AssetImage(placeholder),
                                      image: NetworkImage(VariableUtils
                                          .imageUrl.value
                                          .replaceAll(" ", "")),
                                      imageErrorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          placeholder,
                                          fit: BoxFit.contain,
                                        );
                                      },
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Obx(
                              () => Text(
                                "${VariableUtils.firstName.value} ${VariableUtils.lastName.value}",
                                style: TextStyleConst.boldTextStyle(
                                  ColorConst.whiteColor,
                                  18,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Obx(
                              () => Text(
                                VariableUtils.email.value,
                                style: TextStyleConst.mediumTextStyle(
                                  ColorConst.whiteColor.withOpacity(0.8),
                                  12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                    color: Colors.white24,
                    height: 1,
                    indent: 20,
                    endIndent: 20),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
                    physics: const BouncingScrollPhysics(),
                    itemCount: PreferenceUtils.getStringValue("role") ==
                            "Super Admin"
                        ? ListUtils.superAdminDrawerList.length
                        : PreferenceUtils.getStringValue("role") == "Admin"
                            ? ListUtils.adminDrawerList.length
                            : PreferenceUtils.getStringValue("role") == "Doctor"
                                ? ListUtils.doctorDrawerList.length
                                : ListUtils.drawerList.length,
                    itemBuilder: (context, index) {
                      bool isSelected =
                          index == controller.currentDrawerIndex.value;
                      var item = PreferenceUtils.getStringValue("role") ==
                              "Super Admin"
                          ? ListUtils.superAdminDrawerList[index]
                          : PreferenceUtils.getStringValue("role") == "Admin"
                              ? ListUtils.adminDrawerList[index]
                              : PreferenceUtils.getStringValue("role") ==
                                      "Doctor"
                                  ? ListUtils.doctorDrawerList[index]
                                  : ListUtils.drawerList[index];

                      return Builder(
                        builder: (builderContext) {
                          return GestureDetector(
                            onTap: () {
                              PreferenceUtils.getStringValue("role") ==
                                      "Super Admin"
                                  ? controller.changeSuperAdminWidget(index)
                                  : PreferenceUtils.getStringValue("role") ==
                                          "Admin"
                                      ? controller.changeAdminWidget(index)
                                      : PreferenceUtils.getStringValue(
                                                  "role") ==
                                              "Doctor"
                                          ? controller.changeDoctorWidget(index)
                                          : controller.changeWidget(index);
                              // Close drawer after selection
                              Scaffold.of(builderContext).closeDrawer();
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.white.withOpacity(0.95)
                                    : Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? ColorConst.primaryColor
                                            : Colors.white24,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: ImageIcon(
                                          AssetImage(item["icon"]),
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.white70,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: Text(
                                        item["title"],
                                        style: TextStyleConst.mediumTextStyle(
                                          isSelected
                                              ? ColorConst.blackColor
                                              : ColorConst.whiteColor,
                                          15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                // Log Out Section
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                    bottom: 20 + MediaQuery.of(context).padding.bottom,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return Center(
                            child: Material(
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                height: height / 4,
                                width: width / 1.12,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: height * 0.03),
                                    Text(
                                      StringUtils.logoutTitle,
                                      style: TextStyleConst.boldTextStyle(
                                        ColorConst.blackColor,
                                        width * 0.05,
                                      ),
                                    ),
                                    SizedBox(height: height * 0.01),
                                    Text(
                                      StringUtils.logoutShortConfirmation,
                                      textAlign: TextAlign.center,
                                      style: TextStyleConst.mediumTextStyle(
                                        ColorConst.hintGreyColor,
                                        width * 0.042,
                                      ),
                                    ),
                                    SizedBox(height: height * 0.03),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CommonButton(
                                          textStyleConst:
                                              TextStyleConst.mediumTextStyle(
                                            ColorConst.whiteColor,
                                            width * 0.05,
                                          ),
                                          onTap: () {
                                            controller.logOut(context);
                                          },
                                          color: ColorConst.primaryColor,
                                          text: StringUtils.logOut,
                                          width: width / 2.5,
                                          height: 50,
                                        ),
                                        CommonButton(
                                          textStyleConst:
                                              TextStyleConst.mediumTextStyle(
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
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(35),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.logout, color: Colors.white70),
                          const SizedBox(width: 10),
                          Text(
                            StringUtils.logOut,
                            style:
                                TextStyleConst.boldTextStyle(Colors.white, 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
