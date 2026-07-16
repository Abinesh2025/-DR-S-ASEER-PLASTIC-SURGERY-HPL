import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/banner/banner_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/notification/notification_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/admin_model/admin_appointment_model/admin_appointment_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/admin_model/admin_appointment_model/cancel/cancel_admin_appointment_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/admin_model/admin_appointment_model/confirm/confirm_admin_appointment_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/admin_model/admin_appointment_model/filter_model/filter_admin_appointment_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/admin_model/admin_dashboard_model/admin_dashboard_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/admin_model/patient_model/filter_patient_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/admin_model/patient_model/patient_detail_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/admin_model/patient_model/patient_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/admin_model/setting_screen_model/edit_setting_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/admin/admin_model/setting_screen_model/setting_screen_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/common/setting_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/bed_assign_model/bed_assign_delete_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/bed_assign_model/bed_assign_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/bed_assign_model/bed_details_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/bed_assign_model/bed_update_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/bed_assign_model/beds_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/bed_assign_model/create_new_bed_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/bed_assign_model/edit_bed_assign_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/bed_assign_model/ipd_patients_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/bed_assign_model/patient_cases_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/bed_status_model/bed_status_details_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/bed_status_model/bed_status_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_appointment_model/confirm_appointment_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_appointment_model/doctor_appointment_detail_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_appointment_model/doctor_appointment_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_session_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_diagnosis_test_model/delete_test_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_diagnosis_test_model/doctor_diagnosis_test_detail_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_diagnosis_test_model/doctor_diagnosis_test_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_document_model/doctor_documents_crud_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_document_model/doctor_documents_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_document_model/doctor_documents_type_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_document_model/doctor_patients_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_live_consultations_model/doctor_live_consultations_details_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_live_consultations_model/doctor_live_consultations_meeting_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_live_consultations_model/doctor_live_consultations_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_model/doctor_detail_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_model/doctor_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/disease_details_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_model/filter_doctors_models.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_list_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_payroll_model/payroll_details_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_payroll_model/payroll_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_prescription_model/doctor_prescription_detail_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_prescription_model/doctor_prescription_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_schedule_model/doctor_schedule_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_schedule_model/doctor_schedule_update_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/patient_admission_model/delete_admission_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/patient_admission_model/patient_admission_details_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/patient_admission_model/patient_admission_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/report_model/common_report_model/common_report_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/report_model/common_report_model/delete_common_report_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/report_model/doctor_case_details_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/report_model/investigation_report_model/investigation_report_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/account_model/edit_profile_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/account_model/get_profile_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/admission_model/admission_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/appointment_model/appointment_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/appointment_model/cancel_appointment/cancel_appointment_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/appointment_model/create_appointment/create_appointment_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/appointment_model/delete_appointment/delete_appointment_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/appointment_model/doctor/doctor_department_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/appointment_model/doctor/get_doctor_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/appointment_model/filter/filter_appointment_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/appointment_model/slot_booking/slot_booking_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/appointment_model/payment/create_payment_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/appointment_model/payment/verify_payment_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/auth_model/forgot_password_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/auth_model/login_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/auth_model/logout_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/auth_model/reset_password_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/auth_model/send_token_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/auth_model/sigup_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/bills_model/bill_detail_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/bills_model/bill_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/case_model/case_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/diagnosis_model/diagnosis_test_details_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/diagnosis_model/diagnosis_test_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/documents_model/document_delete_model/document_delete.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/documents_model/document_download_model/document_download.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/documents_model/document_store_model/document_store.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/documents_model/document_update_model/document_update.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/documents_model/documents_model/documents.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/documents_model/documents_type_model/documents_type.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/invoice_model/invoice_details_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/invoice_model/invoice_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/live_consultancy/live_consultation_details_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/live_consultancy/live_consultation_filter.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/live_consultancy/live_consultation_meeting_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/notice_board_model/notice_board.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/prescriptions_model/prescription_details_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/prescriptions_model/prescriptions_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/vaccinated_model/vaccinated_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/super_admin_model/dashboard/dashboard_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/super_admin_model/dashboard/income_chart_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/super_admin_model/hospital_model/add_hospital_model/add_hospital_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/super_admin_model/hospital_model/delete_hospital_model/delete_hospital_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/super_admin_model/hospital_model/edit_hospital_model/edit_hospital_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/super_admin_model/hospital_model/filter_hospital_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/follow_up_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/super_admin_model/hospital_model/hospital_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/super_admin_model/hospital_model/hospital_type_model/hospital_type_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/super_admin_model/hospital_registration/hospital_registration_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/super_admin_model/settings_model/settings_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/super_admin_model/settings_model/update_settings_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/super_admin_model/subscription_model/filter_subscription_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/super_admin_model/subscription_model/subscription_models.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/super_admin_model/subscription_model/update_subscription_model/update_subscription_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/super_admin_model/transaction_model/filter_transaction_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/super_admin_panel/super_admin_model/transaction_model/transaction_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/config_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/medicine/medicine_response_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/disease_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/medicine/medicine_category_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/medicine_category_detail_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_detail_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/emergency_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/payment_gateway_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/newsletters_model/newsletter_category_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/newsletters_model/newsletters_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/newsletters_model/newsletter_details_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/newsletters_model/newsletter_like_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/newsletters_model/newsletter_view_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/newsletters_model/newsletter_post_comment_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/newsletters_model/newsletter_comments_model.dart';


import '../model/doctor/dashboard/doctor_dashboard_model.dart';
import '../model/patient/order_model/order_create_model.dart';
import '../model/patient/order_model/order_response_model.dart';
import '../model/push_notification/regular_update_model.dart';

part 'api_request.g.dart';

// Use HTTPS
@RestApi(baseUrl: ConfigUtils.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("hospital-diseases")
  Future<DiseaseModel> getDiseases(
    @Header('Authorization') String? token,
  );

  @GET("payment-gateways")
  Future<PaymentGatewayModel> getPaymentGateways(
    @Header('Authorization') String? token,
  );

  @GET("disease-full-details/{id}")
  Future<DiseaseDetailsModel> getDiseaseDetails(
    @Header('Authorization') String? token,
    @Path("id") int id,
  );

  @POST(StringUtils.loginPatient)
  Future<LoginModel> loginPatient(
    @Body() Map<String, dynamic> data,
    @Header("X-HOSPITAL") String hospitalSku,
  );

  @POST(StringUtils.loginDoctor)
  Future<LoginModel> loginDoctor(
    @Body() Map<String, dynamic> data,
    @Header("X-HOSPITAL") String hospitalSku,
  );

  @GET("settings")
  Future<SettingModel> getThemeSettings(
    @Header("X-HOSPITAL") String hospitalSku,
  );
// Add this inside your abstract class ApiClient
  @GET("doctors/dashboard/statistics")
  Future<DoctorDashboardModel> getDoctorDashboardStatistics(
      @Header('Authorization') String? token,
      );
  @POST(StringUtils.broadcastTodayAppointment)
  Future<dynamic> broadcastTodayAppointment(
    @Header('Authorization') String? token,
    @Body() Map<String, dynamic> body,
  );

  @GET(StringUtils.myAppointment)
  Future<AppointmentModel> getMyAppointments(
    @Header('Authorization') String? token,
  );

 @GET('today-appointment')
  Future<dynamic> getTodayAppointment(
    @Header('Authorization') String? token,
   
  );

  @GET(StringUtils.notificationsApi)
  Future<NotificationModel> getNotifications(
    @Header('Authorization') String? token,



  );
 @POST("patient/doctor-reviews")
 Future<dynamic> postDoctorReview(
     @Header("Authorization") String token,
     @Body() Map<String, dynamic> body,
     );

  @POST(StringUtils.readAllNotifications)
  Future<dynamic> readAllNotifications(
    @Header('Authorization') String? token,
  );

  @DELETE("notifications/{id}")
  Future<dynamic> deleteNotification(
    @Header('Authorization') String? token,
    @Path("id") int id,
  );

  @DELETE("notifications")
  Future<dynamic> clearAllNotifications(
    @Header('Authorization') String? token,
  );

  @GET("medicine-categories/{id}")
  Future<MedicineCategoryDetailModel> getMedicineCategoryDetails(
    @Header('Authorization') String? token,
    @Path("id") int id,
  );

  @GET("medicines")
  Future<MedicineResponseModel> getMedicines(
    @Header('Authorization') String? token,
  );

  @GET("medicine-categories")
  Future<MedicineCategoryResponse> getMedicineCategories(
    @Header('Authorization') String? token,
  );

  @GET(StringUtils.appointments)
  Future<AppointmentModel> getAppointments(
    @Header('Authorization') String? token,
  );

  @POST("appointment-filter?status={filter}")
  Future<FilterAppointmentModel> getPastAppointments(
    @Header('Authorization') String? token,
    @Path("filter") String filter,
  );

  @GET("doctor-department")
  Future<DoctorDepartmentModel> getDoctorDepartment(
    @Header('Authorization') String? token,
  );

  @GET("newsletter-categories")
  Future<NewsletterCategoryModel> getNewsletterCategories(
    @Header('Authorization') String? token,
  );

  @GET("newsletters")
  Future<NewslettersModel> getNewsletters(
    @Header('Authorization') String? token,
    @Query("category_id") int? categoryId,
  );

  @GET("newsletters/{id}")
  Future<NewsletterDetailsModel> getNewsletterDetails(
    @Header('Authorization') String? token,
    @Path("id") int id,
  );

  @GET("newsletters/{slug}")
  Future<NewsletterDetailsModel> getNewsletterDetailsBySlug(
    @Header('Authorization') String? token,
    @Path("slug") String slug,
  );

  @POST("newsletters/{id}/like")
  Future<NewsletterLikeResponse> likeNewsletter(
    @Header('Authorization') String? token,
    @Path("id") int id,
  );

  @POST("newsletters/{id}/view")
  Future<NewsletterViewResponse> viewNewsletter(
    @Header('Authorization') String? token,
    @Path("id") int id,
  );

  @POST("newsletters/{id}/share")
  Future<dynamic> shareNewsletter(
    @Header('Authorization') String? token,
    @Path("id") int id,
  );

  @GET("newsletters/{id}/comments")
  Future<NewsletterCommentsModel> getNewsletterComments(
    @Header('Authorization') String? token,
    @Path("id") int id,
  );

  @POST("newsletters/{id}/comment")
  Future<NewsletterCommentResponse> postNewsletterComment(
    @Header('Authorization') String? token,
    @Path("id") int id,
    @Body() Map<String, dynamic> data,
  );

  @POST("doctor/{id}")
  Future<GetDoctorModel> getDoctor(
    @Header('Authorization') String? token,
    @Path("id") int id,
  );

  @GET("doctor/{id}")
  Future<DoctorDetailModel> getDoctorDetail(
    @Header('Authorization') String? token,
    @Path("id") int id,
  );

  @POST("slot-booking")
  Future<SlotBookingModel> getBookingSlotDate(
    @Header('Authorization') String? token,
    @Field("editSelectedDate") String editSelectedDate,
    @Field("doctor_id") String doctorId,
      @Field("appointment_type") dynamic appointmentType,



  );

  // @POST("appointment-create")
  // Future<CreateAppointmentModel> createAppointment(
  //   @Header('Authorization') String? token,
  //   @Field("department_id") String departmentId,
  //   @Field("doctor_id") String doctorId,
  //   @Field("opd_date") String selectedDate,
  //   @Field("time") String selectedTime,
  //   @Field("token_number") int? selectedToken,
  //   @Field("patient_id") String patientId,
  //   @Field("problem") String? description,
  // );
  @POST("appointment-create")
  Future<CreateAppointmentModel> createAppointment(
      @Header('Authorization') String? token,
      @Body() Map<String, dynamic> data, // Changed to @Body to support nested JSON
      );

  @POST("patient/razorpay/create-payment")
  Future<CreatePaymentModel> createRazorpayPayment(
    @Header('Authorization') String? token,
    @Field("appointment_id") int appointmentId,
    @Field("amount") int amount,
  );

  @POST("patient/razorpay/verify-payment")
  Future<VerifyPaymentModel> verifyRazorpayPayment(
    @Header('Authorization') String? token,
    @Field("order_id") String orderId,
    @Field("razorpay_payment_id") String razorpayPaymentId,
    @Field("razorpay_signature") String razorpaySignature,
  );

  @GET("documents")
  Future<DocumentsModel> getDocuments(
    @Header('Authorization') String? token,
  );

  @GET("document-type")
  Future<DocumentsTypeModel> getDocumentsType(
    @Header('Authorization') String? token,
  );

  @MultiPart()
  @POST("document-store")
  Future<DocumentStoreModel> storeDocument(
    @Header('Authorization') String? token,
    @Part(name: "title") String title,
    @Part(name: "document_type_id") String documentTypeId,
    @Part(name: "notes") String notes,
    @Part(name: "file") File file,
  );

  @MultiPart()
  @POST("document-update/{id}")
  Future<DocumentUpdateModel> updateDocument(
    @Header('Authorization') String? token,
    @Part(name: "title") String title,
    @Part(name: "document_type_id") String documentTypeId,
    @Part(name: "notes") String notes,
    @Part(name: "file") File? file,
    @Path("id") int documentId,
  );

  @GET("document-delete/{id}")
  Future<DocumentDeleteModel> deleteDocument(
    @Header('Authorization') String? token,
    @Path("id") int documentId,
  );

  @GET("document-download/{id}")
  Future<DocumentDownloadModel> downloadDocument(
    @Header('Authorization') String? token,
    @Path("id") int documentId,
  );

  @GET("notice-board")
  Future<NoticeBoardModel> getNoticeBoard(
    @Header('Authorization') String? token,
  );

  @GET("invoices")
  Future<InvoiceModel> getInvoices(
    @Header('Authorization') String? token,
  );

  @GET("invoice/{id}")
  Future<InvoiceDetailsModel> getInvoiceData(
    @Header('Authorization') String? token,
    @Path("id") int invoiceId,
  );

  @GET("live-consultation/{id}")
  Future<LiveConsultationDetailsModel> liveConsultationData(
    @Header('Authorization') String? token,
    @Path("id") int consultationId,
  );

  @GET("live-consultation-meeting/{id}")
  Future<LiveConsultationMeetingModel> liveConsultationMeetingData(
    @Header('Authorization') String? token,
    @Path("id") int consultationId,
  );

  @POST("live-consultation-filter?status={status}")
  Future<LiveConsultationFilter> liveConsultationFilter(
    @Header('Authorization') String? token,
    @Path("status") String status,
  );

  @POST("cancel-appointment")
  Future<CancelAppointmentModel> cancelAppointment(
    @Header('Authorization') String? token,
    @Field("id") int id,
  );

  @POST("delete-appointment")
  Future<DeleteAppointmentModel> deleteAppointment(
    @Header('Authorization') String? token,
    @Field("id") int id,
  );

  @GET("bills")
  Future<BillsModel> getBills(
    @Header('Authorization') String? token,
  );

  @GET("bills/{id}")
  Future<BillDetailModel> getBillsDetails(
    @Header('Authorization') String? token,
    @Path("id") int id,
  );

  @GET("diagnosis")
  Future<DiagnosisTestModel> getDiagnosisTest(
    @Header('Authorization') String? token,
  );

  @GET("diagnosis/{id}")
  Future<DiagnosisTestDetailsModel> getDiagnosisTestDetails(
    @Header('Authorization') String? token,
    @Path("id") int id,
  );

  @GET("patient-admissions")
  Future<AdmissionModel> getAdmission(
    @Header('Authorization') String? token,
  );

  @GET("patient-cases")
  Future<CaseModel> getCase(
    @Header('Authorization') String? token,
  );

  @GET("patient-prescription")
  Future<PrescriptionsModel> getPrescription(
    @Header('Authorization') String? token,
  );

  @GET("patient-prescription/{id}")
  Future<PrescriptionDetailsModel> getPrescriptionDetails(
    @Header('Authorization') String? token,
    @Path("id") int id,
  );

  @GET("vaccinated-patient")
  Future<VaccinatedModel> getVaccinated(
    @Header('Authorization') String? token,
  );

  @POST("update-profile")
  Future<EditProfileModel> editProfile(
    @Header('Authorization') String? token,
    @Body() FormData data,
  );

  @POST("order-create")
  Future<OrderCreateModel> orderCreate(
    @Header('Authorization') String? token,
    @Body() OrderCreateRequest request,
  );

  @GET("orders")
  Future<OrderResponseModel> getOrders(
    @Header('Authorization') String? token,
  );

  @POST("logout")
  Future<LogoutModel> logout(
    @Header('Authorization') String? token,
  );

  @POST("reset-password")
  Future<ResetPasswordModel> resetPassword(
    @Header('Authorization') String? token,
    @Body() Map<String, dynamic> data,
  );

  @POST("forgot-password")
  Future<ForgotPasswordModel> forgotPassword(
    @Body() Map<String, dynamic> data,
  );

  @POST("password")
  Future<SendTokenModel> sendToken(
    @Field("token") String token,
    @Field("password") String password,
    @Field("password_confirmation") String passwordConfirmation,
    @Field("email") String email,
  );

  @GET("get-profile")
  Future<GetProfileModel> getProfile(
    @Header('Authorization') String? token,
  );

  @GET("appointment-follow-ups")
  Future<FollowUpModel> getAppointmentFollowUps(
    @Header('Authorization') String? token,
  );

  @GET("appointment-follow-ups/{id}")
  Future<FollowUpDetailModel> getFollowUpDetail(
    @Header('Authorization') String? token,
    @Path("id") int id,
  );

  @POST("patient-register")
  Future<SignUpModel> patientRegistration(
    @Header("X-HOSPITAL") String hospitalSku,
    @Field("first_name") String firstName,
    @Field("last_name") String lastName,
    @Field("email") String email,
    @Field("phone") String phone,
    @Field("gender") String gender,
    @Field("password") String password,
    @Field("password_confirmation") String passwordConfirmation,
    @Field("fcm_token") String fcmToken,
  );
  @POST("auth/google/token")
  Future<LoginModel> loginWithGoogle(
      @Body() Map<String, dynamic> data,
      @Header("X-HOSPITAL") String hospitalSku,
      );
  @MultiPart()
  @POST("patient/emergency")
  Future<EmergencyResponseModel> triggerEmergency(
    @Header('Authorization') String? token,
    @Header("X-HOSPITAL") String hospitalSku,
    @Part(name: "latitude") String latitude,
    @Part(name: "longitude") String longitude,
    @Part(name: "status") String status,
    @Part(name: "voice_note") MultipartFile? voiceNote,
  );

  /// Doctor panel

  @GET("doctors/appointment-filter?status={status}")
  Future<DoctorAppointmentModel> getDoctorAppointments(
    @Header('Authorization') String? token,
    @Path("status") String status,
  );

  @POST("doctors/change-status")
  Future<DoctorAppointmentDetailModel> updateAppointmentStatus(
    @Header('Authorization') String? token,
    @Field("appointment_id") int id,
    @Field("status") String status,
  );

  @POST("doctors/confirm-appointment/{id}")
  Future<ConfirmAppointmentModel> confirmAppointment(
    @Header('Authorization') String? token,
    @Path("id") int id,
  );

  @GET("doctor-session")
  Future<DoctorSessionModel> getDoctorSession(
    @Header('Authorization') String? token,
  );

  @POST("doctor-session/start")
  Future<DoctorSessionModel> startDoctorSession(
    @Header('Authorization') String? token,
  );

  @POST("doctor-session/pause")
  Future<DoctorSessionModel> pauseDoctorSession(
    @Header('Authorization') String? token,
    @Body() Map<String, dynamic> data,
  );

  @POST("doctor-session/stop")
  Future<DoctorSessionModel> stopDoctorSession(
    @Header('Authorization') String? token,
  );

  @GET("doctors/doctors")
  Future<DoctorsModel> getDoctors(
    @Header('Authorization') String? token,
  );

  @POST("doctors/doctors/filter?status={status}")
  Future<FilterDoctorsModel> getFilterDoctors(
    @Header('Authorization') String? token,
    @Path("status") String status,
  );

  @GET("doctors/doctors/{id}")
  Future<DoctorsDetailModel> getDoctorsDetail(
    @Header('Authorization') String? token,
    @Path("id") int id,
  );

  @GET("doctors/prescriptions")
  Future<DoctorPrescriptionModel> getDoctorsPrescription(
    @Header('Authorization') String? token,
  );

  @GET("doctors/prescriptions/{id}")
  Future<DoctorPrescriptionDetailModel> getDoctorsPrescriptionDetail(
    @Header('Authorization') String? token,
    @Path("id") int id,
  );

  @DELETE("doctors/prescriptions/{id}")
  Future<DeleteCommonReportModel> deletePrescriptionReport(
    @Header('Authorization') String? token,
    @Path("id") int id,
  );
  @GET("doctors/dashboard/today-schedule")
  Future<DoctorTodayScheduleModel> getDoctorTodaySchedule(
      @Header('Authorization') String? token,
      );
  @GET("doctors/doctor-diagnosis")
  Future<DoctorDiagnosisTestModel> getDoctorsDiagnosisTest(
    @Header('Authorization') String? token,
  );
  @GET("doctors/dashboard/recent-patients")
  Future<DoctorRecentPatientsModel> getDoctorRecentPatients(
      @Header('Authorization') String? token,
      );
  @GET("doctors/doctor-diagnosis/{id}")
  Future<DoctorDiagnosisTestDetailsModel> getDoctorsDiagnosisTestDetails(
    @Header('Authorization') String? token,
    @Path("id") int id,
  );

  @DELETE("doctors/doctor-diagnosis/{id}")
  Future<DeleteTestModel> deleteTest(
    @Header('Authorization') String? token,
    @Path("id") int id,
  );

  @GET("doctors/doctor-payroll")
  Future<PayrollModel> getPayroll(
    @Header('Authorization') String? token,
  );

  @GET("doctors/doctor-payroll/{id}")
  Future<PayrollDetailsModel> getPayrollDetails(
    @Header('Authorization') String? token,
    @Path("id") int id,
  );

  @GET("doctors/live-consultation-show/{id}")
  Future<DoctorLiveConsultationsDetailsModel> liveDoctorConsultationData(
    @Header('Authorization') String? token,
    @Path("id") int consultationId,
  );

  @GET("doctors/live-consultation-meeting/{id}")
  Future<DoctorLiveConsultationsMeetingModel> liveDoctorConsultationMeetingData(
    @Header('Authorization') String? token,
    @Path("id") int consultationId,
  );

  @GET("doctors/live-consultation-filter?status={status}")
  Future<DoctorLiveConsultationsModel> liveDoctorConsultationFilter(
    @Header('Authorization') String? token,
    @Path("status") String status,
  );

  @GET("doctors/patient-admission")
  Future<PatientAdmissionModel> getPatientAdmission(
    @Header('Authorization') String? token,
  );

  @GET("doctors/patient-admission-show/{id}")
  Future<PatientAdmissionDetailsModel> getPatientAdmissionDetails(
    @Header('Authorization') String? token,
    @Path("id") int id,
  );

  @DELETE("doctors/patient-admission-delete/{id}")
  Future<DeleteAdmissionModel> deleteAdmission(
    @Header('Authorization') String? token,
    @Path("id") int id,
  );

  @GET("doctors/birth-report")
  Future<CommonReportModel> getBirthReport(
    @Header('Authorization') String? token,
  );

  @DELETE("doctors/birth-report/{id}")
  Future<DeleteCommonReportModel> deleteBirthReport(
    @Header('Authorization') String? token,
    @Path("id") int id,
  );

  @GET("doctors/death-report")
  Future<CommonReportModel> getDeathReport(
    @Header('Authorization') String? token,
  );

  @DELETE("doctors/death-report/{id}")
  Future<DeleteCommonReportModel> deleteDeathReport(
    @Header('Authorization') String? token,
    @Path("id") int id,
  );

  @GET("doctors/operation-report")
  Future<CommonReportModel> getOperationReport(
    @Header('Authorization') String? token,
  );

  @DELETE("doctors/operation-report/{id}")
  Future<DeleteCommonReportModel> deleteOperationReport(
    @Header('Authorization') String? token,
    @Path("id") int id,
  );

  @GET("doctors/investigation-report")
  Future<InvestigationReportModel> getInvestigationReport(
    @Header('Authorization') String? token,
  );

  @DELETE("doctors/investigation-report/{id}")
  Future<DeleteCommonReportModel> deleteInvestigationReport(
    @Header('Authorization') String? token,
    @Path("id") int id,
  );

  @GET("doctors/case-detail/{caseId}")
  Future<DoctorCaseDetailsModel> getDoctorCaseDetails(
    @Header('Authorization') String? token,
    @Path("caseId") String caseId,
  );

  @GET("doctors/bed-assign-filter?status={status}")
  Future<BedAssignFilterModel> getBedData(
    @Header('Authorization') String? token,
    @Path("status") String status,
  );

  @GET("doctors/bed-assign/{id}")
  Future<BedDetailsModel> getBedDataDetails(
    @Header('Authorization') String? token,
    @Path("id") String id,
  );

  @GET("doctors/bed-assign-edit/{bedAssignId}")
  Future<EditBedAssignModel> getBedEditAssignDetails(
    @Header('Authorization') String? token,
    @Path("bedAssignId") int id,
  );

  @GET("doctors/bed-status")
  Future<BedStatusModel> getBedStatus(
    @Header('Authorization') String? token,
  );

  @GET("doctors/bed-status-detail/{id}")
  Future<BedStatusDetailsModel> getBedStatusDetails(
    @Header('Authorization') String? token,
    @Path("id") String id,
  );

  @GET("doctors/beds")
  Future<BedsModel> getBeds(
    @Header('Authorization') String? token,
  );

  @POST("doctors/bed-assign-edit-bed")
  Future<BedsModel> getBedsForEdit(
    @Header('Authorization') String? token,
    @Field("bed_id") String bedId,
  );

  @GET("doctors/ipd-patient/{caseId}")
  Future<IPDPatientsModel> getIPDModel(
    @Header('Authorization') String? token,
    @Path("caseId") String caseId,
  );

  @GET("doctors/patient-cases")
  Future<PatientCases> getPatientCases(
    @Header('Authorization') String? token,
  );

  @POST("doctors/bed-assign-update/{id}")
  Future<BedUpdatedDetailsModel> updateBedAssign(
    @Header('Authorization') String? token,
    @Path("id") String id,
    @Field("case_id") String caseId,
    @Field("ipd_patient_department_id") String patientId,
    @Field("bed_id") String bedId,
    @Field("assign_date") String assignDate,
    @Field("discharge_date") String? dischargeDate,
  );

  @POST("doctors/bed-assign-delete/{id}")
  Future<BedAssignDelete> deleteBedAssign(
    @Header('Authorization') String? token,
    @Path("id") String id,
  );

  @POST("doctors/bed-assign-create")
  Future<CreateNewBedModel> createNewBedAssign(
    @Header('Authorization') String? token,
    @Field("case_id") String caseId,
    @Field("ipd_patient_department_id") String? patientId,
    @Field("bed_id") String? bedId,
    @Field("assign_date") String assignDate,
  );

  /// doctor documents

  @GET("doctors/doctor-documents")
  Future<DoctorDocumentsModel> doctorDocuments(
    @Header('Authorization') String? token,
  );

  @GET("doctors/doctor-document-type")
  Future<DoctorDocumentsTypeModel> doctorDocumentType(
    @Header('Authorization') String? token,
  );

  @GET("doctors/doctor-patients")
  Future<DoctorPatientsDocumentsModel> doctorPatientsDocument(
    @Header('Authorization') String? token,
      @Query("search") String? search,
  );

  /// doctor documents crud

  @MultiPart()
  @POST("doctors/doctor-document-store")
  Future<DoctorDocumentsCRUDModel> createNewDoctorDocument(
    @Header('Authorization') String? token,
    @Part(name: "title") String title,
    @Part(name: "document_type_id") String documentTypeId,
    @Part(name: "patient_id") String patientId,
    @Part(name: "file") File? attachment,
    @Part(name: "notes") String notes,
  );

  @MultiPart()
  @POST("doctors/doctor-document-update/{id}")
  Future<DoctorDocumentsCRUDModel> updateDoctorsDocuments(
    @Header('Authorization') String? token,
    @Path("id") String docId,
    @Part(name: "title") String title,
    @Part(name: "document_type_id") String documentTypeId,
    @Part(name: "patient_id") String patientId,
    @Part(name: "file") File? attachment,
    @Part(name: "notes") String notes,
  );

  @DELETE("doctors/doctor-document-delete/{id}")
  Future<DoctorDocumentsCRUDModel> deleteDoctorDocuments(
    @Header('Authorization') String? token,
    @Path("id") String docId,
  );

  @GET("doctor-schedule")
  Future<DoctorScheduleModel> schedule(
    @Header('Authorization') String? token,
  );

  @POST("doctor-schedule/update")
  Future<DoctorScheduleUpdateModel> scheduleUpdate(
    @Header('Authorization') String? token,
    @Body() Map<String, dynamic> data,
  );

  ///super admin panel

  @GET("dashboard")
  Future<DashBoardModel> getDashboardData(
    @Header('Authorization') String? token,
  );

  @GET("income-chart")
  Future<IncomeModel> getIncomeData(
    @Header('Authorization') String? token,
    @Field('start_date') String startDate,
    @Field('end_date') String endDate,
  );

  @GET("subscription")
  Future<SubscriptionModel> getSubscriptions(
    @Header('Authorization') String? token,
  );

  @POST("subscription-filter?status={status}")
  Future<FilterSubscriptionModel> getFilterSubscription(
    @Header('Authorization') String? token,
    @Path("status") String status,
  );

  @MultiPart()
  @POST("subscription-update/{id}")
  Future<UpdateSubscriptionModel> updateSubscriptions(
    @Header('Authorization') String? token,
    @Path("id") String subId,
    @Part(name: "ends_at") String expireDate,
    @Part(name: "sms_limit") String smsLimit,
  );

  @GET("transactions")
  Future<TransactionModel> getTransactions(
    @Header('Authorization') String? token,
  );

  @POST("transactions-filter?status={status}")
  Future<FilterTransactionModel> getFilterTransactions(
    @Header('Authorization') String? token,
    @Path("status") String status,
  );

  @GET("hospital-type")
  Future<HospitalTypeModel> getHospitalType(
    @Header('Authorization') String? token,
  );

  @GET("hospitals")
  Future<HospitalModel> getHospitals(
    @Header('Authorization') String? token,
  );

  @POST("hospitals-filter?status={status}")
  Future<FilterHospitalModel> getFilterHospitals(
    @Header('Authorization') String? token,
    @Path("status") String status,
  );

  @POST("hospitals-register")
  Future<HospitalSignupModel> hospitalRegistration(
    @Field("hospital_name") String hospitalName,
    @Field("username") String userName,
    @Field("email") String email,
    @Field("region_code") String prefixCode,
    @Field("phone") String phone,
    @Field("password") String password,
    @Field("password_confirmation") String passwordConfirmation,
  );

  @POST("hospitals-store")
  Future<AddHospitalModel> createNewHospital(
    @Header('Authorization') String? token,
    @Field("hospital_name") String hospitalName,
    @Field("username") String? userName,
    @Field("hospital_type_id") String hospitalTypeId,
    @Field("email") String email,
    @Field("city") String city,
    @Field("region_code") String? prefixCode,
    @Field("phone") String? phoneNumber,
    @Field("password") String? password,
    @Field("password_confirmation") String? passwordConfirmation,
  );

  @MultiPart()
  @POST("hospitals-update/{id}")
  Future<UpdateHospitalModel> updateHospitals(
    @Header('Authorization') String? token,
    @Path("id") int hospitalId,
    @Part(name: "hospital_name") String hospitalName,
    @Part(name: "hospital_type_id") dynamic hospitalTypeId,
    @Part(name: "email") String email,
    @Part(name: "city") String city,
    @Part(name: "phone") String phone,
    @Part(name: "region_code") String? prefixCode,
  );

  @DELETE("hospitals-delete/{id}")
  Future<DeleteHospitalModel> deleteHospital(
    @Header('Authorization') String? token,
    @Path("id") String hospitalID,
  );

  @GET("general-settings")
  Future<SettingsModel> getSettings(
    @Header('Authorization') String? token,
  );

  @MultiPart()
  @POST("general-settings")
  Future<UpdateSettingsModel> updateSettings(
    @Header('Authorization') String? token,
    @Part(name: "app_name") String? appName,
    @Part(name: "plan_expire_notification") String? planExpireNotification,
    @Part(name: "default_country_code") String? defaultCountryCode,
    @Part(name: "phone") String? phone,
    @Part(name: "super_admin_currency") String? currentCurrency,
    @Part(name: "default_language") String? defaultLanguage,
    @Part(name: "app_logo") File? appLogo,
    @Part(name: "favicon") File? favicon,
  );

  ///admin panel

  @GET("admin-dashboard")
  Future<AdminDashboardModel> getAdminDashboardData(
    @Header('Authorization') String? token,
  );

  @GET("admin-appointments")
  Future<AdminAppointmentModel> getAdminAppointments(
    @Header('Authorization') String? token,
  );

  @GET("admin-appointments/filter?status={status}")
  Future<FilterAdminAppointmentModel> getAllAppointments(
    @Header('Authorization') String? token,
    @Path("status") String status,
  );

  @POST("admin-appointments/confirm/{id}")
  Future<ConfirmAdminAppointmentModel> confirmAdminAppointment(
    @Header('Authorization') String? token,
    @Path("id") int id,
  );

  @POST("admin-appointments/cancel")
  Future<CancelAdminAppointmentModel> cancelAdminAppointment(
    @Header('Authorization') String? token,
    @Field("id") int id,
  );

  @GET("patients-list")
  Future<PatientModel> getPatients(
    @Header('Authorization') String? token,
  );

  @POST("patients/filter?status={status}")
  Future<FilterPatientModel> getFilterPatients(
    @Header('Authorization') String? token,
    @Path("status") String status,
  );

  @GET("patient-details/{id}")
  Future<PatientsDetailModel> getPatientDetail(
    @Header('Authorization') String? token,
    @Path("id") int id,
  );

  @GET("edit-settings")
  Future<AdminSettingModel> getAdminSettings(
    @Header('Authorization') String? token,
  );

  @MultiPart()
  @POST("update-settings")
  Future<EditSettingModel> updateAdminSettings(
    @Header('Authorization') String? token,
    @Part(name: "app_name") String? appName,
    @Part(name: "company_name") String? companyName,
    @Part(name: "hospital_email") String? hospitalEmail,
    @Part(name: "prefix_code") String? prefixCode,
    @Part(name: "hospital_phone") String? hospitalPhone,
    @Part(name: "enable_google_recaptcha") String? enableGoogleRecaptcha,
    @Part(name: "app_logo") File? appLogo,
    @Part(name: "favicon") File? favicon,
  );

  @GET("banners")
  Future<BannerModel> getBanners(
    @Header('Authorization') String? token,
  );

  @GET("doctor-search")
  Future<DoctorListModel> searchDoctors(
    @Header('Authorization') String? token,
    @Header("X-HOSPITAL") String hospitalSku,
    @Query("gender") String? gender,
    @Query("min_price") String? minPrice,
    @Query("max_price") String? maxPrice,
    @Query("specialist") String? specialist,
    @Query("sort") String? sort,
    @Query("search") String? search,
  );
  //push notification
// --- Regular Updates APIs ---

  @GET("regular-updates")
  Future<RegularUpdateResponseModel> getRegularUpdates(
      @Header('Authorization') String? token,
      @Query("per_page") int? perPage,
      @Query("page") int? page,
      @Query("search") String? search,
      );

  @MultiPart()
  @POST("regular-updates")
  Future<dynamic> createRegularUpdate(
      @Header('Authorization') String? token,
      @Part(name: "title") String title,
      @Part(name: "description") String description,
      @Part(name: "image") MultipartFile image,
      );

  @DELETE("regular-updates/{id}")
  Future<dynamic> deleteRegularUpdate(
      @Header('Authorization') String? token,
      @Path("id") int id,
      );

  @POST("regular-updates/{id}/resend-notification")
  Future<dynamic> resendUpdateNotification(
      @Header('Authorization') String? token,
      @Path("id") int id,
      );
}
