import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/notice_board_controller/notice_board_controller.dart';

class NoticeBoardScreen extends StatelessWidget {
  NoticeBoardScreen({Key? key}) : super(key: key);
  final NoticeBoardController noticeBoardController = Get.put(NoticeBoardController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Obx(
      () => noticeBoardController.isGetNotice.value == false
          ?  Center(child: CircularProgressIndicator(color: ColorConst.primaryColor))
          : noticeBoardController.noticeBoardModel?.data?.isEmpty ?? true
              ? Container(
                  color: ColorConst.whiteColor,
                  child: Center(
                    child: Text(
                      "No notice found",
                      style: TextStyleConst.mediumTextStyle(
                        ColorConst.blackColor,
                        width * 0.04,
                      ),
                    ),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    noticeBoardController.isGetNotice.value = false;
                    noticeBoardController.getNotice();
                  },
                  child: AnimationLimiter(
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                      itemCount: noticeBoardController.noticeBoardModel?.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 1000),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: ListTile(
                                onTap: () {
                                  showModalBottomSheet(
                                    backgroundColor: ColorConst.whiteColor,
                                    shape: const OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(50),
                                        topRight: Radius.circular(50),
                                      ),
                                    ),
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        constraints: BoxConstraints(minHeight: height * 0.3),
                                        margin: const EdgeInsets.only(right: 25, top: 15, left: 25),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Center(
                                                child: Container(
                                                  height: 5,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                    color: const Color(0xffE7E9EB),
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: height * 0.04),
                                              Text(
                                                noticeBoardController.noticeBoardModel?.data?[index].title ?? "N/A",
                                                style: TextStyleConst.boldTextStyle(
                                                  ColorConst.blackColor,
                                                  width * 0.045,
                                                ),
                                              ),
                                              SizedBox(height: height * 0.01),
                                              Text(
                                                noticeBoardController.noticeBoardModel?.data?[index].description ?? "N/A",
                                                style: TextStyleConst.mediumTextStyle(
                                                  ColorConst.hintGreyColor,
                                                  width * 0.04,
                                                ),
                                              ),
                                              SizedBox(height: height * 0.015),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                contentPadding: const EdgeInsets.only(right: 15, left: 15),
                                title: Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Text(
                                    noticeBoardController.noticeBoardModel?.data?[index].title ?? "N/A",
                                    style: TextStyleConst.mediumTextStyle(
                                      ColorConst.blackColor,
                                      width * 0.045,
                                    ),
                                  ),
                                ),
                                subtitle: Text(
                                  "${noticeBoardController.noticeBoardModel?.data?[index].time ?? "N/A"} - ${noticeBoardController.noticeBoardModel?.data?[index].date ?? "N/A"}",
                                  style: TextStyleConst.mediumTextStyle(
                                    ColorConst.hintGreyColor,
                                    width * 0.037,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
    );
  }
}
