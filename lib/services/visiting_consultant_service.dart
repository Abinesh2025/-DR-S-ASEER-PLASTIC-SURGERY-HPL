import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/visiting_consultant/visiting_bill_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/visiting_consultant/visiting_consultant_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/visiting_consultant/visiting_request_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/visiting_consultant/visiting_summary_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/config_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class VisitingConsultantService {
  static final VisitingConsultantService _instance = VisitingConsultantService._internal();
  factory VisitingConsultantService() => _instance;
  VisitingConsultantService._internal();

  String get _token {
    final token = PreferenceUtils.getStringValue("token");
    if (token.startsWith("Bearer ")) {
      return token;
    }
    return "Bearer $token";
  }

  Options get _options => Options(
        headers: {
          'Authorization': _token,
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'X-HOSPITAL': ConfigUtils.hospitalSku,
        },
      );

  /// 1. GET /api/visiting-consultants
  /// List all active visiting consultants with department and specialty
  Future<VisitingConsultantListModel> getVisitingConsultants() async {
    try {
      final response = await StringUtils.dio.get(
        "${ConfigUtils.baseUrl}visiting-consultants",
        options: _options,
      );
      if (response.data is Map<String, dynamic>) {
        return VisitingConsultantListModel.fromJson(response.data);
      }
      return VisitingConsultantListModel(
        success: false,
        message: "Unexpected response format",
      );
    } catch (e) {
      debugPrint("Error in getVisitingConsultants: $e");
      if (e is DioException) {
        CheckSocketException.checkSocketException(e);
      }
      return VisitingConsultantListModel(
        success: false,
        message: e.toString(),
      );
    }
  }

  /// 2. GET /api/visiting-consultants/{id}
  /// Get full profile of a specific visiting consultant
  Future<VisitingConsultantDetailModel> getVisitingConsultantDetail(int id) async {
    try {
      final response = await StringUtils.dio.get(
        "${ConfigUtils.baseUrl}visiting-consultants/$id",
        options: _options,
      );
      if (response.data is Map<String, dynamic>) {
        return VisitingConsultantDetailModel.fromJson(response.data);
      }
      return VisitingConsultantDetailModel(
        success: false,
        message: "Unexpected response format",
      );
    } catch (e) {
      debugPrint("Error in getVisitingConsultantDetail: $e");
      if (e is DioException) {
        CheckSocketException.checkSocketException(e);
      }
      return VisitingConsultantDetailModel(
        success: false,
        message: e.toString(),
      );
    }
  }

  /// 3. GET /api/visiting-consultant-requests
  /// List authenticated patient's visit requests (supports ?status=Requested filter)
  Future<VisitingRequestListModel> getVisitingRequests({String? status}) async {
    try {
      final Map<String, dynamic> query = {};
      if (status != null && status.isNotEmpty && status.toLowerCase() != 'all') {
        query['status'] = status;
      }

      final response = await StringUtils.dio.get(
        "${ConfigUtils.baseUrl}visiting-consultant-requests",
        queryParameters: query.isNotEmpty ? query : null,
        options: _options,
      );
      if (response.data is Map<String, dynamic>) {
        return VisitingRequestListModel.fromJson(response.data);
      }
      return VisitingRequestListModel(
        success: false,
        message: "Unexpected response format",
      );
    } catch (e) {
      debugPrint("Error in getVisitingRequests: $e");
      if (e is DioException) {
        CheckSocketException.checkSocketException(e);
      }
      return VisitingRequestListModel(
        success: false,
        message: e.toString(),
      );
    }
  }

  /// 4. POST /api/visiting-consultant-requests
  /// Patient creates a new request to visit a consultant
  Future<VisitingRequestDetailModel> createVisitingRequest(
    CreateVisitingRequestPayload payload,
  ) async {
    try {
      final response = await StringUtils.dio.post(
        "${ConfigUtils.baseUrl}visiting-consultant-requests",
        data: payload.toJson(),
        options: _options,
      );
      if (response.data is Map<String, dynamic>) {
        return VisitingRequestDetailModel.fromJson(response.data);
      }
      return VisitingRequestDetailModel(
        success: false,
        message: "Request submitted successfully",
      );
    } catch (e) {
      debugPrint("Error in createVisitingRequest: $e");
      if (e is DioException) {
        CheckSocketException.checkSocketException(e);
        final errData = e.response?.data;
        if (errData is Map && errData['message'] != null) {
          return VisitingRequestDetailModel(
            success: false,
            message: errData['message'].toString(),
          );
        }
      }
      return VisitingRequestDetailModel(
        success: false,
        message: e.toString(),
      );
    }
  }

  /// 5. GET /api/visiting-consultant-requests/{id}
  /// Get details of a single request including consultant & bill
  Future<VisitingRequestDetailModel> getVisitingRequestDetail(int id) async {
    try {
      final response = await StringUtils.dio.get(
        "${ConfigUtils.baseUrl}visiting-consultant-requests/$id",
        options: _options,
      );
      if (response.data is Map<String, dynamic>) {
        return VisitingRequestDetailModel.fromJson(response.data);
      }
      return VisitingRequestDetailModel(
        success: false,
        message: "Unexpected response format",
      );
    } catch (e) {
      debugPrint("Error in getVisitingRequestDetail: $e");
      if (e is DioException) {
        CheckSocketException.checkSocketException(e);
      }
      return VisitingRequestDetailModel(
        success: false,
        message: e.toString(),
      );
    }
  }

  /// 6. POST /api/visiting-consultant-requests/{id}/cancel
  /// Patient cancels a request (allowed if Requested or Assigned)
  Future<bool> cancelVisitingRequest(int id, String reason) async {
    try {
      final response = await StringUtils.dio.post(
        "${ConfigUtils.baseUrl}visiting-consultant-requests/$id/cancel",
        data: {"reason": reason},
        options: _options,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      return response.data?['success'] == true;
    } catch (e) {
      debugPrint("Error in cancelVisitingRequest: $e");
      if (e is DioException) {
        CheckSocketException.checkSocketException(e);
      }
      return false;
    }
  }

  /// 7. GET /api/visiting-consultant-requests/{id}/bill
  /// View bill/voucher for the request
  Future<VisitingConsultantBillModel> getVisitingRequestBill(int id) async {
    try {
      final response = await StringUtils.dio.get(
        "${ConfigUtils.baseUrl}visiting-consultant-requests/$id/bill",
        options: _options,
      );
      if (response.data is Map<String, dynamic>) {
        return VisitingConsultantBillModel.fromJson(response.data);
      }
      return VisitingConsultantBillModel(
        success: false,
        message: "Unexpected response format",
      );
    } catch (e) {
      debugPrint("Error in getVisitingRequestBill: $e");
      if (e is DioException) {
        CheckSocketException.checkSocketException(e);
      }
      return VisitingConsultantBillModel(
        success: false,
        message: e.toString(),
      );
    }
  }

  /// 8. POST /api/visiting-consultant-requests/{id}/pay
  /// Record payment mode (Cash, UPI / Online, Card, etc.)
  Future<bool> payVisitingRequest(int id, RecordPaymentPayload payload) async {
    try {
      final response = await StringUtils.dio.post(
        "${ConfigUtils.baseUrl}visiting-consultant-requests/$id/pay",
        data: payload.toJson(),
        options: _options,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      return response.data?['success'] == true;
    } catch (e) {
      debugPrint("Error in payVisitingRequest: $e");
      if (e is DioException) {
        CheckSocketException.checkSocketException(e);
      }
      return false;
    }
  }

  /// 9. GET /api/visiting-consultant-requests/{id}/summary
  /// Consultation summary notes & clinical findings (when Completed)
  Future<VisitingConsultantSummaryModel> getVisitingRequestSummary(int id) async {
    try {
      final response = await StringUtils.dio.get(
        "${ConfigUtils.baseUrl}visiting-consultant-requests/$id/summary",
        options: _options,
      );
      if (response.data is Map<String, dynamic>) {
        return VisitingConsultantSummaryModel.fromJson(response.data);
      }
      return VisitingConsultantSummaryModel(
        success: false,
        message: "Unexpected response format",
      );
    } catch (e) {
      debugPrint("Error in getVisitingRequestSummary: $e");
      if (e is DioException) {
        CheckSocketException.checkSocketException(e);
      }
      return VisitingConsultantSummaryModel(
        success: false,
        message: e.toString(),
      );
    }
  }
}
