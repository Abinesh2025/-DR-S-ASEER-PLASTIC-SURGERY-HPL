import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/controller/hospital/hospital_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/screen/Hospital/hospital_detail_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';

import 'add_hospital_screen.dart';
import 'edit_hospital.dart';

class HospitalScreen extends StatelessWidget {
  HospitalScreen({Key? key}) : super(key: key);
  final HospitalController hospitalController = Get.put(HospitalController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          color: ColorConst.whiteColor,
          child: Column(
            children: [
              Container(
                height: 70,
                margin: EdgeInsets.only(top: height * 0.01),
                width: double.infinity,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: hospitalController.hospitalStatus.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Obx(
                            () => GestureDetector(
                          onTap: () {
                            hospitalController.changeIndex(index);
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                left: width * 0.03, right: index == 2 ? 10 : 0),
                            height: 50,
                            decoration:
                            index == hospitalController.currentIndex.value
                                ? BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorConst.blueColor,
                            )
                                : BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 2,
                                color: ColorConst.borderGreyColor,
                              ),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  hospitalController.hospitalStatus[index],
                                  style: TextStyleConst.mediumTextStyle(
                                    index == hospitalController.currentIndex.value
                                        ? ColorConst.whiteColor
                                        : ColorConst.hintGreyColor,
                                    width * 0.04,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Obx(() {
                return hospitalController.isGotData.value == false
                    ?  Expanded(
                      child: Center(
                          child: CircularProgressIndicator(color: ColorConst.primaryColor)),
                    )
                    : hospitalController.filterHospitalModel!.data!.isEmpty
                        ? Expanded(
                          child: Center(
                              child: Text(
                                "No Hospital found",
                                style: TextStyleConst.mediumTextStyle(
                                  ColorConst.blackColor,
                                  width * 0.04,
                                ),
                              ),
                            ),
                        )
                        : Expanded(
                          child: RefreshIndicator(
                              onRefresh: () async {
                                hospitalController.isGotData.value = false;
                                hospitalController.changeIndex(hospitalController.currentIndex.value);
                              },
                              child: AnimationLimiter(
                                child: ListView.builder(
                                  itemCount: hospitalController.filterHospitalModel!.data!.length,
                                  physics: const AlwaysScrollableScrollPhysics(
                                      parent: BouncingScrollPhysics()),
                                  itemBuilder: (context, index) {
                                    return AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration: const Duration(milliseconds: 1000),
                                      child: SlideAnimation(
                                        verticalOffset: 50.0,
                                        child: FadeInAnimation(
                                          child: Column(
                                            children: [
                                              Slidable(
                                                startActionPane: ActionPane(
                                                  extentRatio: 0.25,
                                                  motion: const ScrollMotion(),
                                                  children: [
                                                    SlidableAction(
                                                      onPressed:
                                                          (contextAction) async {
                                                        final message = await Get.to(
                                                            () => EditHospitalScreen(
                                                                hospitalId: hospitalController.filterHospitalModel!.data![index].id ?? 0,
                                                            ),
                                                            transition: Transition.leftToRight,
                                                            arguments: {
                                                              "hospital_name":hospitalController.filterHospitalModel!.data![index].hospital_name,
                                                              "hospital_slug": hospitalController.filterHospitalModel!.data![index].hospital_slug,
                                                              "hospital_type_id": hospitalController.filterHospitalModel?.data?[index].hospital_type_id.toString(),
                                                              "email": hospitalController.filterHospitalModel!.data![index].email,
                                                              "city": hospitalController.filterHospitalModel!.data![index].city,
                                                              "region_code" : hospitalController.filterHospitalModel!.data![index].region_code,
                                                              "phone_no": hospitalController.filterHospitalModel!.data![index].phone_no
                                                            },
                                                        );
                                                        if (message == "Call API") {
                                                          hospitalController.changeIndex(hospitalController.currentIndex.value);
                                                        }
                                                      },
                                                      backgroundColor: ColorConst.orangeColor.withOpacity(0.15),
                                                      label: StringUtils.edit,
                                                      foregroundColor: ColorConst.orangeColor,
                                                    ),
                                                  ],
                                                ),
                                                endActionPane: ActionPane(
                                                  extentRatio: 0.25,
                                                  motion: const ScrollMotion(),
                                                  children: [
                                                    SlidableAction(
                                                      onPressed: (contextAction) {
                                                        hospitalController.showDeleteDialog(context, height, width, index);
                                                      },
                                                      backgroundColor: const Color(0xFFFCE5E5),
                                                      label: StringUtils.delete,
                                                      foregroundColor: ColorConst.redColor,
                                                    ),
                                                  ],
                                                ),
                                                child: ListTile(
                                                  onTap: () {
                                                    Get.to(
                                                      () => HospitalDetailScreen(
                                                        hospitalName: hospitalController.filterHospitalModel!.data![index].hospital_name!,
                                                        emaiAddress: hospitalController.filterHospitalModel!.data![index].email!,
                                                        hospitalSlug: hospitalController.filterHospitalModel!.data![index].hospital_slug!,
                                                        hospitalType: hospitalController.filterHospitalModel!.data![index].hospital_type!,
                                                        city: hospitalController.filterHospitalModel!.data![index].city!,
                                                        status: hospitalController.filterHospitalModel!.data![index].status.toString(),
                                                      ),
                                                      transition: Transition.rightToLeft,
                                                    );
                                                  },
                                                  contentPadding: EdgeInsets.only(
                                                      top: index == 0 ? 15 : 0,
                                                      right: 15,
                                                      left: 15),
                                                  leading: Container(
                                                    height: 60,
                                                    width: 60,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: ColorConst.borderGreyColor,
                                                    ),
                                                    child: ClipOval(
                                                      child: hospitalController.filterHospitalModel!.data![index].image_url == null ||
                                                              hospitalController.filterHospitalModel!.data![index].image_url!.isEmpty
                                                          ? Image.asset(
                                                              ImageUtils.hospitalNoIcon,
                                                              fit: BoxFit.cover,
                                                            )
                                                          : FadeInImage(
                                                              placeholder: const AssetImage(ImageUtils.hospitalNoIcon),
                                                              image: NetworkImage(hospitalController.filterHospitalModel!.data![index]
                                                                  .image_url!
                                                                  .replaceAll(" ", "")),
                                                              imageErrorBuilder: (context, error, stackTrace) {
                                                                return Image.asset(
                                                                  ImageUtils.hospitalNoIcon,
                                                                  fit: BoxFit.cover,
                                                                );
                                                              },
                                                              fit: BoxFit.cover,
                                                            ),
                                                    ),
                                                  ),
                                                  trailing: Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration: const BoxDecoration(
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: AssetImage("assets/superAdmin/hospitalscreen.png"),
                                                      ),
                                                    ),
                                                  ),
                                                  title: Text(
                                                    hospitalController.filterHospitalModel?.data?[index].hospital_name! ?? "",
                                                    style: TextStyleConst.mediumTextStyle(
                                                      ColorConst.blackColor,
                                                      width * 0.045,
                                                    ),
                                                  ),
                                                  subtitle: Text(
                                                    hospitalController.filterHospitalModel?.data?[index].hospital_type ?? "",
                                                    style: TextStyleConst.mediumTextStyle(
                                                      ColorConst.hintGreyColor,
                                                      width * 0.037,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              index == hospitalController.filterHospitalModel!.data!.length - 1
                                                  ? const SizedBox(
                                                      height: 70,
                                                    )
                                                  : const SizedBox()
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                        );
              }),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: GestureDetector(
              onTap: () async {
                final message = await Get.to(() => AddHospitalScreen(),
                    transition: Transition.rightToLeft);
                if (message == "Call API") {
                  hospitalController.getHospitals();
                }
              },
              child: Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorConst.blueColor,
                ),
                child: const Icon(Icons.add, color: ColorConst.whiteColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
