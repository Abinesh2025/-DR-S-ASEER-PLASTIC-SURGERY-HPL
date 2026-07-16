import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/notice_board_model/notice_board.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class NoticeBoardController extends GetxController {
  NoticeBoardModel? noticeBoardModel;
  RxBool isGetNotice = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getNotice();
  }

  void getNotice() {
    StringUtils.client.getNoticeBoard(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        noticeBoardModel = value;
        isGetNotice.value = true;
      })
      ..onError((DioException error, stackTrace) {
        isGetNotice.value = true;
        CheckSocketException.checkSocketException(error);
        return NoticeBoardModel();
      });
  }
}
