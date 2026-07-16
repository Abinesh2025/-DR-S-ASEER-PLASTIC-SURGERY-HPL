import 'package:get/get.dart';

class AdminAppointmentController extends GetxController {
  RxList appointmentStatus = ["All", "Pending", "Cancelled", "Confirmed"].obs;
  RxInt currentIndex = 0.obs;
}
