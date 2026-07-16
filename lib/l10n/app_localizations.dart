import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_ml.dart';
import 'app_localizations_ta.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
    Locale('ml'),
    Locale('ta'),
  ];

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @patientRegistration.
  ///
  /// In en, this message translates to:
  /// **'Registration'**
  String get patientRegistration;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @signInEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email or phone number'**
  String get signInEmail;

  /// No description provided for @enterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter New Password'**
  String get enterNewPassword;

  /// No description provided for @enterConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Confirm Password'**
  String get enterConfirmPassword;

  /// No description provided for @signInPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Password'**
  String get signInPassword;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @doctorHospitalLogin.
  ///
  /// In en, this message translates to:
  /// **'Doctor / Hospital Login'**
  String get doctorHospitalLogin;

  /// No description provided for @rememberPassword.
  ///
  /// In en, this message translates to:
  /// **'Remember Me'**
  String get rememberPassword;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @forgotScreenDetail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email to reset your password'**
  String get forgotScreenDetail;

  /// No description provided for @sendLink.
  ///
  /// In en, this message translates to:
  /// **'Send Link'**
  String get sendLink;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back!'**
  String get welcomeBack;

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterYourEmail;

  /// No description provided for @enterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterYourPassword;

  /// No description provided for @orSignInWith.
  ///
  /// In en, this message translates to:
  /// **'Or sign in with'**
  String get orSignInWith;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get dontHaveAccount;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get createAccount;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @bookAppointment.
  ///
  /// In en, this message translates to:
  /// **'Book Appointment'**
  String get bookAppointment;

  /// No description provided for @editDocument.
  ///
  /// In en, this message translates to:
  /// **'Edit Document'**
  String get editDocument;

  /// No description provided for @newDocument.
  ///
  /// In en, this message translates to:
  /// **'New Document'**
  String get newDocument;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @introOneTitle.
  ///
  /// In en, this message translates to:
  /// **'Book an Appointment'**
  String get introOneTitle;

  /// No description provided for @introOneSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Book appointments with ease, putting your health in your hands'**
  String get introOneSubTitle;

  /// No description provided for @introTwoTitle.
  ///
  /// In en, this message translates to:
  /// **'Schedule Live Consultation'**
  String get introTwoTitle;

  /// No description provided for @introTwoSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Seamlessly schedule live consultations, connecting you with healthcare professionals on your terms'**
  String get introTwoSubTitle;

  /// No description provided for @introThreeTitle.
  ///
  /// In en, this message translates to:
  /// **'Read Prescriptions'**
  String get introThreeTitle;

  /// No description provided for @introThreeSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Navigate your treatment with clarity – easily read and follow your doctor\'s prescribed plan'**
  String get introThreeSubTitle;

  /// No description provided for @appointment.
  ///
  /// In en, this message translates to:
  /// **'Appointments'**
  String get appointment;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @bills.
  ///
  /// In en, this message translates to:
  /// **'Bills'**
  String get bills;

  /// No description provided for @billsDetails.
  ///
  /// In en, this message translates to:
  /// **'Bill Details'**
  String get billsDetails;

  /// No description provided for @diagnosisTests.
  ///
  /// In en, this message translates to:
  /// **'Diagnosis Tests'**
  String get diagnosisTests;

  /// No description provided for @diagnosisTestsDetails.
  ///
  /// In en, this message translates to:
  /// **'Diagnosis Test Details'**
  String get diagnosisTestsDetails;

  /// No description provided for @documents.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get documents;

  /// No description provided for @noticeBoards.
  ///
  /// In en, this message translates to:
  /// **'Notice Boards'**
  String get noticeBoards;

  /// No description provided for @invoices.
  ///
  /// In en, this message translates to:
  /// **'Invoices'**
  String get invoices;

  /// No description provided for @liveConsultations.
  ///
  /// In en, this message translates to:
  /// **'Live Consultations'**
  String get liveConsultations;

  /// No description provided for @patientsCases.
  ///
  /// In en, this message translates to:
  /// **'Cases'**
  String get patientsCases;

  /// No description provided for @casesDetails.
  ///
  /// In en, this message translates to:
  /// **'Case Details'**
  String get casesDetails;

  /// No description provided for @myCases.
  ///
  /// In en, this message translates to:
  /// **'My Cases'**
  String get myCases;

  /// No description provided for @myOrders.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get myOrders;

  /// No description provided for @patientAdmissions.
  ///
  /// In en, this message translates to:
  /// **'Admissions'**
  String get patientAdmissions;

  /// No description provided for @myAdmissions.
  ///
  /// In en, this message translates to:
  /// **'My Admissions'**
  String get myAdmissions;

  /// No description provided for @prescriptions.
  ///
  /// In en, this message translates to:
  /// **'Prescriptions'**
  String get prescriptions;

  /// No description provided for @vaccinatedPatients.
  ///
  /// In en, this message translates to:
  /// **'Vaccination'**
  String get vaccinatedPatients;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logOut;

  /// No description provided for @myAccount.
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get myAccount;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name:'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name:'**
  String get lastName;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email:'**
  String get email;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone:'**
  String get phone;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address:'**
  String get address;

  /// No description provided for @cityLabel.
  ///
  /// In en, this message translates to:
  /// **'City:'**
  String get cityLabel;

  /// No description provided for @pincode.
  ///
  /// In en, this message translates to:
  /// **'Pincode:'**
  String get pincode;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @sendEmail.
  ///
  /// In en, this message translates to:
  /// **'Send Email'**
  String get sendEmail;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password:'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password:'**
  String get newPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password:'**
  String get confirmPassword;

  /// No description provided for @newAppointment.
  ///
  /// In en, this message translates to:
  /// **'New Appointment'**
  String get newAppointment;

  /// No description provided for @doctorDepartment.
  ///
  /// In en, this message translates to:
  /// **'Doctor Department:'**
  String get doctorDepartment;

  /// No description provided for @doctor.
  ///
  /// In en, this message translates to:
  /// **'Doctor:'**
  String get doctor;

  /// No description provided for @slotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available Slot:'**
  String get slotAvailable;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description:'**
  String get description;

  /// No description provided for @admissionDetails.
  ///
  /// In en, this message translates to:
  /// **'Admission Details'**
  String get admissionDetails;

  /// No description provided for @insuranceDetails.
  ///
  /// In en, this message translates to:
  /// **'Insurance Details'**
  String get insuranceDetails;

  /// No description provided for @admissionId.
  ///
  /// In en, this message translates to:
  /// **'Admission ID:'**
  String get admissionId;

  /// No description provided for @admissionDate.
  ///
  /// In en, this message translates to:
  /// **'Admission Date:'**
  String get admissionDate;

  /// No description provided for @dischargeDate.
  ///
  /// In en, this message translates to:
  /// **'Discharge Date:'**
  String get dischargeDate;

  /// No description provided for @bed.
  ///
  /// In en, this message translates to:
  /// **'Bed:'**
  String get bed;

  /// No description provided for @guardianName.
  ///
  /// In en, this message translates to:
  /// **'Guardian Name:'**
  String get guardianName;

  /// No description provided for @guardianRelation.
  ///
  /// In en, this message translates to:
  /// **'Guardian Relation:'**
  String get guardianRelation;

  /// No description provided for @guardianContact.
  ///
  /// In en, this message translates to:
  /// **'Guardian Contact:'**
  String get guardianContact;

  /// No description provided for @guardianAddress.
  ///
  /// In en, this message translates to:
  /// **'Guardian Address:'**
  String get guardianAddress;

  /// No description provided for @createOn.
  ///
  /// In en, this message translates to:
  /// **'Created On:'**
  String get createOn;

  /// No description provided for @packageName.
  ///
  /// In en, this message translates to:
  /// **'Package Name:'**
  String get packageName;

  /// No description provided for @insuranceName.
  ///
  /// In en, this message translates to:
  /// **'Insurance Name:'**
  String get insuranceName;

  /// No description provided for @agentName.
  ///
  /// In en, this message translates to:
  /// **'Agent Name:'**
  String get agentName;

  /// No description provided for @policyNo.
  ///
  /// In en, this message translates to:
  /// **'Policy No:'**
  String get policyNo;

  /// No description provided for @patientCellNO.
  ///
  /// In en, this message translates to:
  /// **'Patient Cell No:'**
  String get patientCellNO;

  /// No description provided for @totalDays.
  ///
  /// In en, this message translates to:
  /// **'Total Days:'**
  String get totalDays;

  /// No description provided for @itemDetails.
  ///
  /// In en, this message translates to:
  /// **'Item Details'**
  String get itemDetails;

  /// No description provided for @totalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get totalAmount;

  /// No description provided for @downloadBill.
  ///
  /// In en, this message translates to:
  /// **'Download Bill'**
  String get downloadBill;

  /// No description provided for @fee.
  ///
  /// In en, this message translates to:
  /// **'Fee:'**
  String get fee;

  /// No description provided for @liveConsultationsDetails.
  ///
  /// In en, this message translates to:
  /// **'Live Consultations Details'**
  String get liveConsultationsDetails;

  /// No description provided for @consultationTitle.
  ///
  /// In en, this message translates to:
  /// **'Consultation Title:'**
  String get consultationTitle;

  /// No description provided for @consultationDate.
  ///
  /// In en, this message translates to:
  /// **'Consultation Date:'**
  String get consultationDate;

  /// No description provided for @durationMinute.
  ///
  /// In en, this message translates to:
  /// **'Duration Minutes:'**
  String get durationMinute;

  /// No description provided for @doctorName.
  ///
  /// In en, this message translates to:
  /// **'Doctor Name:'**
  String get doctorName;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type:'**
  String get type;

  /// No description provided for @typeNumber.
  ///
  /// In en, this message translates to:
  /// **'Type Number:'**
  String get typeNumber;

  /// No description provided for @diagnosisCategory.
  ///
  /// In en, this message translates to:
  /// **'Diagnosis Category:'**
  String get diagnosisCategory;

  /// No description provided for @reportNumber.
  ///
  /// In en, this message translates to:
  /// **'Report number:'**
  String get reportNumber;

  /// No description provided for @averageGlucose.
  ///
  /// In en, this message translates to:
  /// **'Average Glucose:'**
  String get averageGlucose;

  /// No description provided for @fastingBloodSugar.
  ///
  /// In en, this message translates to:
  /// **'Fasting Blood Sugar:'**
  String get fastingBloodSugar;

  /// No description provided for @urineSugar.
  ///
  /// In en, this message translates to:
  /// **'Urine Sugar:'**
  String get urineSugar;

  /// No description provided for @bloodPressure.
  ///
  /// In en, this message translates to:
  /// **'Blood Pressure:'**
  String get bloodPressure;

  /// No description provided for @diabetes.
  ///
  /// In en, this message translates to:
  /// **'Diabetes:'**
  String get diabetes;

  /// No description provided for @cholesterol.
  ///
  /// In en, this message translates to:
  /// **'Cholesterol:'**
  String get cholesterol;

  /// No description provided for @downloadDiagnosisTest.
  ///
  /// In en, this message translates to:
  /// **'Download Diagnosis Test PDF'**
  String get downloadDiagnosisTest;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title:'**
  String get title;

  /// No description provided for @documentType.
  ///
  /// In en, this message translates to:
  /// **'Document Type:'**
  String get documentType;

  /// No description provided for @attachment.
  ///
  /// In en, this message translates to:
  /// **'Attachment:'**
  String get attachment;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Notes:'**
  String get note;

  /// No description provided for @issueFor.
  ///
  /// In en, this message translates to:
  /// **'Issue For:'**
  String get issueFor;

  /// No description provided for @issueBy.
  ///
  /// In en, this message translates to:
  /// **'Issue By:'**
  String get issueBy;

  /// No description provided for @subTotal.
  ///
  /// In en, this message translates to:
  /// **'Sub Total:'**
  String get subTotal;

  /// No description provided for @discount.
  ///
  /// In en, this message translates to:
  /// **'Discount:'**
  String get discount;

  /// No description provided for @downloadInvoice.
  ///
  /// In en, this message translates to:
  /// **'Download Invoice:'**
  String get downloadInvoice;

  /// No description provided for @downInvoice.
  ///
  /// In en, this message translates to:
  /// **'Download Invoice'**
  String get downInvoice;

  /// No description provided for @foodAllergies.
  ///
  /// In en, this message translates to:
  /// **'Food Allergies:'**
  String get foodAllergies;

  /// No description provided for @tendencyBleed.
  ///
  /// In en, this message translates to:
  /// **'Tendency Bleed:'**
  String get tendencyBleed;

  /// No description provided for @heartDisease.
  ///
  /// In en, this message translates to:
  /// **'Heart Disease'**
  String get heartDisease;

  /// No description provided for @highBloodPressure.
  ///
  /// In en, this message translates to:
  /// **'High Blood Pressure:'**
  String get highBloodPressure;

  /// No description provided for @surgery.
  ///
  /// In en, this message translates to:
  /// **'Surgery:'**
  String get surgery;

  /// No description provided for @accident.
  ///
  /// In en, this message translates to:
  /// **'Accident:'**
  String get accident;

  /// No description provided for @others.
  ///
  /// In en, this message translates to:
  /// **'Others:'**
  String get others;

  /// No description provided for @medicalHistory.
  ///
  /// In en, this message translates to:
  /// **'Medical History:'**
  String get medicalHistory;

  /// No description provided for @currentMedication.
  ///
  /// In en, this message translates to:
  /// **'Current Medication:'**
  String get currentMedication;

  /// No description provided for @femalePregnancy.
  ///
  /// In en, this message translates to:
  /// **'Female Pregnancy:'**
  String get femalePregnancy;

  /// No description provided for @breastFeeding.
  ///
  /// In en, this message translates to:
  /// **'Breast Feeding:'**
  String get breastFeeding;

  /// No description provided for @healthInsurance.
  ///
  /// In en, this message translates to:
  /// **'Health Insurance:'**
  String get healthInsurance;

  /// No description provided for @lowIncome.
  ///
  /// In en, this message translates to:
  /// **'Low Income:'**
  String get lowIncome;

  /// No description provided for @reference.
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get reference;

  /// No description provided for @selectDepartment.
  ///
  /// In en, this message translates to:
  /// **'Select Department'**
  String get selectDepartment;

  /// No description provided for @selectDoctor.
  ///
  /// In en, this message translates to:
  /// **'Select Doctor'**
  String get selectDoctor;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDate;

  /// No description provided for @typeHere.
  ///
  /// In en, this message translates to:
  /// **'Type here..'**
  String get typeHere;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date:'**
  String get date;

  /// No description provided for @bedAssign.
  ///
  /// In en, this message translates to:
  /// **'Bed Assigns'**
  String get bedAssign;

  /// No description provided for @bedStatus.
  ///
  /// In en, this message translates to:
  /// **'Bed Status'**
  String get bedStatus;

  /// No description provided for @doctorDrawer.
  ///
  /// In en, this message translates to:
  /// **'Doctor'**
  String get doctorDrawer;

  /// No description provided for @schedules.
  ///
  /// In en, this message translates to:
  /// **'Schedules'**
  String get schedules;

  /// No description provided for @myPayRoll.
  ///
  /// In en, this message translates to:
  /// **'My Payrolls'**
  String get myPayRoll;

  /// No description provided for @reports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reports;

  /// No description provided for @icu.
  ///
  /// In en, this message translates to:
  /// **'ICU'**
  String get icu;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @patientAdmissionInDoctor.
  ///
  /// In en, this message translates to:
  /// **'Patient Admissions'**
  String get patientAdmissionInDoctor;

  /// No description provided for @patientDetails.
  ///
  /// In en, this message translates to:
  /// **'Patient Details'**
  String get patientDetails;

  /// No description provided for @prescriptionDetails.
  ///
  /// In en, this message translates to:
  /// **'Prescription Details'**
  String get prescriptionDetails;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @rx.
  ///
  /// In en, this message translates to:
  /// **'Rx:'**
  String get rx;

  /// No description provided for @downloadPrescription.
  ///
  /// In en, this message translates to:
  /// **'Download Prescription'**
  String get downloadPrescription;

  /// No description provided for @patient.
  ///
  /// In en, this message translates to:
  /// **'Patient'**
  String get patient;

  /// No description provided for @height.
  ///
  /// In en, this message translates to:
  /// **'Height:'**
  String get height;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age:'**
  String get age;

  /// No description provided for @weight.
  ///
  /// In en, this message translates to:
  /// **'Weight:'**
  String get weight;

  /// No description provided for @srNo.
  ///
  /// In en, this message translates to:
  /// **'Sr No:'**
  String get srNo;

  /// No description provided for @myPayrolls.
  ///
  /// In en, this message translates to:
  /// **'My Payrolls'**
  String get myPayrolls;

  /// No description provided for @payrollsDetails.
  ///
  /// In en, this message translates to:
  /// **'Payroll Details'**
  String get payrollsDetails;

  /// No description provided for @salaryDetails.
  ///
  /// In en, this message translates to:
  /// **'Salary Details'**
  String get salaryDetails;

  /// No description provided for @basicSalary.
  ///
  /// In en, this message translates to:
  /// **'Basic Salary:'**
  String get basicSalary;

  /// No description provided for @allowance.
  ///
  /// In en, this message translates to:
  /// **'Allowance:'**
  String get allowance;

  /// No description provided for @deductions.
  ///
  /// In en, this message translates to:
  /// **'Deductions:'**
  String get deductions;

  /// No description provided for @netSalary.
  ///
  /// In en, this message translates to:
  /// **'Net Salary:'**
  String get netSalary;

  /// No description provided for @patientName.
  ///
  /// In en, this message translates to:
  /// **'Patient Name:'**
  String get patientName;

  /// No description provided for @report.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get report;

  /// No description provided for @birthReport.
  ///
  /// In en, this message translates to:
  /// **'Birth Reports'**
  String get birthReport;

  /// No description provided for @deathReport.
  ///
  /// In en, this message translates to:
  /// **'Death Reports'**
  String get deathReport;

  /// No description provided for @investigationReport.
  ///
  /// In en, this message translates to:
  /// **'Investigation Reports'**
  String get investigationReport;

  /// No description provided for @operationReport.
  ///
  /// In en, this message translates to:
  /// **'Operation Reports'**
  String get operationReport;

  /// No description provided for @newCase.
  ///
  /// In en, this message translates to:
  /// **'Case:'**
  String get newCase;

  /// No description provided for @ipdPatient.
  ///
  /// In en, this message translates to:
  /// **'IPD Patient:'**
  String get ipdPatient;

  /// No description provided for @bedInEditBed.
  ///
  /// In en, this message translates to:
  /// **'Bed:'**
  String get bedInEditBed;

  /// No description provided for @assignDate.
  ///
  /// In en, this message translates to:
  /// **'Assign Date:'**
  String get assignDate;

  /// No description provided for @disChargeDate.
  ///
  /// In en, this message translates to:
  /// **'Discharge Date:'**
  String get disChargeDate;

  /// No description provided for @hospitalRegistration.
  ///
  /// In en, this message translates to:
  /// **'Hospital Registration'**
  String get hospitalRegistration;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @hospitals.
  ///
  /// In en, this message translates to:
  /// **'Hospitals'**
  String get hospitals;

  /// No description provided for @transaction.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transaction;

  /// No description provided for @subscription.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions'**
  String get subscription;

  /// No description provided for @setting.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get setting;

  /// No description provided for @totalHospital.
  ///
  /// In en, this message translates to:
  /// **'Total Hospital'**
  String get totalHospital;

  /// No description provided for @totalRevenue.
  ///
  /// In en, this message translates to:
  /// **'Total Revenue'**
  String get totalRevenue;

  /// No description provided for @activePlan.
  ///
  /// In en, this message translates to:
  /// **'Total Active Hospital Plans'**
  String get activePlan;

  /// No description provided for @expiredPlan.
  ///
  /// In en, this message translates to:
  /// **'Total Expired Hospital Plans'**
  String get expiredPlan;

  /// No description provided for @incomeOverview.
  ///
  /// In en, this message translates to:
  /// **'Income Overview'**
  String get incomeOverview;

  /// No description provided for @addHospital.
  ///
  /// In en, this message translates to:
  /// **'Add Hospital'**
  String get addHospital;

  /// No description provided for @editHospital.
  ///
  /// In en, this message translates to:
  /// **'Edit Hospital'**
  String get editHospital;

  /// No description provided for @hospitalDetail.
  ///
  /// In en, this message translates to:
  /// **'Hospital Details'**
  String get hospitalDetail;

  /// No description provided for @hospitalName.
  ///
  /// In en, this message translates to:
  /// **'Hospital Name:'**
  String get hospitalName;

  /// No description provided for @hospitalSlug.
  ///
  /// In en, this message translates to:
  /// **'Hospital Slug:'**
  String get hospitalSlug;

  /// No description provided for @hospitalType.
  ///
  /// In en, this message translates to:
  /// **'Hospital Type:'**
  String get hospitalType;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City:'**
  String get city;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password:'**
  String get password;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address:'**
  String get emailAddress;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status:'**
  String get status;

  /// No description provided for @transactionDetail.
  ///
  /// In en, this message translates to:
  /// **'Transactions Details'**
  String get transactionDetail;

  /// No description provided for @payments.
  ///
  /// In en, this message translates to:
  /// **'Payments:'**
  String get payments;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount:'**
  String get amount;

  /// No description provided for @transactionDate.
  ///
  /// In en, this message translates to:
  /// **'Transaction Date:'**
  String get transactionDate;

  /// No description provided for @paymentApproved.
  ///
  /// In en, this message translates to:
  /// **'Payment Approved:'**
  String get paymentApproved;

  /// No description provided for @subscriptionDetail.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions Details'**
  String get subscriptionDetail;

  /// No description provided for @editSubscription.
  ///
  /// In en, this message translates to:
  /// **'Edit Subscriptions'**
  String get editSubscription;

  /// No description provided for @planName.
  ///
  /// In en, this message translates to:
  /// **'Plan Name:'**
  String get planName;

  /// No description provided for @startDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date:'**
  String get startDate;

  /// No description provided for @expiresOn.
  ///
  /// In en, this message translates to:
  /// **'Expires on:'**
  String get expiresOn;

  /// No description provided for @frequency.
  ///
  /// In en, this message translates to:
  /// **'Frequency:'**
  String get frequency;

  /// No description provided for @smsLimit.
  ///
  /// In en, this message translates to:
  /// **'SMS Limit:'**
  String get smsLimit;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'App Name:'**
  String get appName;

  /// No description provided for @planExpireNotification.
  ///
  /// In en, this message translates to:
  /// **'Plan Expire Notification (in Days):'**
  String get planExpireNotification;

  /// No description provided for @defaultCountryCode.
  ///
  /// In en, this message translates to:
  /// **'Default Country Code:'**
  String get defaultCountryCode;

  /// No description provided for @currentCurrency.
  ///
  /// In en, this message translates to:
  /// **'Current Currency:'**
  String get currentCurrency;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language:'**
  String get language;

  /// No description provided for @appLogo.
  ///
  /// In en, this message translates to:
  /// **'App Logo:'**
  String get appLogo;

  /// No description provided for @favicon.
  ///
  /// In en, this message translates to:
  /// **'Favicon:'**
  String get favicon;

  /// No description provided for @patients.
  ///
  /// In en, this message translates to:
  /// **'Patients'**
  String get patients;

  /// No description provided for @patientsDetails.
  ///
  /// In en, this message translates to:
  /// **'Patients Details'**
  String get patientsDetails;

  /// No description provided for @doctorList.
  ///
  /// In en, this message translates to:
  /// **'Doctors'**
  String get doctorList;

  /// No description provided for @doctorDetails.
  ///
  /// In en, this message translates to:
  /// **'Doctors Details'**
  String get doctorDetails;

  /// No description provided for @bedManagement.
  ///
  /// In en, this message translates to:
  /// **'Bed Management'**
  String get bedManagement;

  /// No description provided for @invoiceAmount.
  ///
  /// In en, this message translates to:
  /// **'Invoice Amount'**
  String get invoiceAmount;

  /// No description provided for @billAmount.
  ///
  /// In en, this message translates to:
  /// **'Bill Amount'**
  String get billAmount;

  /// No description provided for @paymentAmount.
  ///
  /// In en, this message translates to:
  /// **'Payment Amount'**
  String get paymentAmount;

  /// No description provided for @advPayment.
  ///
  /// In en, this message translates to:
  /// **'Adv. Payment Amount'**
  String get advPayment;

  /// No description provided for @doctors.
  ///
  /// In en, this message translates to:
  /// **'Doctors'**
  String get doctors;

  /// No description provided for @availablePatients.
  ///
  /// In en, this message translates to:
  /// **'Patients'**
  String get availablePatients;

  /// No description provided for @nurses.
  ///
  /// In en, this message translates to:
  /// **'Nurses'**
  String get nurses;

  /// No description provided for @availableBeds.
  ///
  /// In en, this message translates to:
  /// **'Available Beds'**
  String get availableBeds;

  /// No description provided for @upcomingAppointments.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Appointments'**
  String get upcomingAppointments;

  /// No description provided for @companyName.
  ///
  /// In en, this message translates to:
  /// **'Company Name:'**
  String get companyName;

  /// No description provided for @hospitalEmail.
  ///
  /// In en, this message translates to:
  /// **'Hospital Email:'**
  String get hospitalEmail;

  /// No description provided for @enableGoogleCaptcha.
  ///
  /// In en, this message translates to:
  /// **'Enable google captcha'**
  String get enableGoogleCaptcha;

  /// No description provided for @hospitalPhone.
  ///
  /// In en, this message translates to:
  /// **'Hospital Phone:'**
  String get hospitalPhone;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// No description provided for @logoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logoutTitle;

  /// No description provided for @logoutConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out of your account?'**
  String get logoutConfirmation;

  /// No description provided for @logoutShortConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure to logout?'**
  String get logoutShortConfirmation;

  /// No description provided for @medicines.
  ///
  /// In en, this message translates to:
  /// **'Medicines'**
  String get medicines;

  /// No description provided for @book.
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get book;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clearAll;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'TODAY'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'YESTERDAY'**
  String get yesterday;

  /// No description provided for @thisWeek.
  ///
  /// In en, this message translates to:
  /// **'THIS WEEK'**
  String get thisWeek;

  /// No description provided for @older.
  ///
  /// In en, this message translates to:
  /// **'OLDER'**
  String get older;

  /// No description provided for @clearAllNotifications.
  ///
  /// In en, this message translates to:
  /// **'Clear All Notifications'**
  String get clearAllNotifications;

  /// No description provided for @clearAllNotificationsConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete all notifications? This action cannot be undone.'**
  String get clearAllNotificationsConfirm;

  /// No description provided for @exitApp.
  ///
  /// In en, this message translates to:
  /// **'Exit App'**
  String get exitApp;

  /// No description provided for @exitAppConfirm.
  ///
  /// In en, this message translates to:
  /// **'Do you want to exit an app?'**
  String get exitAppConfirm;

  /// No description provided for @m_ago.
  ///
  /// In en, this message translates to:
  /// **'m ago'**
  String get m_ago;

  /// No description provided for @h_ago.
  ///
  /// In en, this message translates to:
  /// **'h ago'**
  String get h_ago;

  /// No description provided for @dismiss.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get dismiss;

  /// No description provided for @noNotificationsFound.
  ///
  /// In en, this message translates to:
  /// **'No notifications found'**
  String get noNotificationsFound;

  /// No description provided for @viewAppointments.
  ///
  /// In en, this message translates to:
  /// **'View Appointments'**
  String get viewAppointments;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @notificationDetails.
  ///
  /// In en, this message translates to:
  /// **'Notification Details'**
  String get notificationDetails;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @choosePreferredLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred app language'**
  String get choosePreferredLanguage;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search '**
  String get searchHint;

  /// No description provided for @cardiologist.
  ///
  /// In en, this message translates to:
  /// **'Cardiologist'**
  String get cardiologist;

  /// No description provided for @dentist.
  ///
  /// In en, this message translates to:
  /// **'Dentist'**
  String get dentist;

  /// No description provided for @generalPhysician.
  ///
  /// In en, this message translates to:
  /// **'General Physician'**
  String get generalPhysician;

  /// No description provided for @dermatologist.
  ///
  /// In en, this message translates to:
  /// **'Dermatologist'**
  String get dermatologist;

  /// No description provided for @pharmacyProducts.
  ///
  /// In en, this message translates to:
  /// **'Pharmacy Products'**
  String get pharmacyProducts;

  /// No description provided for @products.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get products;

  /// No description provided for @popularDoctors.
  ///
  /// In en, this message translates to:
  /// **'Popular Doctors'**
  String get popularDoctors;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @noDoctorsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No doctors available.'**
  String get noDoctorsAvailable;

  /// No description provided for @appointmentConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Your Appointment is Confirmed'**
  String get appointmentConfirmed;

  /// No description provided for @arriveOnTime.
  ///
  /// In en, this message translates to:
  /// **'Please arrive on time'**
  String get arriveOnTime;

  /// No description provided for @mySlot.
  ///
  /// In en, this message translates to:
  /// **'My Slot'**
  String get mySlot;

  /// No description provided for @myToken.
  ///
  /// In en, this message translates to:
  /// **'My Token'**
  String get myToken;

  /// No description provided for @findYourDoctor.
  ///
  /// In en, this message translates to:
  /// **'Find your doctor'**
  String get findYourDoctor;

  /// No description provided for @department.
  ///
  /// In en, this message translates to:
  /// **'Department'**
  String get department;

  /// No description provided for @commonHealthIssues.
  ///
  /// In en, this message translates to:
  /// **'Common Health Issues'**
  String get commonHealthIssues;

  /// No description provided for @diseaseDetails.
  ///
  /// In en, this message translates to:
  /// **'Disease Details'**
  String get diseaseDetails;

  /// No description provided for @newsletters.
  ///
  /// In en, this message translates to:
  /// **'Newsletters'**
  String get newsletters;

  /// No description provided for @orderSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Order Successful!'**
  String get orderSuccessful;

  /// No description provided for @continueShopping.
  ///
  /// In en, this message translates to:
  /// **'Continue Shopping'**
  String get continueShopping;

  /// No description provided for @orderIdLabel.
  ///
  /// In en, this message translates to:
  /// **'Order ID'**
  String get orderIdLabel;

  /// No description provided for @completeYourProfile.
  ///
  /// In en, this message translates to:
  /// **'Complete Your Profile'**
  String get completeYourProfile;

  /// No description provided for @almostThereDetails.
  ///
  /// In en, this message translates to:
  /// **'Almost there! Please provide your details to continue.'**
  String get almostThereDetails;

  /// No description provided for @enterFirstName.
  ///
  /// In en, this message translates to:
  /// **'Enter First Name'**
  String get enterFirstName;

  /// No description provided for @errFirstNameRequired.
  ///
  /// In en, this message translates to:
  /// **'First name is required'**
  String get errFirstNameRequired;

  /// No description provided for @enterLastName.
  ///
  /// In en, this message translates to:
  /// **'Enter Last Name'**
  String get enterLastName;

  /// No description provided for @errLastNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Last name is required'**
  String get errLastNameRequired;

  /// No description provided for @submitAndContinue.
  ///
  /// In en, this message translates to:
  /// **'Submit & Continue'**
  String get submitAndContinue;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi', 'ml', 'ta'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'ml':
      return AppLocalizationsMl();
    case 'ta':
      return AppLocalizationsTa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
