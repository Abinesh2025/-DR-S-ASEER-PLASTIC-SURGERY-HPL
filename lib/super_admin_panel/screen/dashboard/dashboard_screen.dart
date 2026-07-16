import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_container.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/controller/dashboard_controller/dashboard_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/super_admin_model/dashboard/income_chart_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../constant/color_const.dart';
import '../../../constant/text_style_const.dart';

class DashboardScreen extends StatelessWidget {
   DashboardScreen({Key? key}) : super(key: key);

  final DashboardController dashboardController = Get.put(DashboardController());


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      color: ColorConst.whiteColor,
      child: Obx(() {
        return dashboardController.isGetDetails.value == false && dashboardController.incomeData.isEmpty
            ?  Center(
            child: CircularProgressIndicator(color: ColorConst.primaryColor))
            : RefreshIndicator(
          onRefresh: () async {
            dashboardController.isGetDetails.value = false;
            dashboardController.getDashboardData();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics()
            ),
            child: SizedBox(
              height: height,
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Column(
                  children: [
                    SizedBox(height: height * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        ///total hospital
                        Expanded(
                          child: CommonContainer(
                           // width: width / 2.4,
                            height: height / 6,
                            icon: false,
                            text: dashboardController.dashBoardModel?.data?.users.toString() ?? "",
                            image: ImageUtils.hospitalNoIcon,
                            description: StringUtils.totalHospital,
                          ),
                        ),
                        SizedBox(width: height * 0.02),

                        /// total revenue
                        Expanded(
                          child: CommonContainer(
                            //width: width / 2.4,
                            height: height / 6,
                            icon: true,
                            text: dashboardController.dashBoardModel != null &&
                                dashboardController.dashBoardModel!.data != null &&
                                dashboardController.dashBoardModel!.data!.revenue != null
                                ? dashboardController.formatRevenue(
                                dashboardController.dashBoardModel!.data!.revenue!)
                                : '',
                            symbol: dashboardController.dashBoardModel?.data?.currency?.currency_icon ?? "",
                            //image: ImageUtils.revenueIcon,
                            description: StringUtils.totalRevenue,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        /// active plan
                        Expanded(
                          child: CommonContainer(
                            //width: width / 2.4,
                            height: height / 5.5,
                            icon: false,
                            text: dashboardController.dashBoardModel?.data?.activeHospitalPlan.toString() ?? "",
                            image: ImageUtils.activeHospitalPlanIcon,
                            description: StringUtils.activePlan,
                          ),
                        ),
                        SizedBox(width: height * 0.02),

                        ///expire plan
                        Expanded(
                          child: CommonContainer(
                            //width: width / 2.4,
                            height: height / 5.5,
                            icon: false,
                            text: dashboardController.dashBoardModel?.data?.deActiveHospitalPlan.toString() ?? "",
                            image: ImageUtils.expiredHospitalPlanIcon,
                            description: StringUtils.expiredPlan,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.03,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          StringUtils.incomeOverview,
                          style: TextStyleConst.boldTextStyle(
                            ColorConst.blackColor,
                            width * 0.047,
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            dashboardController.showDatePicker(context);
                          },
                          child: SizedBox(
                            height: height * 0.03,
                            width: height * 0.03,
                            child: Image.asset(
                              ImageUtils.incomeOverview,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: height * 0.03,),
                    SizedBox(
                      height: height / 3,
                      width: double.infinity,
                      child: SfCartesianChart(
                        isTransposed: true,
                        series: <BarSeries<IncomeData, String>>[
                          BarSeries<IncomeData, String>(
                            dataSource: dashboardController.incomeData,
                            xValueMapper: (IncomeData data, _) => data.days,
                            yValueMapper: (IncomeData data, _) => data.income,
                            borderRadius: const BorderRadius.only(topRight: Radius.circular(3), topLeft: Radius.circular(3)),
                          ),
                        ],
                        plotAreaBorderColor: Colors.transparent,
                        borderColor: Colors.transparent,
                        enableAxisAnimation: true,
                        primaryYAxis: NumericAxis(
                          labelFormat: '${dashboardController.dashBoardModel?.data?.currency?.currency_icon ?? ""}{value}',
                          placeLabelsNearAxisLine: false,
                          majorTickLines: const MajorTickLines(width: 0),
                          majorGridLines: const MajorGridLines(width: 0),
                          labelStyle: TextStyleConst.mediumTextStyle(
                            ColorConst.blackColor,
                            width * 0.032,
                          ),
                        ),
                        primaryXAxis: CategoryAxis(
                          majorGridLines: const MajorGridLines(width: 0),
                          placeLabelsNearAxisLine: false,
                          majorTickLines: const MajorTickLines(width: 0),
                          labelStyle: TextStyleConst.mediumTextStyle(
                            ColorConst.blackColor,
                            width * 0.032,
                          ),
                          labelRotation: 310,
                          labelPlacement: LabelPlacement.onTicks,
                        ),
                        tooltipBehavior: TooltipBehavior(
                            enable: true,
                            header: "",
                          format: 'point.x\nincome: point.y',
                        ),
                        palette:  <Color>[
                          ColorConst.primaryColor,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
        ),
    );
  }
}

