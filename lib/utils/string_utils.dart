import 'package:dio/dio.dart';

import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/api_request/api_request.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/config_utils.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../l10n/app_localizations.dart';
import 'dart:io';

import 'package:dio/io.dart';
class StringUtils {
  /// Patient Panel

  /// api calling
  static final dio = Dio(
    BaseOptions(
      contentType: "application/json",
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        "Accept": "application/json",
      },
    ),
  )
    ..httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();

        // Accept all SSL certificates (Development only)
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;

        return client;
      },
    )
    ..interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    );

  static final client = ApiClient(dio);
  // static final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));
  static const domainUrl = ConfigUtils.domainUrl;
  static const imagePath = ConfigUtils.imagePath;
  static const loginPatient = "patient-login";
  static const loginDoctor = "login";
  static const appointments = "appointments";
  static const broadcastTodayAppointment = "broadcast-today-appointment";
  static const myAppointment = "my-appointment";
  static const notificationsApi = "notifications";
  static const readAllNotifications = "notifications/read-all";
  static const doctorSession = "doctor-session";
  static const doctorSessionStart = "doctor-session/start";
  static const doctorSessionPause = "doctor-session/pause";
  static const doctorSessionStop = "doctor-session/stop";
  static const visitingConsultants = "visiting-consultants";
  static const visitingConsultantRequests = "visiting-consultant-requests";
  static const visitingConsultantsTitle = "Visiting Specialists";


  static String fixImageUrl(String? url) {
    if (url == null || url.isEmpty) return "";
    if (url.startsWith('http')) {
      try {
        Uri originalUri = Uri.parse(url);
        // Only rewrite URLs from the old local .test domain
        // Preserve external URLs (e.g. S3, CDN) as-is
        if (originalUri.host.endsWith('.test')) {
          Uri domainUri = Uri.parse(domainUrl);
          return originalUri
              .replace(
                scheme: domainUri.scheme,
                host: domainUri.host,
                port: domainUri.port,
              )
              .toString();
        }
        return url;
      } catch (e) {
        return url;
      }
    }
    return url;
  }
  //
  // /// auth
  // static const signIn = "Sign In";
  // static const patientRegistration = "Registration";
  // static const resetPassword = "Reset Password";
  // static const signInEmail = "Enter your email or phone number";
  // static const enterNewPassword = "Enter New Password";
  // static const enterConfirmPassword = "Enter Confirm Password";
  // static const signInPassword = "Enter Password";
  // static const forgotPassword = "Forgot Password?";
  // static const doctorHospitalLogin = "Doctor / Hospital Login";
  // static const rememberPassword = "Remember Me";
  // static const login = "Login";
  // static const forgotScreenDetail = "Enter your email to reset your password";
  // static const sendLink = "Send Link";
  // static const cancel = "Cancel";
  // static String? token;
  static String sendEmail = "";
  //
  // static const yes = "Yes";
  // static const no = "No";
  //
  // static const edit = "Edit";
  // static const bookAppointment = "Book Appointment";
  // static const editDocument = "Edit Document";
  // static const newDocument = "New Document";
  // static const delete = "Delete";
  // static const introOneTitle = "Book an Appointment";
  // static const introOneSubTitle =
  //     "Book appointments with ease, putting your health in your hands";
  // static const introTwoTitle = "Schedule Live Consultation";
  // static const introTwoSubTitle =
  //     "Seamlessly schedule live consultations, connecting you with healthcare professionals on your terms";
  // static const introThreeTitle = "Read Prescriptions";
  // static const introThreeSubTitle =
  //     "Navigate your treatment with clarity – easily read and follow your doctor's prescribed plan";
  // static const appointment = "Appointments";
  // static const home = "Home";
  // static const bills = "Bills";
  // static const billsDetails = "Bill Details";
  // static const diagnosisTests = "Diagnosis Tests";
  // static const diagnosisTestsDetails = "Diagnosis Test Details";
  // static const documents = "Documents";
  // static const noticeBoards = "Notice Boards";
  // static const invoices = "Invoices";
  // static const liveConsultations = "Live Consultations";
  // static const patientsCases = "Cases";
  // static const casesDetails = "Case Details";
  // static const myCases = "My Cases";
  // static const myOrders = "My Orders";
  // static const patientAdmissions = "Admissions";
  // static const myAdmissions = "My Admissions";
  // static const prescriptions = "Prescriptions";
  // static const vaccinatedPatients = "Vaccination";
  // static const logOut = "Logout";
  // static const myAccount = "My Account";
  // static const editProfile = "Edit Profile";
  // static const changePassword = "Change Password";
  // static const firstName = "First Name:";
  // static const lastName = "Last Name:";
  // static const email = "Email:";
  // static const phone = "Phone:";
  // static const address = "Address:";
  // static const cityLabel = "City:";
  // static const pincode = "Pincode:";
  // static const save = "Save";
  //
  // static const currentPassword = "Current Password:";
  // static const newPassword = "New Password:";
  // static const confirmPassword = "Confirm Password:";
  // static const newAppointment = "New Appointment";
  // static const doctorDepartment = "Doctor Department:";
  // static const doctor = "Doctor:";
  //
  // static const slotAvailable = "Available Slot:";
  // static const description = "Description:";
  //
  // /// Admission
  // static const admissionDetails = "Admission Details";
  // static const insuranceDetails = "Insurance Details";
  // static const admissionId = "Admission ID:";
  // static const admissionDate = "Admission Date:";
  // static const dischargeDate = "Discharge Date:";
  // static const bed = "Bed:";
  // static const guardianName = "Guardian Name:";
  // static const guardianRelation = "Guardian Relation:";
  // static const guardianContact = "Guardian Contact:";
  // static const guardianAddress = "Guardian Address:";
  // static const createOn = "Created On:";
  // static const packageName = "Package Name:";
  // static const insuranceName = "Insurance Name:";
  // static const agentName = "Agent Name:";
  // static const policyNo = "Policy No:";
  //
  // /// bill
  // static const patientCellNO = "Patient Cell No:";
  // static const totalDays = "Total Days:";
  // static const itemDetails = "Item Details";
  // static const totalAmount = "Total Amount";
  // static const downloadBill = "Download Bill";
  // static const fee = "Fee:";
  //
  // /// Consultancy
  // static const liveConsultationsDetails = "Live Consultations Details";
  // static const consultationTitle = "Consultation Title:";
  // static const consultationDate = "Consultation Date:";
  // static const durationMinute = "Duration Minutes:";
  // static const doctorName = "Doctor Name:";
  // static const type = "Type:";
  // static const typeNumber = "Type Number:";
  //
  // /// diagnosis
  // static const diagnosisCategory = "Diagnosis Category:";
  // static const reportNumber = "Report number:";
  // static const averageGlucose = "Average Glucose:";
  // static const fastingBloodSugar = "Fasting Blood Sugar:";
  // static const urineSugar = "Urine Sugar:";
  // static const bloodPressure = "Blood Pressure:";
  // static const diabetes = "Diabetes:";
  // static const cholesterol = "Cholesterol:";
  // static const downloadDiagnosisTest = "Download Diagnosis Test PDF";
  //
  // ///document
  // static const title = "Title:";
  // static const documentType = "Document Type:";
  // static const attachment = "Attachment:";
  // static const note = "Notes:";
  //
  // /// invoice
  // static const issueFor = "Issue For:";
  // static const issueBy = "Issue By:";
  // static const subTotal = "Sub Total:";
  // static const discount = "Discount:";
  // static const downloadInvoice = "Download Invoice:";
  // static const downInvoice = "Download Invoice";
  //
  // /// prescription
  // static const foodAllergies = "Food Allergies:";
  // static const tendencyBleed = "Tendency Bleed:";
  // static const heartDisease = "Heart Disease";
  // static const highBloodPressure = "High Blood Pressure:";
  // static const surgery = "Surgery:";
  // static const accident = "Accident:";
  // static const others = "Others:";
  // static const medicalHistory = "Medical History:";
  // static const currentMedication = "Current Medication:";
  // static const femalePregnancy = "Female Pregnancy:";
  // static const breastFeeding = "Breast Feeding:";
  // static const healthInsurance = "Health Insurance:";
  // static const lowIncome = "Low Income:";
  // static const reference = "Reference";
  //
  // /// hint text
  // static const selectDepartment = "Select Department";
  // static const selectDoctor = "Select Doctor";
  // static const selectDate = "Select Date";
  // static const typeHere = "Type here..";
  // static const date = "Date:";
  //
  // /// Doctor Panel
  //
  // static const bedAssign = "Bed Assigns";
  // static const bedStatus = "Bed Status";
  // static const doctorDrawer = "Doctor";
  // static const schedules = "Schedules";
  // static const myPayRoll = "My Payrolls";
  // static const reports = "Reports";
  // static const icu = "ICU";
  // static const confirm = "Confirm";
  // static const patientAdmissionInDoctor = "Patient Admissions";
  // static const patientDetails = "Patient Details";
  // static const prescriptionDetails = "Prescription Details";
  // static const overview = "Overview";
  // static const rx = "Rx:";
  // static const downloadPrescription = "Download Prescription";
  // static const patient = "Patient";
  // static const height = "Height:";
  // static const age = "Age:";
  // static const weight = "Weight:";
  //
  // /// payRoll
  // static const srNo = "Sr No:";
  // static const myPayrolls = "My Payrolls";
  // static const payrollsDetails = "Payroll Details";
  // static const salaryDetails = "Salary Details";
  // static const basicSalary = "Basic Salary:";
  // static const allowance = "Allowance:";
  // static const deductions = "Deductions:";
  // static const netSalary = "Net Salary:";
  //
  // ///
  // static const patientName = "Patient Name:";
  //
  // /// report
  //
  // static const report = "Report";
  // static const birthReport = "Birth Reports";
  // static const deathReport = "Death Reports";
  // static const investigationReport = "Investigation Reports";
  // static const operationReport = "Operation Reports";
  //
  // static const newCase = "Case:";
  // static const ipdPatient = "IPD Patient:";
  // static const bedInEditBed = "Bed:";
  // static const assignDate = "Assign Date:";
  // static const disChargeDate = "Discharge Date:";
  //
  // ///Super Admin Panel
  //
  // static const hospitalRegistration = "Hospital Registration";
  // static const dashboard = "Dashboard";
  // static const hospitals = "Hospitals";
  // static const transaction = "Transactions";
  // static const subscription = "Subscriptions";
  // static const setting = "Settings";
  //
  // static const totalHospital = "Total Hospital";
  // static const totalRevenue = "Total Revenue";
  // static const activePlan = "Total Active Hospital Plans";
  // static const expiredPlan = "Total Expired Hospital Plans";
  // static const incomeOverview = "Income Overview";
  //
  // ///hospital
  // static const addHospital = "Add Hospital";
  // static const editHospital = "Edit Hospital";
  // static const hospitalDetail = "Hospital Details";
  // static const hospitalName = "Hospital Name:";
  // static const hospitalSlug = "Hospital Slug:";
  // static const hospitalType = "Hospital Type:";
  // static const city = "City:";
  // static const password = "Password:";
  // static const emailAddress = "Email Address:";
  // static const status = "Status:";
  //
  // ///transaction
  // static const transactionDetail = "Transactions Details";
  // static const payments = "Payments:";
  // static const amount = "Amount:";
  // static const transactionDate = "Transaction Date:";
  // static const paymentApproved = "Payment Approved:";
  //
  // ///subscription
  // static const subscriptionDetail = "Subscriptions Details";
  // static const editSubscription = "Edit Subscriptions";
  // static const planName = "Plan Name:";
  // static const startDate = "Start Date:";
  // static const expiresOn = "Expires on:";
  // static const frequency = "Frequency:";
  // static const smsLimit = "SMS Limit:";
  //
  // ///settings
  // static const appName = "App Name:";
  // static const planExpireNotification = "Plan Expire Notification (in Days):";
  // static const defaultCountryCode = "Default Country Code:";
  // static const currentCurrency = "Current Currency:";
  // static const language = "Language:";
  // static const appLogo = "App Logo:";
  // static const favicon = "Favicon:";
  //
  // ///Admin Panel
  // static const patients = "Patients";
  // static const patientsDetails = "Patients Details";
  // static const doctorList = "Doctors";
  // static const doctorDetails = "Doctors Details";
  // static const bedManagement = "Bed Management";
  //
  // ///dashboard
  // static const invoiceAmount = "Invoice Amount";
  // static const billAmount = "Bill Amount";
  // static const paymentAmount = "Payment Amount";
  // static const advPayment = "Adv. Payment Amount";
  // static const doctors = "Doctors";
  // static const availablePatients = "Patients";
  // static const nurses = "Nurses";
  // static const availableBeds = "Available Beds";
  // static const upcomingAppointments = "Upcoming Appointments";
  //
  // static const companyName = "Company Name:";
  // static const hospitalEmail = "Hospital Email:";
  // static const enableGoogleCaptcha = "Enable google captcha";
  // static const hospitalPhone = "Hospital Phone:";
  static String get login => AppLocalizations.of(Get.context!)!.login;
  static String get signIn => AppLocalizations.of(Get.context!)!.signIn;
  static String get patientRegistration => AppLocalizations.of(Get.context!)!.patientRegistration;
  static String get resetPassword => AppLocalizations.of(Get.context!)!.resetPassword;
  static String get signInEmail => AppLocalizations.of(Get.context!)!.signInEmail;
  static String get enterNewPassword => AppLocalizations.of(Get.context!)!.enterNewPassword;
  static String get enterConfirmPassword => AppLocalizations.of(Get.context!)!.enterConfirmPassword;
  static String get signInPassword => AppLocalizations.of(Get.context!)!.signInPassword;
  static String get forgotPassword => AppLocalizations.of(Get.context!)!.forgotPassword;
  static String get doctorHospitalLogin => AppLocalizations.of(Get.context!)!.doctorHospitalLogin;
  static String get rememberPassword => AppLocalizations.of(Get.context!)!.rememberPassword;
  static String get forgotScreenDetail => AppLocalizations.of(Get.context!)!.forgotScreenDetail;
  static String get sendLink => AppLocalizations.of(Get.context!)!.sendLink;
  static String get cancel => AppLocalizations.of(Get.context!)!.cancel;
  static String? token;

  static String get welcomeBack => AppLocalizations.of(Get.context!)!.welcomeBack;
  static String get enterYourEmail => AppLocalizations.of(Get.context!)!.enterYourEmail;
  static String get enterYourPassword => AppLocalizations.of(Get.context!)!.enterYourPassword;
  static String get orSignInWith => AppLocalizations.of(Get.context!)!.orSignInWith;
  static String get continueWithGoogle => AppLocalizations.of(Get.context!)!.continueWithGoogle;
  static String get dontHaveAccount => AppLocalizations.of(Get.context!)!.dontHaveAccount;
  static String get createAccount => AppLocalizations.of(Get.context!)!.createAccount;
  static String get next => AppLocalizations.of(Get.context!)!.next;
  static String get start => AppLocalizations.of(Get.context!)!.start;
  static String get changeLanguage => AppLocalizations.of(Get.context!)!.changeLanguage;
  static String get notification => AppLocalizations.of(Get.context!)!.notification;
  static String get logoutTitle => AppLocalizations.of(Get.context!)!.logoutTitle;
  static String get logoutConfirmation => AppLocalizations.of(Get.context!)!.logoutConfirmation;
  static String get logoutShortConfirmation => AppLocalizations.of(Get.context!)!.logoutShortConfirmation;


  static String get yes => AppLocalizations.of(Get.context!)!.yes;
  static String get no => AppLocalizations.of(Get.context!)!.no;

  static String get edit => AppLocalizations.of(Get.context!)!.edit;
  static String get bookAppointment => AppLocalizations.of(Get.context!)!.bookAppointment;
  static String get editDocument => AppLocalizations.of(Get.context!)!.editDocument;
  static String get newDocument => AppLocalizations.of(Get.context!)!.newDocument;
  static String get delete => AppLocalizations.of(Get.context!)!.delete;
  static String get introOneTitle => AppLocalizations.of(Get.context!)!.introOneTitle;
  static String get introOneSubTitle => AppLocalizations.of(Get.context!)!.introOneSubTitle;
  static String get introTwoTitle => AppLocalizations.of(Get.context!)!.introTwoTitle;
  static String get introTwoSubTitle => AppLocalizations.of(Get.context!)!.introTwoSubTitle;
  static String get introThreeTitle => AppLocalizations.of(Get.context!)!.introThreeTitle;
  static String get introThreeSubTitle => AppLocalizations.of(Get.context!)!.introThreeSubTitle;
  static String get appointment => AppLocalizations.of(Get.context!)!.appointment;
  static String get home => AppLocalizations.of(Get.context!)!.home;
  static String get bills => AppLocalizations.of(Get.context!)!.bills;
  static String get billsDetails => AppLocalizations.of(Get.context!)!.billsDetails;
  static String get diagnosisTests => AppLocalizations.of(Get.context!)!.diagnosisTests;
  static String get diagnosisTestsDetails => AppLocalizations.of(Get.context!)!.diagnosisTestsDetails;
  static String get documents => AppLocalizations.of(Get.context!)!.documents;
  static String get noticeBoards => AppLocalizations.of(Get.context!)!.noticeBoards;
  static String get invoices => AppLocalizations.of(Get.context!)!.invoices;
  static const String services = "Services";
  static const String gallery = "Gallery";
  static const String contactUs = "Contact Us";
  static String get liveConsultations => AppLocalizations.of(Get.context!)!.liveConsultations;
  static String get patientsCases => AppLocalizations.of(Get.context!)!.patientsCases;
  static String get casesDetails => AppLocalizations.of(Get.context!)!.casesDetails;
  static String get myCases => AppLocalizations.of(Get.context!)!.myCases;
  static String get myOrders => AppLocalizations.of(Get.context!)!.myOrders;
  static String get patientAdmissions => AppLocalizations.of(Get.context!)!.patientAdmissions;
  static String get myAdmissions => AppLocalizations.of(Get.context!)!.myAdmissions;
  static String get prescriptions => AppLocalizations.of(Get.context!)!.prescriptions;
  static String get vaccinatedPatients => AppLocalizations.of(Get.context!)!.vaccinatedPatients;
  static String get logOut => AppLocalizations.of(Get.context!)!.logOut;
  static String get myAccount => AppLocalizations.of(Get.context!)!.myAccount;
  static String get editProfile => AppLocalizations.of(Get.context!)!.editProfile;
  static String get changePassword => AppLocalizations.of(Get.context!)!.changePassword;
  static String get firstName => AppLocalizations.of(Get.context!)!.firstName;
  static String get lastName => AppLocalizations.of(Get.context!)!.lastName;
  static String get email => AppLocalizations.of(Get.context!)!.email;
  static String get phone => AppLocalizations.of(Get.context!)!.phone;
  static String get address => AppLocalizations.of(Get.context!)!.address;
  static String get cityLabel => AppLocalizations.of(Get.context!)!.cityLabel;
  static String get pincode => AppLocalizations.of(Get.context!)!.pincode;
  static String get save => AppLocalizations.of(Get.context!)!.save;

  static String get currentPassword => AppLocalizations.of(Get.context!)!.currentPassword;
  static String get newPassword => AppLocalizations.of(Get.context!)!.newPassword;
  static String get confirmPassword => AppLocalizations.of(Get.context!)!.confirmPassword;
  static String get newAppointment => AppLocalizations.of(Get.context!)!.newAppointment;
  static String get doctorDepartment => AppLocalizations.of(Get.context!)!.doctorDepartment;
  static String get doctor => AppLocalizations.of(Get.context!)!.doctor;

  static String get slotAvailable => AppLocalizations.of(Get.context!)!.slotAvailable;
  static String get description => AppLocalizations.of(Get.context!)!.description;

  /// Admission
  static String get admissionDetails => AppLocalizations.of(Get.context!)!.admissionDetails;
  static String get insuranceDetails => AppLocalizations.of(Get.context!)!.insuranceDetails;
  static String get admissionId => AppLocalizations.of(Get.context!)!.admissionId;
  static String get admissionDate => AppLocalizations.of(Get.context!)!.admissionDate;
  static String get dischargeDate => AppLocalizations.of(Get.context!)!.dischargeDate;
  static String get bed => AppLocalizations.of(Get.context!)!.bed;
  static String get guardianName => AppLocalizations.of(Get.context!)!.guardianName;
  static String get guardianRelation => AppLocalizations.of(Get.context!)!.guardianRelation;
  static String get guardianContact => AppLocalizations.of(Get.context!)!.guardianContact;
  static String get guardianAddress => AppLocalizations.of(Get.context!)!.guardianAddress;
  static String get createOn => AppLocalizations.of(Get.context!)!.createOn;
  static String get packageName => AppLocalizations.of(Get.context!)!.packageName;
  static String get insuranceName => AppLocalizations.of(Get.context!)!.insuranceName;
  static String get agentName => AppLocalizations.of(Get.context!)!.agentName;
  static String get policyNo => AppLocalizations.of(Get.context!)!.policyNo;

  /// bill
  static String get patientCellNO => AppLocalizations.of(Get.context!)!.patientCellNO;
  static String get totalDays => AppLocalizations.of(Get.context!)!.totalDays;
  static String get itemDetails => AppLocalizations.of(Get.context!)!.itemDetails;
  static String get totalAmount => AppLocalizations.of(Get.context!)!.totalAmount;
  static String get downloadBill => AppLocalizations.of(Get.context!)!.downloadBill;
  static String get fee => AppLocalizations.of(Get.context!)!.fee;

  /// Consultancy
  static String get liveConsultationsDetails => AppLocalizations.of(Get.context!)!.liveConsultationsDetails;
  static String get consultationTitle => AppLocalizations.of(Get.context!)!.consultationTitle;
  static String get consultationDate => AppLocalizations.of(Get.context!)!.consultationDate;
  static String get durationMinute => AppLocalizations.of(Get.context!)!.durationMinute;
  static String get doctorName => AppLocalizations.of(Get.context!)!.doctorName;
  static String get type => AppLocalizations.of(Get.context!)!.type;
  static String get typeNumber => AppLocalizations.of(Get.context!)!.typeNumber;

  /// diagnosis
  static String get diagnosisCategory => AppLocalizations.of(Get.context!)!.diagnosisCategory;
  static String get reportNumber => AppLocalizations.of(Get.context!)!.reportNumber;
  static String get averageGlucose => AppLocalizations.of(Get.context!)!.averageGlucose;
  static String get fastingBloodSugar => AppLocalizations.of(Get.context!)!.fastingBloodSugar;
  static String get urineSugar => AppLocalizations.of(Get.context!)!.urineSugar;
  static String get bloodPressure => AppLocalizations.of(Get.context!)!.bloodPressure;
  static String get diabetes => AppLocalizations.of(Get.context!)!.diabetes;
  static String get cholesterol => AppLocalizations.of(Get.context!)!.cholesterol;
  static String get downloadDiagnosisTest => AppLocalizations.of(Get.context!)!.downloadDiagnosisTest;

  ///document
  static String get title => AppLocalizations.of(Get.context!)!.title;
  static String get documentType => AppLocalizations.of(Get.context!)!.documentType;
  static String get attachment => AppLocalizations.of(Get.context!)!.attachment;
  static String get note => AppLocalizations.of(Get.context!)!.note;

  /// invoice
  static String get issueFor => AppLocalizations.of(Get.context!)!.issueFor;
  static String get issueBy => AppLocalizations.of(Get.context!)!.issueBy;
  static String get subTotal => AppLocalizations.of(Get.context!)!.subTotal;
  static String get discount => AppLocalizations.of(Get.context!)!.discount;
  static String get downloadInvoice => AppLocalizations.of(Get.context!)!.downloadInvoice;
  static String get downInvoice => AppLocalizations.of(Get.context!)!.downInvoice;

  /// prescription
  static String get foodAllergies => AppLocalizations.of(Get.context!)!.foodAllergies;
  static String get tendencyBleed => AppLocalizations.of(Get.context!)!.tendencyBleed;
  static String get heartDisease => AppLocalizations.of(Get.context!)!.heartDisease;
  static String get highBloodPressure => AppLocalizations.of(Get.context!)!.highBloodPressure;
  static String get surgery => AppLocalizations.of(Get.context!)!.surgery;
  static String get accident => AppLocalizations.of(Get.context!)!.accident;
  static String get others => AppLocalizations.of(Get.context!)!.others;
  static String get medicalHistory => AppLocalizations.of(Get.context!)!.medicalHistory;
  static String get currentMedication => AppLocalizations.of(Get.context!)!.currentMedication;
  static String get femalePregnancy => AppLocalizations.of(Get.context!)!.femalePregnancy;
  static String get breastFeeding => AppLocalizations.of(Get.context!)!.breastFeeding;
  static String get healthInsurance => AppLocalizations.of(Get.context!)!.healthInsurance;
  static String get lowIncome => AppLocalizations.of(Get.context!)!.lowIncome;
  static String get reference => AppLocalizations.of(Get.context!)!.reference;

  /// hint text
  static String get selectDepartment => AppLocalizations.of(Get.context!)!.selectDepartment;
  static String get selectDoctor => AppLocalizations.of(Get.context!)!.selectDoctor;
  static String get selectDate => AppLocalizations.of(Get.context!)!.selectDate;
  static String get typeHere => AppLocalizations.of(Get.context!)!.typeHere;
  static String get date => AppLocalizations.of(Get.context!)!.date;

  /// Doctor Panel
  static String get bedAssign => AppLocalizations.of(Get.context!)!.bedAssign;
  static String get bedStatus => AppLocalizations.of(Get.context!)!.bedStatus;
  static String get doctorDrawer => AppLocalizations.of(Get.context!)!.doctorDrawer;
  static String get schedules => AppLocalizations.of(Get.context!)!.schedules;
  static String get myPayRoll => AppLocalizations.of(Get.context!)!.myPayRoll;
  static String get reports => AppLocalizations.of(Get.context!)!.reports;
  static String get icu => AppLocalizations.of(Get.context!)!.icu;
  static String get confirm => AppLocalizations.of(Get.context!)!.confirm;
  static String get patientAdmissionInDoctor => AppLocalizations.of(Get.context!)!.patientAdmissionInDoctor;
  static String get patientDetails => AppLocalizations.of(Get.context!)!.patientDetails;
  static String get prescriptionDetails => AppLocalizations.of(Get.context!)!.prescriptionDetails;
  static String get overview => AppLocalizations.of(Get.context!)!.overview;
  static String get rx => AppLocalizations.of(Get.context!)!.rx;
  static String get downloadPrescription => AppLocalizations.of(Get.context!)!.downloadPrescription;
  static String get patient => AppLocalizations.of(Get.context!)!.patient;
  static String get height => AppLocalizations.of(Get.context!)!.height;
  static String get age => AppLocalizations.of(Get.context!)!.age;
  static String get weight => AppLocalizations.of(Get.context!)!.weight;

  /// payRoll
  static String get srNo => AppLocalizations.of(Get.context!)!.srNo;
  static String get myPayrolls => AppLocalizations.of(Get.context!)!.myPayrolls;
  static String get payrollsDetails => AppLocalizations.of(Get.context!)!.payrollsDetails;
  static String get salaryDetails => AppLocalizations.of(Get.context!)!.salaryDetails;
  static String get basicSalary => AppLocalizations.of(Get.context!)!.basicSalary;
  static String get allowance => AppLocalizations.of(Get.context!)!.allowance;
  static String get deductions => AppLocalizations.of(Get.context!)!.deductions;
  static String get netSalary => AppLocalizations.of(Get.context!)!.netSalary;

  ///
  static String get patientName => AppLocalizations.of(Get.context!)!.patientName;

  /// report
  static String get report => AppLocalizations.of(Get.context!)!.report;
  static String get birthReport => AppLocalizations.of(Get.context!)!.birthReport;
  static String get deathReport => AppLocalizations.of(Get.context!)!.deathReport;
  static String get investigationReport => AppLocalizations.of(Get.context!)!.investigationReport;
  static String get operationReport => AppLocalizations.of(Get.context!)!.operationReport;

  static String get newCase => AppLocalizations.of(Get.context!)!.newCase;
  static String get ipdPatient => AppLocalizations.of(Get.context!)!.ipdPatient;
  static String get bedInEditBed => AppLocalizations.of(Get.context!)!.bedInEditBed;
  static String get assignDate => AppLocalizations.of(Get.context!)!.assignDate;
  static String get disChargeDate => AppLocalizations.of(Get.context!)!.disChargeDate;

  ///Super Admin Panel
  static String get hospitalRegistration => AppLocalizations.of(Get.context!)!.hospitalRegistration;
  static String get dashboard => AppLocalizations.of(Get.context!)!.dashboard;
  static String get hospitals => AppLocalizations.of(Get.context!)!.hospitals;
  static String get transaction => AppLocalizations.of(Get.context!)!.transaction;
  static String get subscription => AppLocalizations.of(Get.context!)!.subscription;
  static String get setting => AppLocalizations.of(Get.context!)!.setting;

  static String get totalHospital => AppLocalizations.of(Get.context!)!.totalHospital;
  static String get totalRevenue => AppLocalizations.of(Get.context!)!.totalRevenue;
  static String get activePlan => AppLocalizations.of(Get.context!)!.activePlan;
  static String get expiredPlan => AppLocalizations.of(Get.context!)!.expiredPlan;
  static String get incomeOverview => AppLocalizations.of(Get.context!)!.incomeOverview;

  ///hospital
  static String get addHospital => AppLocalizations.of(Get.context!)!.addHospital;
  static String get editHospital => AppLocalizations.of(Get.context!)!.editHospital;
  static String get hospitalDetail => AppLocalizations.of(Get.context!)!.hospitalDetail;
  static String get hospitalName => AppLocalizations.of(Get.context!)!.hospitalName;
  static String get hospitalSlug => AppLocalizations.of(Get.context!)!.hospitalSlug;
  static String get hospitalType => AppLocalizations.of(Get.context!)!.hospitalType;
  static String get city => AppLocalizations.of(Get.context!)!.city;
  static String get password => AppLocalizations.of(Get.context!)!.password;
  static String get emailAddress => AppLocalizations.of(Get.context!)!.emailAddress;
  static String get status => AppLocalizations.of(Get.context!)!.status;

  ///transaction
  static String get transactionDetail => AppLocalizations.of(Get.context!)!.transactionDetail;
  static String get payments => AppLocalizations.of(Get.context!)!.payments;
  static String get amount => AppLocalizations.of(Get.context!)!.amount;
  static String get transactionDate => AppLocalizations.of(Get.context!)!.transactionDate;
  static String get paymentApproved => AppLocalizations.of(Get.context!)!.paymentApproved;

  ///subscription
  static String get subscriptionDetail => AppLocalizations.of(Get.context!)!.subscriptionDetail;
  static String get editSubscription => AppLocalizations.of(Get.context!)!.editSubscription;
  static String get planName => AppLocalizations.of(Get.context!)!.planName;
  static String get startDate => AppLocalizations.of(Get.context!)!.startDate;
  static String get expiresOn => AppLocalizations.of(Get.context!)!.expiresOn;
  static String get frequency => AppLocalizations.of(Get.context!)!.frequency;
  static String get smsLimit => AppLocalizations.of(Get.context!)!.smsLimit;

  ///settings
  static String get appName => AppLocalizations.of(Get.context!)!.appName;
  static String get planExpireNotification => AppLocalizations.of(Get.context!)!.planExpireNotification;
  static String get defaultCountryCode => AppLocalizations.of(Get.context!)!.defaultCountryCode;
  static String get currentCurrency => AppLocalizations.of(Get.context!)!.currentCurrency;
  static String get language => AppLocalizations.of(Get.context!)!.language;
  static String get appLogo => AppLocalizations.of(Get.context!)!.appLogo;
  static String get favicon => AppLocalizations.of(Get.context!)!.favicon;

  ///Admin Panel
  static String get patients => AppLocalizations.of(Get.context!)!.patients;
  static String get patientsDetails => AppLocalizations.of(Get.context!)!.patientsDetails;
  static String get doctorList => AppLocalizations.of(Get.context!)!.doctorList;
  static String get doctorDetails => AppLocalizations.of(Get.context!)!.doctorDetails;
  static String get bedManagement => AppLocalizations.of(Get.context!)!.bedManagement;
  static String get Notificationicon => AppLocalizations.of(Get.context!)!.notification;
  ///dashboard
  static String get invoiceAmount => AppLocalizations.of(Get.context!)!.invoiceAmount;
  static String get billAmount => AppLocalizations.of(Get.context!)!.billAmount;
  static String get paymentAmount => AppLocalizations.of(Get.context!)!.paymentAmount;
  static String get advPayment => AppLocalizations.of(Get.context!)!.advPayment;
  static String get doctors => AppLocalizations.of(Get.context!)!.doctors;
  static String get availablePatients => AppLocalizations.of(Get.context!)!.availablePatients;
  static String get nurses => AppLocalizations.of(Get.context!)!.nurses;
  static String get availableBeds => AppLocalizations.of(Get.context!)!.availableBeds;
  static String get upcomingAppointments => AppLocalizations.of(Get.context!)!.upcomingAppointments;

  static String get companyName => AppLocalizations.of(Get.context!)!.companyName;
  static String get hospitalEmail => AppLocalizations.of(Get.context!)!.hospitalEmail;
  static String get enableGoogleCaptcha => AppLocalizations.of(Get.context!)!.enableGoogleCaptcha;
  static String get hospitalPhone => AppLocalizations.of(Get.context!)!.hospitalPhone;

  /// Localization Additions
  static String get medicines => AppLocalizations.of(Get.context!)!.medicines;
  static String get book => AppLocalizations.of(Get.context!)!.book;
  static String get categories => AppLocalizations.of(Get.context!)!.categories;
  static String get viewAll => AppLocalizations.of(Get.context!)!.viewAll;
  static String get clearAll => AppLocalizations.of(Get.context!)!.clearAll;
  static String get today => AppLocalizations.of(Get.context!)!.today;
  static String get yesterday => AppLocalizations.of(Get.context!)!.yesterday;
  static String get thisWeek => AppLocalizations.of(Get.context!)!.thisWeek;
  static String get older => AppLocalizations.of(Get.context!)!.older;
  static String get clearAllNotifications => AppLocalizations.of(Get.context!)!.clearAllNotifications;
  static String get clearAllNotificationsConfirm => AppLocalizations.of(Get.context!)!.clearAllNotificationsConfirm;
  static String get exitApp => AppLocalizations.of(Get.context!)!.exitApp;
  static String get exitAppConfirm => AppLocalizations.of(Get.context!)!.exitAppConfirm;
  static String get mAgo => AppLocalizations.of(Get.context!)!.m_ago;
  static String get hAgo => AppLocalizations.of(Get.context!)!.h_ago;
  static String get dismiss => AppLocalizations.of(Get.context!)!.dismiss;
  static String get noNotificationsFound => AppLocalizations.of(Get.context!)!.noNotificationsFound;
  static String get viewAppointments => AppLocalizations.of(Get.context!)!.viewAppointments;
  static String get notifications => AppLocalizations.of(Get.context!)!.notifications;
  static String get notificationDetails => AppLocalizations.of(Get.context!)!.notificationDetails;
  static String get selectLanguage => AppLocalizations.of(Get.context!)!.selectLanguage;
  static String get choosePreferredLanguage => AppLocalizations.of(Get.context!)!.choosePreferredLanguage;
  static String get searchHint => AppLocalizations.of(Get.context!)!.searchHint;
  static String get cardiologist => AppLocalizations.of(Get.context!)!.cardiologist;
  static String get dentist => AppLocalizations.of(Get.context!)!.dentist;
  static String get generalPhysician => AppLocalizations.of(Get.context!)!.generalPhysician;
  static String get dermatologist => AppLocalizations.of(Get.context!)!.dermatologist;
  static String get pharmacyProducts => AppLocalizations.of(Get.context!)!.pharmacyProducts;
  static String get products => AppLocalizations.of(Get.context!)!.products;
  static String get popularDoctors => AppLocalizations.of(Get.context!)!.popularDoctors;
  static String get seeAll => AppLocalizations.of(Get.context!)!.seeAll;
  static String get noDoctorsAvailable => AppLocalizations.of(Get.context!)!.noDoctorsAvailable;
  static String get appointmentConfirmed => AppLocalizations.of(Get.context!)!.appointmentConfirmed;
  static String get arriveOnTime => AppLocalizations.of(Get.context!)!.arriveOnTime;
  static String get mySlot => AppLocalizations.of(Get.context!)!.mySlot;
  static String get myToken => AppLocalizations.of(Get.context!)!.myToken;

  // Regular Updates / Push Notifications
  static String get pushNotification => "Push Notification";
  static String get createPushNotification => "Create Regular Update";
  static String get imageHeader => "IMAGE";
  static String get titleHeader => "TITLE";
  static String get resendHeader => "RESEND";
  static String get actionHeader => "ACTION";
  static String get back => AppLocalizations.of(Get.context!)!.cancel;
  static  String get RegularUpdate => "Regular Updates";
  static  String get  CreateRegularUpdate => "Create Regular Update";

  static String get findYourDoctor => AppLocalizations.of(Get.context!)!.findYourDoctor;
  static String get department => AppLocalizations.of(Get.context!)!.department;
  static String get commonHealthIssues => AppLocalizations.of(Get.context!)!.commonHealthIssues;
  static String get diseaseDetails => AppLocalizations.of(Get.context!)!.diseaseDetails;
  static String get newsletters => AppLocalizations.of(Get.context!)!.newsletters;
  static String get orderSuccessful => AppLocalizations.of(Get.context!)!.orderSuccessful;
  static String get continueShopping => AppLocalizations.of(Get.context!)!.continueShopping;
  static String get orderIdLabel => AppLocalizations.of(Get.context!)!.orderIdLabel;
  static String get completeYourProfile => AppLocalizations.of(Get.context!)!.completeYourProfile;
  static String get almostThereDetails => AppLocalizations.of(Get.context!)!.almostThereDetails;
  static String get enterFirstName => AppLocalizations.of(Get.context!)!.enterFirstName;
  static String get errFirstNameRequired => AppLocalizations.of(Get.context!)!.errFirstNameRequired;
  static String get enterLastName => AppLocalizations.of(Get.context!)!.enterLastName;
  static String get errLastNameRequired => AppLocalizations.of(Get.context!)!.errLastNameRequired;
  static String get submitAndContinue => AppLocalizations.of(Get.context!)!.submitAndContinue;

  // Doctor Session Management

  static const success = "Success";
  static const error = "Error";
  static const sessionLabel = "Session";
  static const pauseSessionTitle = "Pause Session";
  static const startLabel = "Start";
  static const resumeLabel = "Resume";
  static const pauseLabel = "Pause";
  static const stopLabel = "Stop";
  static const pauseNowLabel = "Pause Now";
  static const cancelLabel = "Cancel";
  static const reasonLabel = "Reason";
  static const delayTimeMinutesLabel = "Delay Time (minutes)";
  static const specifyDelayReasonHint = "Specify the delay and reason for pausing your session.";
  static const delayTimeHint = "e.g. 15";
  static const reasonHint = "e.g. Emergency case";
  static const invalidDelayTimeError = "Please enter a valid delay time";
  static const enterReasonError = "Please enter a reason";
  static const invalidInputTitle = "Invalid Input";
  static const sessionPausedSuccess = "Session paused successfully";
  static const sessionStartedSuccess = "Session started successfully";
  static const sessionStoppedSuccess = "Session stopped successfully";
  static const failedToPauseError = "Failed to pause session";
  static const failedToStartError = "Failed to start session";
  static const failedToStopError = "Failed to stop session";
}
