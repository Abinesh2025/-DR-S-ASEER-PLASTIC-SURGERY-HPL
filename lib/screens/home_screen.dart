import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_app_bar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/home_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/variable_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/custom_bottom_nav_bar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/widgets/home_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // HomeController homeController = Get.put(HomeController());
  late HomeController homeController;

  @override
  void initState() {
    super.initState();

    homeController = Get.put(HomeController());

    if (homeController.currentWidget == null) {
      homeController.getHomePageWidget();
    }
    homeController.getAppBarTitle();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GetBuilder<HomeController>(
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            if (homeController.scaffoldKey.currentState!.isDrawerOpen) {
              homeController.scaffoldKey.currentState!.openEndDrawer();
              return false;
            } else {
              controller.onBackButton(context, height, width);
              return false;
            }
          },
          child: Scaffold(
            extendBody: true,
            backgroundColor: ColorConst.whiteColor,
            key: homeController.scaffoldKey,
            appBar: controller.showAppBar.value
                ? CommonAppBar(
                    isGradient: controller.currentBottomIndex.value == 3,
                    title: controller.appBarTitle.value,
                    leadOnTap: () {
                      VariableUtils.firstName.value =
                          PreferenceUtils.getStringValue("first_name");
                      VariableUtils.lastName.value =
                          PreferenceUtils.getStringValue("last_name");
                      VariableUtils.email.value =
                          PreferenceUtils.getStringValue("email");
                      VariableUtils.phoneNo.value =
                          PreferenceUtils.getStringValue("phone_number");
                      VariableUtils.regionCode.value =
                          PreferenceUtils.getStringValue("region_code");
                      VariableUtils.imageUrl.value =
                          PreferenceUtils.getStringValue("image_url");
                      VariableUtils.patientId.value =
                          PreferenceUtils.getStringValue("id");
                      homeController.scaffoldKey.currentState?.openDrawer();
                    },
                    leadIcon:
                        const Icon(Icons.menu, color: ColorConst.blackColor),
                  )
                : null,
            drawer: const HomeDrawer(),
            body: controller.currentWidget,
            bottomNavigationBar: PreferenceUtils.getStringValue("role") ==
                        "Patient" ||
                    (PreferenceUtils.getStringValue("role") != "Super Admin" &&
                        PreferenceUtils.getStringValue("role") != "Admin" &&
                        PreferenceUtils.getStringValue("role") != "Doctor")
                ? CustomBottomNavBar(
                    currentIndex: controller.currentBottomIndex.value,
                    onTap: (index) {
                      controller.changeBottomNavIndex(index);
                    },
                  )
                : null,
          ),
        );
      },
    );
  }
}
