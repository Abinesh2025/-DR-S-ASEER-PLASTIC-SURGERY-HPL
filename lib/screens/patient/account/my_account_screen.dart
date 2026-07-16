import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/notification/notification_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/my_account_controller/my_account_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/account/change_password_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/account/edit_profile_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/variable_utils.dart';

import 'language_button/language_button.dart';

class MyAccountScreen extends StatelessWidget {
  final bool isBottomNavItem;
  MyAccountScreen({Key? key, this.isBottomNavItem = false}) : super(key: key);
  final MyAccountController myAccountController =
      Get.put(MyAccountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9FAFB), // Subtle off-white background
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              // 2. Profile Info Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    // Avatar with subtle glow/shadow
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Obx(
                        () => ClipOval(
                          child: VariableUtils.imageUrl.value.isEmpty
                              ? Container(
                                  color: const Color(0xffE5E7EB),
                                  child: Icon(CupertinoIcons.person_solid,
                                      size: 40, color: Colors.grey[500]),
                                )
                              : FadeInImage(
                                  placeholder:
                                      const AssetImage(ImageUtils.patientIcon),
                                  image: NetworkImage(VariableUtils.imageUrl.value
                                      .replaceAll(" ", "")),
                                  fit: BoxFit.cover,
                                  imageErrorBuilder: (c, e, s) => Container(
                                    color: const Color(0xffE5E7EB),
                                    child: Icon(CupertinoIcons.person_solid,
                                        size: 40, color: Colors.grey[500]),
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    // Name and Email
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => Text(
                              "${VariableUtils.firstName.value} ${VariableUtils.lastName.value}",
                              style: TextStyleConst.boldTextStyle(
                                  Colors.black87, 20),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Obx(
                            () => Text(
                              VariableUtils.email.value,
                              style: TextStyleConst.mediumTextStyle(
                                  Colors.grey.shade500, 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Badge (Patient)
                    // Container(
                    //   padding:
                    //       const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    //   decoration: BoxDecoration(
                    //     color: const Color(0xff4B8BF3),
                    //     borderRadius: BorderRadius.circular(20),
                    //   ),
                    //   child: Text(
                    //     "Patient",
                    //     style: TextStyleConst.boldTextStyle(Colors.white, 12),
                    //   ),
                    // ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // 3. Stats Board
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: Container(
              //     padding: const EdgeInsets.all(20),
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(20),
              //       border: Border.all(color: Colors.grey.shade100),
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.black.withOpacity(0.02),
              //           blurRadius: 15,
              //           offset: const Offset(0, 5),
              //         ),
              //       ],
              //     ),
              //     child: Row(
              //       children: [
              //         _buildStatItem(
              //           icon: CupertinoIcons.calendar,
              //           label: "Appointments",
              //           value: "12",
              //           trend: "+ 5.2%",
              //           trendUp: true,
              //         ),
              //         _buildDivider(),
              //         _buildStatItem(
              //           icon: CupertinoIcons.star,
              //           label: "Reviews",
              //           value: "4.8",
              //           trend: "- 1.5%",
              //           trendUp: false,
              //         ),
              //         _buildDivider(),
              //         _buildStatItem(
              //           icon: CupertinoIcons.creditcard,
              //           label: "Balance",
              //           value: "₹2,450",
              //           trend: "+ 8.3%",
              //           trendUp: true,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),

              // const SizedBox(height: 30),

              // 4. Menu Section Header
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: Text(
              //     "General",
              //     style: TextStyleConst.boldTextStyle(Colors.black87, 18),
              //   ),
              // ),

              // 5. Menu List
              Container(
                margin: const EdgeInsets.only(top: 30,left: 10,bottom: 20,right: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft:
                      Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  border: Border.all(
                    color: Colors.grey.shade200,
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top:10.0,bottom: 10.0),
                  child: Column(
                    children: [
                      // const SizedBox(height: 15),
                      // _buildMenuItem(
                      //   icon: CupertinoIcons.gift,
                      //   title: "Refer a friend",
                      //   onTap: () {},
                      // ),
                      _buildMenuItem(
                        icon: CupertinoIcons.bell,
                        title: StringUtils.notification,
                        onTap: () => Get.to(() => NotificationScreen(),
                            transition: Transition.rightToLeft),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0,right: 20),
                        child: const Divider(
                          color: Color(0xFFE0E0E0), // grey 200
                          thickness: 1,
                          height: 1,
                        ),
                      ),


                      LanguageButton(),

                      Padding(
                        padding: const EdgeInsets.only(left: 20.0,right: 20),
                        child: const Divider(
                          color: Color(0xFFE0E0E0), // grey 200
                          thickness: 1,
                          height: 1,
                        ),
                      ),
                      // _buildMenuItem(
                      //   icon: CupertinoIcons.settings,
                      //   title: "Settings",
                      //   onTap: () {},
                      // ),
                      // _buildMenuItem(
                      //   icon: CupertinoIcons.info_circle,
                      //   title: "Help center",
                      //   onTap: () {},
                      // ),
                      // _buildMenuItem(
                      //   icon: CupertinoIcons.shield,
                      //   title: "Security & privacy",
                      //   onTap: () {},
                      // ),
                      _buildMenuItem(
                        icon: CupertinoIcons.person,
                        title: StringUtils.editProfile,
                        onTap: () => Get.to(() => EditProfileScreen(),
                            transition: Transition.rightToLeft),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0,right: 20),
                        child: const Divider(
                          color: Color(0xFFE0E0E0), // grey 200
                          thickness: 1,
                          height: 1,
                        ),
                      ),
                      _buildMenuItem(
                        icon: CupertinoIcons.lock,
                        title: StringUtils.changePassword,
                        onTap: () => Get.to(() => ChangePasswordScreen(),
                            transition: Transition.rightToLeft),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0,right: 20),
                        child: const Divider(
                          color: Color(0xFFE0E0E0), // grey 200
                          thickness: 1,
                          height: 1,
                        ),
                      ),
                      _buildLogoutItem(context),
                      // const SizedBox(height: 100), // Space for bottom nav
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required String trend,
    required bool trendUp,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: Colors.grey.shade400),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyleConst.mediumTextStyle(Colors.grey.shade500, 11),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyleConst.boldTextStyle(Colors.black87, 18),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                trendUp ? Icons.arrow_upward : Icons.arrow_downward,
                size: 10,
                color: trendUp ? Colors.green : Colors.red,
              ),
              const SizedBox(width: 4),
              Text(
                trend,
                style: TextStyleConst.boldTextStyle(
                    trendUp ? Colors.green : Colors.red, 10),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 40,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.grey.shade100,
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Row(
              children: [
                Icon(icon, size: 24, color: Colors.black87.withOpacity(0.7)),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyleConst.mediumTextStyle(Colors.black87, 18),
                  ),
                ),
                Icon(CupertinoIcons.chevron_forward,
                    size: 18, color: Colors.grey.shade400),
              ],
            ),
          ),
        ),
        // Divider(height: 1, indent: 70, endIndent: 25, color: Colors.grey.shade50),
      ],
    );
  }

  Widget _buildLogoutItem(BuildContext context) {
    return InkWell(
      onTap: () => _showLogoutDialog(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Row(
          children: [
            const Icon(CupertinoIcons.square_arrow_right,
                size: 24, color: Colors.black87),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                StringUtils.logOut,
                style: TextStyleConst.mediumTextStyle(Colors.black87, 18),
              ),
            ),
            Icon(CupertinoIcons.chevron_forward,
                size: 18, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      CupertinoIcons.exclamationmark_triangle_fill,
                      color: Colors.red,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    StringUtils.logoutTitle,
                    style: TextStyleConst.boldTextStyle(
                      ColorConst.blackColor,
                      22,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    StringUtils.logoutConfirmation,
                    textAlign: TextAlign.center,
                    style: TextStyleConst.mediumTextStyle(
                      Colors.grey.shade600,
                      14,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Get.back(),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: Colors.grey.shade100,
                          ),
                          child: Text(
                            StringUtils.cancel,
                            style: TextStyleConst.boldTextStyle(
                              Colors.grey.shade700,
                              16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => myAccountController.logout(),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: Colors.red,
                            elevation: 0,
                          ),
                          child: Text(
                            StringUtils.logOut,
                            style: TextStyleConst.boldTextStyle(
                              Colors.white,
                              16,
                            ),
                          ),
                        ),
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
  }
}
  // Same Safe Logout Dialog Handler
//   void _showLogoutDialog(BuildContext context, double height, double width) {
//     showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (context) {
//         return Center(
//           child: Material(
//             borderRadius: BorderRadius.circular(24),
//             child: Container(
//               height: height * 0.28,
//               width: width * 0.85,
//               padding: const EdgeInsets.all(24),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(24),
//                 color: Colors.white,
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: Colors.red.withOpacity(0.1),
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(
//                         CupertinoIcons.exclamationmark_triangle_fill,
//                         color: Colors.red,
//                         size: 32),
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     "Log Out",
//                     style:
//                         TextStyleConst.boldTextStyle(ColorConst.blackColor, 22),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     "Are you sure you want to log out of your account?",
//                     textAlign: TextAlign.center,
//                     style: TextStyleConst.mediumTextStyle(
//                         Colors.grey.shade600, 14),
//                   ),
//                   const Spacer(),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: TextButton(
//                           onPressed: () => Get.back(),
//                           style: TextButton.styleFrom(
//                             padding: const EdgeInsets.symmetric(vertical: 14),
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12)),
//                             backgroundColor: Colors.grey.shade100,
//                           ),
//                           child: Text(StringUtils.cancel,
//                               style: TextStyleConst.boldTextStyle(
//                                   Colors.grey.shade700, 16)),
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: () => myAccountController.logout(),
//                           style: ElevatedButton.styleFrom(
//                             padding: const EdgeInsets.symmetric(vertical: 14),
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12)),
//                             backgroundColor: Colors.red,
//                             elevation: 0,
//                           ),
//                           child: Text(StringUtils.logOut,
//                               style: TextStyleConst.boldTextStyle(
//                                   Colors.white, 16)),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
