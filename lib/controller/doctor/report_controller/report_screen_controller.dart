import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/report_model/common_report_model/common_report_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/report_model/common_report_model/delete_common_report_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/report_model/investigation_report_model/investigation_report_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/pdf_utils.dart';

@pragma('vm:entry-point')
class ReportScreenController extends GetxController {
  CommonReportModel? commonReportModel;
  DeleteCommonReportModel? deleteCommonReportModel;
  InvestigationReportModel? investigationReportModel;
  RxBool isGotReport = false.obs;
  List<RxBool> isCurrentDownloading = <RxBool>[];
  RxInt progress = 0.obs;
  int? currentIndex;

  @override
  void onInit() {
    super.onInit();
  }

  void downloadDocument(context, int index) async {
    if (!isCurrentDownloading.any((e) => e.value)) {
      String url;
      url = investigationReportModel?.data?[index].attachment ?? "";
      currentIndex = index;
      isCurrentDownloading[index].value = true;

      try {
        await PDFUtils.downloadPDF(url);
      } finally {
        isCurrentDownloading[index].value = false;
      }
    }
  }

  void callReportApi(String report) {

    if (report == StringUtils.birthReport) {
      getBirthReport();

    } else if (report == StringUtils.deathReport) {
      getDeathReport();

    } else if (report == StringUtils.investigationReport) {
      getInvestigationReport();

    } else if (report == StringUtils.operationReport) {
      getOperationReport();
    }

  }
  void deleteReport(int id, String report) {
    Get.back();

    if (report == StringUtils.birthReport) {
      deleteBirthReport(id);

    } else if (report == StringUtils.deathReport) {
      deleteDeathReport(id);

    } else if (report == StringUtils.investigationReport) {
      deleteInvestigationReport(id);

    } else if (report == StringUtils.operationReport) {
      deleteOperationReport(id);
    }

  }

  void getBirthReport() {
    StringUtils.client.getBirthReport(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        commonReportModel = value;
        if (commonReportModel!.success == true) {
          isGotReport.value = true;
        }
      })
      ..onError((DioException error, stackTrace) {
        isGotReport.value = true;
        CheckSocketException.checkSocketException(error);
        return CommonReportModel();
      });
  }

  void getDeathReport() {
    StringUtils.client.getDeathReport(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        commonReportModel = value;
        if (commonReportModel!.success == true) {
          isGotReport.value = true;
        }
      })
      ..onError((DioException error, stackTrace) {
        isGotReport.value = true;
        CheckSocketException.checkSocketException(error);
        return CommonReportModel();
      });
  }

  void getInvestigationReport() {
    StringUtils.client
        .getInvestigationReport(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        investigationReportModel = value;
        if (investigationReportModel!.success == true) {
          isGotReport.value = true;
          isCurrentDownloading =
              List.generate(value.data?.length ?? 1, (index) {
            return false.obs;
          });
        }
      })
      ..onError((DioException error, stackTrace) {
        isGotReport.value = true;
        CheckSocketException.checkSocketException(error);
        return InvestigationReportModel();
      });
  }

  void getOperationReport() {
    StringUtils.client
        .getOperationReport(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        commonReportModel = value;
        if (commonReportModel!.success == true) {
          isGotReport.value = true;
        }
      })
      ..onError((DioException error, stackTrace) {
        isGotReport.value = true;
        CheckSocketException.checkSocketException(error);
        return CommonReportModel();
      });
  }

  void deleteBirthReport(int id) {
    isGotReport.value = false;
    StringUtils.client
        .deleteBirthReport(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        deleteCommonReportModel = value;
        if (deleteCommonReportModel!.success == true) {
          DisplaySnackBar.displaySnackBar(
              "Report has been deleted", 3, ColorConst.redColor);
          getBirthReport();
        }
      })
      ..onError((DioException error, stackTrace) {
        getBirthReport();
        CheckSocketException.checkSocketException(error);
        return DeleteCommonReportModel();
      });
  }

  void deleteDeathReport(int id) {
    isGotReport.value = false;
    StringUtils.client
        .deleteDeathReport(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        deleteCommonReportModel = value;
        if (deleteCommonReportModel!.success == true) {
          DisplaySnackBar.displaySnackBar(
              "Report has been deleted", 3, ColorConst.redColor);
          getDeathReport();
        }
      })
      ..onError((DioException error, stackTrace) {
        getDeathReport();
        CheckSocketException.checkSocketException(error);
        return DeleteCommonReportModel();
      });
  }

  void deleteOperationReport(int id) {
    isGotReport.value = false;
    StringUtils.client
        .deleteOperationReport(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        deleteCommonReportModel = value;
        if (deleteCommonReportModel!.success == true) {
          DisplaySnackBar.displaySnackBar(
              "Report has been deleted", 3, ColorConst.redColor);
          getOperationReport();
        }
      })
      ..onError((DioException error, stackTrace) {
        getOperationReport();
        CheckSocketException.checkSocketException(error);
        return DeleteCommonReportModel();
      });
  }

  void deleteInvestigationReport(int id) {
    isGotReport.value = false;
    StringUtils.client
        .deleteInvestigationReport(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        deleteCommonReportModel = value;
        if (deleteCommonReportModel!.success == true) {
          DisplaySnackBar.displaySnackBar(
              "Report has been deleted", 3, ColorConst.redColor);
          getInvestigationReport();
        }
      })
      ..onError((DioException error, stackTrace) {
        getInvestigationReport();
        CheckSocketException.checkSocketException(error);
        return DeleteCommonReportModel();
      });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
