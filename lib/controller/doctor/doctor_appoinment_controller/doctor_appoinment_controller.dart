import 'package:get/get.dart';

class DoctorAppointmentController extends GetxController {
  RxList appointmentStatus =
      ["Upcoming", "Confirmed", "Check In", "Completed", "Cancelled"].obs;
  RxInt currentIndex = 0.obs;
}
