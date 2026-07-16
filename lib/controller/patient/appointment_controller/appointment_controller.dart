import 'package:get/get.dart';

// class AppointmentController extends GetxController {
//   RxList appointmentStatus =
//       ["Past", "Upcoming", "Cancelled", "Confirmed", "Completed"].obs;
//   RxInt currentIndex = 0.obs;
// }
class AppointmentController extends GetxController {
  RxList appointmentStatus =
      ["Upcoming", "Confirmed", "Completed", "Cancelled"].obs;

  RxInt currentIndex = 0.obs; // 🔥 0 will now be Upcoming
}