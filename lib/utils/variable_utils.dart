import 'package:get/get.dart';

class VariableUtils extends GetxController {
  static RxString firstName = "".obs;
  static RxString lastName = "".obs;
  static RxString email = "".obs;
  static RxString imageUrl = "".obs;
  static RxString phoneNo = "".obs;
  static RxString regionCode = "".obs;
  static RxString address = "".obs;
  static RxString city = "".obs;
  static RxString pincode = "".obs;
  static RxString patientId = "".obs;
  static RxString userId = "".obs;
  static RxString token = "".obs;
  ///super admin setting
  static RxString appName = "".obs;
  static RxString appLogo = "".obs;
  static RxString favicon = "".obs;
  static RxString planExpire = "".obs;
  static RxString defaultCountryCode = "".obs;
  static RxString phone = "".obs;
  static RxString currentCurrency = "".obs;
  static RxString language = "".obs;

  ///admin setting
  static RxString adminAppName = "".obs;
  static RxString adminAppLogo = "".obs;
  static RxString adminFavicon = "".obs;
  static RxString companyName = "".obs;
  static RxString hospitalEmail = "".obs;
  static RxString prefixCountryCode = "".obs;
  static RxString hospitalPhone = "".obs;
  static RxString enableGoogleRecaptcha = "".obs;

  static void reset() {
    firstName.value = "";
    lastName.value = "";
    email.value = "";
    imageUrl.value = "";
    phoneNo.value = "";
    regionCode.value = "";
    address.value = "";
    city.value = "";
    pincode.value = "";
    patientId.value = "";
    userId.value = "";

    ///super admin setting
    appName.value = "";
    appLogo.value = "";
    favicon.value = "";
    planExpire.value = "";
    defaultCountryCode.value = "";
    phone.value = "";
    currentCurrency.value = "";
    language.value = "";

    ///admin setting
    adminAppName.value = "";
    adminAppLogo.value = "";
    adminFavicon.value = "";
    companyName.value = "";
    hospitalEmail.value = "";
    prefixCountryCode.value = "";
    hospitalPhone.value = "";
    enableGoogleRecaptcha.value = "";
  }
}