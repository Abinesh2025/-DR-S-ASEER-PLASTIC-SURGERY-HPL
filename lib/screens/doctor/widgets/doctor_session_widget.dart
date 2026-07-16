import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/doctor_session_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class DoctorSessionManagementBar extends StatelessWidget {
  final DoctorSessionController controller = Get.put(DoctorSessionController());

  DoctorSessionManagementBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final status = controller.currentStatus;
      final statusColor = controller.statusColor;
      final session = controller.sessionData.value;

      return Container(
        margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: statusColor.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${StringUtils.sessionLabel}: ${status.replaceAll('_', ' ').capitalizeFirst ?? ''}",
                    style: TextStyleConst.boldTextStyle(statusColor, 16),
                  ),
                  if (status == "paused" && session?.delayReason != null)
                    Text(
                      "${StringUtils.reasonLabel}: ${session!.delayReason} (${session.delayTime} min left)",
                      style: TextStyleConst.mediumTextStyle(
                          ColorConst.hintGreyColor, 12),
                    ),
                ],
              ),
            ),
            if (controller.isLoading.value)
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            else
              Row(
                children: [
                   if (status == "stopped" || status == "not_started" || status == "paused")
                    _buildActionButton(
                      icon: Icons.play_arrow_rounded,
                      label: status == "paused" ? StringUtils.resumeLabel : StringUtils.startLabel,
                      color: ColorConst.greenColor,
                      onTap: () => controller.startSession(),
                    ),
                  if (status == "started" || status == "active")
                    _buildActionButton(
                      icon: Icons.pause_rounded,
                      label: StringUtils.pauseLabel,
                      color: Colors.orange,
                      onTap: () => _showPauseDialog(context),
                    ),
                  if (status != "stopped" && status != "not_started")
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: _buildActionButton(
                        icon: Icons.stop_rounded,
                        label: StringUtils.stopLabel,
                        color: ColorConst.redColor,
                        onTap: () => controller.stopSession(),
                      ),
                    ),
                ],
              ),
          ],
        ),
      );
    });
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyleConst.boldTextStyle(color, 12),
            ),
          ],
        ),
      ),
    );
  }

  void _showPauseDialog(BuildContext context) {
    final TextEditingController reasonController = TextEditingController();
    final TextEditingController delayController = TextEditingController(text: "");

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StringUtils.pauseSessionTitle,
                  style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 20),
                ),
                const SizedBox(height: 8),
                Text(
                  StringUtils.specifyDelayReasonHint,
                  style: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, 14),
                ),
                const SizedBox(height: 20),
                Text(
                  StringUtils.delayTimeMinutesLabel,
                  style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 14),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: delayController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: StringUtils.delayTimeHint,
                    filled: true,
                    hintStyle: TextStyleConst.boldTextStyle(ColorConst.greyShadowColor1,12),
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  StringUtils.reasonLabel,
                  style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 14),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: reasonController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: StringUtils.reasonHint,
                    filled: true,
                    hintStyle: TextStyleConst.boldTextStyle(ColorConst.greyShadowColor1,12),
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Get.back(),
                        child: Text(
                          StringUtils.cancelLabel,
                          style: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, 16),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          final int? delay = int.tryParse(delayController.text);
                          if (delay == null || delay <= 0) {
                            Get.snackbar(StringUtils.invalidInputTitle, StringUtils.invalidDelayTimeError,
                                backgroundColor: ColorConst.redColor, colorText: Colors.white);
                            return;
                          }
                          if (reasonController.text.isEmpty) {
                            Get.snackbar(StringUtils.invalidInputTitle, StringUtils.enterReasonError,
                                backgroundColor: ColorConst.redColor, colorText: Colors.white);
                            return;
                          }
                          Get.back();
                          controller.pauseSession(delay, reasonController.text);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          elevation: 0,
                        ),
                        child: Text(
                          StringUtils.pauseNowLabel,
                          style: TextStyleConst.boldTextStyle(Colors.white, 16),
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
  }
}
