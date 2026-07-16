import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class ListUtils {
  static List<Map<String, dynamic>> get drawerList => [
    {
      "icon": ImageUtils.homeIcon,
      "title": StringUtils.home,
    },
    {
      "icon": ImageUtils.billsIcon,
      "title": StringUtils.bills,
    },
    {
      "icon": ImageUtils.diagnosisTestIcon,
      "title": StringUtils.diagnosisTests,
    },
    {
      "icon": ImageUtils.documentIcon,
      "title": StringUtils.documents,
    },
    {
      "icon": ImageUtils.invoiceIcon,
      "title": StringUtils.invoices,
    },
    {
      "icon": ImageUtils.billsIcon,
      "title": StringUtils.myOrders,
    },
    // {
    //   "icon": ImageUtils.liveConsIcon,
    //   "title": StringUtils.liveConsultations,
    // },
    {
      "icon": ImageUtils.patientCaseIcon,
      "title": StringUtils.patientsCases,
    },
    {
      "icon": ImageUtils.patientAdmissionIcon,
      "title": StringUtils.patientAdmissions,
    },
    {
      "icon": ImageUtils.prescriptionIcon,
      "title": StringUtils.prescriptions,
    },
    {
      "icon": ImageUtils.vaccinatedIcon,
      "title": StringUtils.vaccinatedPatients,
    },
    {
      "icon": ImageUtils.newsletterIcon,
      "title": StringUtils.newsletters,
    },
  ];

  static List<Map<String, dynamic>> get doctorDrawerList => [
    {
      "title":StringUtils.dashboard, // Or StringUtils.dashboard if you have it defined
      "icon": ImageUtils.dashboardIcon, // Make sure you have a valid icon path here!
    },
    {
      "icon": ImageUtils.appointmentsIcon,
      "title": StringUtils.appointment,
    },
    {
      "icon": ImageUtils.bedAssignIcon,
      "title": StringUtils.bedAssign,
    },
    {
      "icon": ImageUtils.bedStatusIcon,
      "title": StringUtils.bedStatus,
    },
    {
      "icon": ImageUtils.doctorsIcon,
      "title": StringUtils.doctorDrawer,
    },
    {
      "icon": ImageUtils.schedulesIcon,
      "title": StringUtils.schedules,
    },
    {
      "icon": ImageUtils.prescriptionIcon,
      "title": StringUtils.prescriptions,
    },
    {
      "icon": ImageUtils.documentIcon,
      "title": StringUtils.documents,
    },
    {
      "icon": ImageUtils.diagnosisTestIcon,
      "title": StringUtils.diagnosisTests,
    },
    {
      "icon": ImageUtils.noticeIcon,
      "title": StringUtils.noticeBoards,
    },
    // {
    //   "icon": ImageUtils.liveConsIcon,
    //   "title": StringUtils.liveConsultations,
    // },
    {
      "icon": ImageUtils.myPayrollIcon,
      "title": StringUtils.myPayRoll,
    },
    {
      "icon": ImageUtils.admissionIconForDoctor,
      "title": StringUtils.patientAdmissionInDoctor,
    },
    {
      "icon": ImageUtils.reportsIcon,
      "title": StringUtils.reports,
    },
  ];

  static List<Map<String, dynamic>> get superAdminDrawerList => [
    {
      "icon": ImageUtils.dashboardIcon,
      "title": StringUtils.dashboard,
    },
    {
      "icon": ImageUtils.hospitalIcon,
      "title": StringUtils.hospitals,
    },
    {
      "icon": ImageUtils.transactionIcon,
      "title": StringUtils.transaction,
    },
    {
      "icon": ImageUtils.subscriptionIcon,
      "title": StringUtils.subscription,
    },
    {"icon": ImageUtils.settingIcon, "title": StringUtils.setting}
  ];

  static List<Map<String, dynamic>> get adminDrawerList => [
    {
      "icon": ImageUtils.dashboardIcon,
      "title": StringUtils.dashboard,
    },
    {
      "icon": ImageUtils.appointmentsIcon,
      "title": StringUtils.appointment,
    },
    {
      "icon": ImageUtils.patientIcon,
      "title": StringUtils.patients,
    },
    {
      "icon": ImageUtils.doctorsIcon,
      "title": StringUtils.doctorList,
    },
    {"icon": ImageUtils.bedAssignIcon, "title": StringUtils.bedManagement},
    {"icon": ImageUtils.notificationIcon, "title": StringUtils.RegularUpdate},
    {"icon": ImageUtils.settingIcon, "title": StringUtils.setting},

  ];
}
