import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/schedule_controller/schedule_controller.dart';

class SchedulesScreen extends StatelessWidget {
  SchedulesScreen({Key? key}) : super(key: key);
  final SchedulesController schedulesController = Get.put(SchedulesController());
  // Theme colors linked to global ColorConst
  static  Color _primaryBlue = ColorConst.primaryColor;
  static const Color _lightBlue = ColorConst.blueColor;
  static final Color _softBlue = ColorConst.primaryColor.withOpacity(0.12);
  static final Color _accentBlue = ColorConst.primaryColor.withOpacity(0.85);
  static  Color _darkBlue = ColorConst.primaryColor;
  static const Color _cardBg = ColorConst.whiteColor;
  static const Color _surfaceBg = ColorConst.bgGreyColor;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: _surfaceBg,
      bottomNavigationBar: Obx(() {
        if (!schedulesController.gotData.value ||
            schedulesController.doctorScheduleModel?.data?.schedule?.isEmpty == true) {
          return const SizedBox.shrink();
        }
        return _buildFixedBottomBar(width);
      }),
      body: Obx(() {
        return schedulesController.gotData.value == false
            ?  Center(
                child: CircularProgressIndicator(
                  color: _primaryBlue,
                  strokeWidth: 3,
                ),
              )
            : (schedulesController.doctorScheduleModel?.data?.schedule?.isEmpty ?? true)
                ? _buildEmptyState(width)
                : RefreshIndicator(
                    color: _primaryBlue,
                    onRefresh: () async {
                      schedulesController.gotData.value = false;
                      schedulesController.getSchedules();
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // _buildHeaderCard(width),
                          const SizedBox(height: 20),
                          _buildScheduleTypeToggle(width),
                          const SizedBox(height: 20),
                          Obx(() => schedulesController.isTokenBased.value
                              ? _buildGlobalTokenSettings(width)
                              : _buildTimeSection(width, context)),
                          const SizedBox(height: 16),
                          _buildDayScheduleList(width, context),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  );
      }),
    );
  }

  Widget _buildEmptyState(double width) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_busy_rounded, size: 64, color: _accentBlue.withOpacity(0.5)),
          const SizedBox(height: 16),
          Text(
            "No schedules found",
            style: TextStyleConst.boldTextStyle(Colors.grey.shade600, width * 0.045),
          ),
          const SizedBox(height: 8),
          Text(
            "Pull down to refresh",
            style: TextStyleConst.boldTextStyle(Colors.grey.shade400, width * 0.035),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCard(double width) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ColorConst.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child:  Icon(Icons.calendar_month_rounded, color: ColorConst.primaryColor, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "My Schedule",
                  style: TextStyleConst.boldTextStyle(ColorConst.blackColor, width * 0.05),
                ),
                const SizedBox(height: 4),
                Text(
                  "Configure your availability",
                  style: TextStyleConst.boldTextStyle(
                    Colors.grey.shade500,
                    width * 0.033,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleTypeToggle(double width) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Schedule Type",
            style: TextStyleConst.boldTextStyle(Colors.grey.shade800, width * 0.04),
          ),
          const SizedBox(height: 12),
          Obx(() => Row(
                children: [
                  Expanded(
                    child: _buildToggleOption(
                      icon: Icons.access_time_rounded,
                      label: "Time Based",
                      isSelected: !schedulesController.isTokenBased.value,
                      onTap: () => schedulesController.isTokenBased.value = false,
                      width: width,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildToggleOption(
                      icon: Icons.confirmation_number_rounded,
                      label: "Token Based",
                      isSelected: schedulesController.isTokenBased.value,
                      onTap: () => schedulesController.isTokenBased.value = true,
                      width: width,
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Widget _buildToggleOption({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required double width,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? _softBlue : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? _primaryBlue : Colors.grey.shade200,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? _primaryBlue : Colors.grey.shade500,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                style: TextStyleConst.boldTextStyle(
                  isSelected ? _primaryBlue : Colors.grey.shade500,
                  width * 0.034,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSection(double width, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _softBlue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child:  Icon(Icons.timer_outlined, color: _primaryBlue, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                "Per Patient Time",
                style: TextStyleConst.boldTextStyle(Colors.grey.shade800, width * 0.04),
              ),
              Text(
                " *",
                style: TextStyleConst.boldTextStyle(Colors.red, width * 0.04),
              ),
            ],
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              schedulesController.showTimePickerDialog(
                  context, null, schedulesController.perPatientTimeController.text);
            },
            child: AbsorbPointer(
              child: TextFormField(
                controller: schedulesController.perPatientTimeController,
                style: TextStyleConst.boldTextStyle(Colors.grey.shade700, width * 0.038),
                decoration: InputDecoration(
                  hintText: "00:15:00",
                  hintStyle: TextStyleConst.boldTextStyle(Colors.grey.shade400, width * 0.038),
                  filled: true,
                  fillColor: _cardBg,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:  BorderSide(color: _primaryBlue, width: 1.5),
                  ),
                  suffixIcon: Icon(Icons.schedule, color: _accentBlue, size: 22),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTokenSection(double width) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _softBlue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child:  Icon(Icons.confirmation_number_rounded, color: _primaryBlue, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                "Max Tokens Per Day",
                style: TextStyleConst.boldTextStyle(Colors.grey.shade800, width * 0.04),
              ),
              Text(
                " *",
                style: TextStyleConst.boldTextStyle(Colors.red, width * 0.04),
              ),
            ],
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              schedulesController.showMaxTokenPickerDialog(Get.context!);
            },
            child: AbsorbPointer(
              child: TextFormField(
                controller: schedulesController.maxTokensController,
                style: TextStyleConst.boldTextStyle(Colors.grey.shade700, width * 0.038),
                decoration: InputDecoration(
                  hintText: "Select Max Tokens",
                  hintStyle: TextStyleConst.boldTextStyle(Colors.grey.shade400, width * 0.038),
                  filled: true,
                  fillColor: _cardBg,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:  BorderSide(color: _primaryBlue, width: 1.5),
                  ),
                  suffixIcon: Icon(Icons.touch_app_rounded, color: _accentBlue, size: 22),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "This token count will be applied to all working days.",
            style: TextStyleConst.boldTextStyle(Colors.grey.shade400, width * 0.03),
          ),
        ],
      ),
    );
  }



  Widget _buildDayScheduleList(double width, BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: schedulesController.doctorScheduleModel?.data?.schedule?.length ?? 0,
        itemBuilder: (context, index) {
          final dayName = schedulesController.doctorScheduleModel?.data?.schedule?[index].available_on ?? "";
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 600),
            child: SlideAnimation(
              verticalOffset: 30.0,
              child: FadeInAnimation(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Day name badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [_primaryBlue.withOpacity(0.1), _lightBlue.withOpacity(0.08)],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: _primaryBlue.withOpacity(0.15)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.calendar_today_rounded, size: 14, color: _primaryBlue),
                            const SizedBox(width: 6),
                            Text(
                              dayName,
                              style: TextStyleConst.boldTextStyle(_primaryBlue, width * 0.035),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Time fields row
                      Row(
                        children: [
                          // Available From
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "From",
                                  style: TextStyleConst.boldTextStyle(
                                    Colors.grey.shade500,
                                    width * 0.03,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                GestureDetector(
                                  onTap: () {
                                    schedulesController.showTimePickerDialog(
                                      context,
                                      index * 2,
                                      schedulesController.controllerList[index * 2].text,
                                    );
                                  },
                                  child: AbsorbPointer(
                                    child: TextFormField(
                                      controller: schedulesController.controllerList[index * 2],
                                      style: TextStyleConst.boldTextStyle(
                                        Colors.grey.shade700,
                                        width * 0.035,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "00:00:00",
                                        hintStyle: TextStyleConst.boldTextStyle(
                                          Colors.grey.shade400,
                                          width * 0.035,
                                        ),
                                        filled: true,
                                        fillColor: _cardBg,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(color: Colors.grey.shade200),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(color: Colors.grey.shade200),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide:  BorderSide(
                                            color: _primaryBlue,
                                            width: 1.5,
                                          ),
                                        ),
                                        suffixIcon: Icon(
                                          Icons.schedule,
                                          color: _accentBlue,
                                          size: 18,
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                            child: Icon(Icons.arrow_forward_rounded, color: _accentBlue, size: 20),
                          ),
                          // Available To
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "To",
                                  style: TextStyleConst.boldTextStyle(
                                    Colors.grey.shade500,
                                    width * 0.03,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                GestureDetector(
                                  onTap: () {
                                    schedulesController.showTimePickerDialog(
                                      context,
                                      (index * 2) + 1,
                                      schedulesController.controllerList[(index * 2) + 1].text,
                                    );
                                  },
                                  child: AbsorbPointer(
                                    child: TextFormField(
                                      controller: schedulesController.controllerList[(index * 2) + 1],
                                      style: TextStyleConst.boldTextStyle(
                                        Colors.grey.shade700,
                                        width * 0.035,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "00:00:00",
                                        hintStyle: TextStyleConst.boldTextStyle(
                                          Colors.grey.shade400,
                                          width * 0.035,
                                        ),
                                        filled: true,
                                        fillColor: _cardBg,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(color: Colors.grey.shade200),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(color: Colors.grey.shade200),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide:  BorderSide(
                                            color: _primaryBlue,
                                            width: 1.5,
                                          ),
                                        ),
                                        suffixIcon: Icon(
                                          Icons.schedule,
                                          color: _accentBlue,
                                          size: 18,
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Obx(() => schedulesController.isTokenBased.value
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 12),
                                const Divider(),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "MAX TOKENS (OPD / FOLLOWUPS )",
                                          style: TextStyleConst.boldTextStyle(
                                            Colors.grey.shade400,
                                            width * 0.025,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "OPD: ",
                                                style: TextStyleConst.boldTextStyle(
                                                  Colors.grey.shade600,
                                                  width * 0.032,
                                                ),
                                              ),
                                              TextSpan(
                                                text: "${schedulesController.opdTokensControllers[index].text} ",
                                                style: TextStyleConst.boldTextStyle(
                                                  _primaryBlue,
                                                  width * 0.032,
                                                ),
                                              ),
                                              TextSpan(
                                                text: "/ FOLLOWUPS: ",
                                                style: TextStyleConst.boldTextStyle(
                                                  Colors.grey.shade600,
                                                  width * 0.032,
                                                ),
                                              ),
                                              TextSpan(
                                                text: schedulesController.popTokensControllers[index].text,
                                                style: TextStyleConst.boldTextStyle(
                                                  _primaryBlue,
                                                  width * 0.032,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        await _showEditTokensDialog(context, index, width);
                                        schedulesController.gotData.refresh();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.orange.shade400,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: const Icon(
                                          Icons.edit_note_rounded,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : const SizedBox.shrink()),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _showEditTokensDialog(BuildContext context, int index, double width) async {
    final dayName = schedulesController.doctorScheduleModel?.data?.schedule?[index].available_on ?? "";
    
    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            void updateTotals() {
              int mOpd = int.tryParse(schedulesController.morningTokensControllers[index].text) ?? 0;
              int aOpd = int.tryParse(schedulesController.afternoonTokensControllers[index].text) ?? 0;
              int nOpd = int.tryParse(schedulesController.nightTokensControllers[index].text) ?? 0;
              schedulesController.opdTokensControllers[index].text = (mOpd + aOpd + nOpd).toString();

              int mPop = int.tryParse(schedulesController.morningPopTokensControllers[index].text) ?? 0;
              int aPop = int.tryParse(schedulesController.afternoonPopTokensControllers[index].text) ?? 0;
              int nPop = int.tryParse(schedulesController.nightPopTokensControllers[index].text) ?? 0;
              schedulesController.popTokensControllers[index].text = (mPop + aPop + nPop).toString();
              
              schedulesController.maxTokensControllers[index].text = (mOpd + aOpd + nOpd + mPop + aPop + nPop).toString();
              setDialogState(() {});
            }

            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Edit Tokens - $dayName",
                          style: TextStyleConst.boldTextStyle(Colors.grey.shade800, width * 0.045),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close, color: Colors.grey),
                        ),
                      ],
                    ),
                    const Divider(),
                    Flexible(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // OPD Column
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "OPD (Normal)",
                                        style: TextStyleConst.boldTextStyle(Colors.grey.shade700, width * 0.038),
                                      ),
                                      const SizedBox(height: 16),
                                      _buildTokenInputField(
                                        label: "Morning:",
                                        controller: schedulesController.morningTokensControllers.length > index ? schedulesController.morningTokensControllers[index] : TextEditingController(),
                                        width: width,
                                        onChanged: updateTotals,
                                      ),
                                      const SizedBox(height: 12),
                                      _buildTokenInputField(
                                        label: "Afternoon:",
                                        controller: schedulesController.afternoonTokensControllers.length > index ? schedulesController.afternoonTokensControllers[index] : TextEditingController(),
                                        width: width,
                                        onChanged: updateTotals,
                                      ),
                                      const SizedBox(height: 12),
                                      _buildTokenInputField(
                                        label: "Night:",
                                        controller: schedulesController.nightTokensControllers.length > index ? schedulesController.nightTokensControllers[index] : TextEditingController(),
                                        width: width,
                                        onChanged: updateTotals,
                                      ),
                                      // const SizedBox(height: 16),
                                      // _buildTokenInputField(
                                      //   label: "Total OPD:",
                                      //   controller: schedulesController.opdTokensControllers.length > index ? schedulesController.opdTokensControllers[index] : TextEditingController(),
                                      //   width: width,
                                      //   readOnly: true,
                                      // ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Container(
                                  height: 240,
                                  width: 1,
                                  color: Colors.grey.shade200,
                                ),
                                const SizedBox(width: 16),
                                // POP Column
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "FOLLOWUPS",
                                        style: TextStyleConst.boldTextStyle(Colors.grey.shade700, width * 0.038),
                                      ),
                                      const SizedBox(height: 16),
                                      _buildTokenInputField(
                                        label: "Morning:",
                                        controller: schedulesController.morningPopTokensControllers.length > index ? schedulesController.morningPopTokensControllers[index] : TextEditingController(),
                                        width: width,
                                        onChanged: updateTotals,
                                      ),
                                      const SizedBox(height: 12),
                                      _buildTokenInputField(
                                        label: "Afternoon:",
                                        controller: schedulesController.afternoonPopTokensControllers.length > index ? schedulesController.afternoonPopTokensControllers[index] : TextEditingController(),
                                        width: width,
                                        onChanged: updateTotals,
                                      ),
                                      const SizedBox(height: 12),
                                      _buildTokenInputField(
                                        label: "Night:",
                                        controller: schedulesController.nightPopTokensControllers.length > index ? schedulesController.nightPopTokensControllers[index] : TextEditingController(),
                                        width: width,
                                        onChanged: updateTotals,
                                      ),
                                      // const SizedBox(height: 16),
                                      // _buildTokenInputField(
                                      //   label: "Total POP:",
                                      //   controller: schedulesController.popTokensControllers.length > index ? schedulesController.popTokensControllers[index] : TextEditingController(),
                                      //   width: width,
                                      //   readOnly: true,
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              updateTotals();
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [_primaryBlue, _lightBlue],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: _primaryBlue.withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  "Ok",
                                  style: TextStyleConst.boldTextStyle(Colors.white, width * 0.04),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTokenInputField({
    required String label,
    required TextEditingController controller,
    required double width,
    bool readOnly = false,
    VoidCallback? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyleConst.boldTextStyle(Colors.grey.shade600, width * 0.032),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 40,
          child: TextFormField(
            controller: controller,
            readOnly: readOnly,
            onChanged: (val) {
              if (onChanged != null) onChanged();
            },
            keyboardType: TextInputType.number,
            style: TextStyleConst.boldTextStyle(readOnly ? Colors.blue.shade700 : Colors.grey.shade700, width * 0.035),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              filled: true,
              fillColor: readOnly ? Colors.grey.shade50 : Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: readOnly ? Colors.blue.shade200 : Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: readOnly ? Colors.blue.shade200 : _primaryBlue, width: 1),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFixedBottomBar(double width) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24, top: 12),
      decoration: BoxDecoration(
        color: _surfaceBg,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Cancel button

            // Save button
            Expanded(

              child: GestureDetector(
                onTap: () => schedulesController.updateSchedules(),
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                    gradient:  LinearGradient(
                      colors: [_primaryBlue, _lightBlue],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: _primaryBlue.withOpacity(0.35),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                    child: Center(
                      child: Obx(() => schedulesController.isLoading.value
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // const Icon(Icons.check_circle_rounded, color: Colors.white, size: 22),
                                // const SizedBox(width: 8),
                                Text(
                                  "Save Schedule",
                                  style: TextStyleConst.boldTextStyle(Colors.white, width * 0.042),
                                ),
                              ],
                            )),
                    ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlobalTokenSettings(double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Per Patient Time",
                    style: TextStyleConst.boldTextStyle(Colors.grey.shade700, width * 0.035),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => schedulesController.showPerPatientTimePickerDialog(Get.context!),
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade100,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() {
                            // ignore: unused_local_variable
                            var trigger = schedulesController.gotData.value;
                            return Text(
                              schedulesController.perPatientTimeController.text.isEmpty ? "00:05:00" : schedulesController.perPatientTimeController.text,
                              style: TextStyleConst.mediumTextStyle(Colors.grey.shade800, width * 0.038),
                            );
                          }),
                          Icon(Icons.access_time_rounded, color: _primaryBlue, size: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Token Block Option",
                    style: TextStyleConst.boldTextStyle(Colors.grey.shade700, width * 0.035),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade100,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Obx(() => DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            value: schedulesController.tokenBlockOption.value,
                            isExpanded: true,
                            icon: Icon(Icons.keyboard_arrow_down_rounded, color: _primaryBlue),
                            dropdownColor: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            items: [
                              DropdownMenuItem(value: 0, child: Text("None", style: TextStyleConst.mediumTextStyle(Colors.grey.shade800, width * 0.035))),
                              DropdownMenuItem(value: 1, child: Text("1:2", style: TextStyleConst.mediumTextStyle(Colors.grey.shade800, width * 0.035))),
                              DropdownMenuItem(value: 2, child: Text("1:3", style: TextStyleConst.mediumTextStyle(Colors.grey.shade800, width * 0.035))),
                              DropdownMenuItem(value: 3, child: Text("1:5", style: TextStyleConst.mediumTextStyle(Colors.grey.shade800, width * 0.035))),
                              DropdownMenuItem(value: 4, child: Text("1:7", style: TextStyleConst.mediumTextStyle(Colors.grey.shade800, width * 0.035))),
                            ],
                            onChanged: (val) {
                              if (val != null) schedulesController.tokenBlockOption.value = val;
                            },
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
