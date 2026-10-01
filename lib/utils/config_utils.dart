class ConfigUtils {
  static const String hospitalSku = "f9f46152-3d87-4ec0-a000-ba3b333243a3";
  static const String domainUrl = "https://dev.doctorhealix.com/";
  static const String baseUrl = "${domainUrl}api/";
  static const String imagePath = "${domainUrl}storage/";
  static const String pusherHost = "dev.doctorhealix.com";
  static const String sosUrl = "${baseUrl}patient/emergency";
  static const String googleClientId = "581082696138-294rtk0rod85c02gdqdb2ei6gmondl79.apps.googleusercontent.com";
  static const String newsletterShareUrl = "${domainUrl}${hospitalSku}/newsletters/";
  static const String defaultAiBaseUrl = "http://10.0.2.2:3000";
  static String get aiBaseUrl => defaultAiBaseUrl;
}