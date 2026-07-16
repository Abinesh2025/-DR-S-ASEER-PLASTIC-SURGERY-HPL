import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/medicine/medicine_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class MedicineController extends GetxController {
  RxList<MedicineModel> medicineList = <MedicineModel>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMedicines();
  }

  void fetchMedicines() {
    isLoading.value = true;
    StringUtils.client
        .getMedicines(PreferenceUtils.getStringValue("token"))
        .then((value) {
      print("Medicine API Response: Success=${value.success}, Message=${value.message}");
      if (value.data != null) {
         print("Medicine API Data Length: ${value.data!.length}");
         value.data!.forEach((m) => print("Medicine: ${m.name}, Price: ${m.sellingPrice}"));
      } else {
         print("Medicine API Data is NULL");
      }

      if (value.success == true && value.data != null) {
        medicineList.value = value.data!;
      } else {
        print("Medicine API Failed or Data Empty");
      }
      isLoading.value = false;
    }).onError((DioException error, stackTrace) {
      isLoading.value = false;
      print("Medicine API Error: $error");
      CheckSocketException.checkSocketException(error);
    });
  }
}
