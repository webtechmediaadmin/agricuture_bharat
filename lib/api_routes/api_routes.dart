class ApiRoutes {
  static String preProductionUrl = "http://13.201.65.104/";
  static String baseUrl = preProductionUrl;

  static String mobileNumberApi = "${baseUrl}users/phone-login";
  static String verifyOtp = "${baseUrl}users/verify-otp";
  static String bannerApi = "${baseUrl}api/banners";
  static String subCategories = "${baseUrl}sub-categories?id=";
  static String userDetailsPage = "${baseUrl}users/name-email";
  static String verifyEmail = "${baseUrl}users/mailing-otp";
  static String userDetailsFetch = "${baseUrl}users/my-profile";
  static String pinCodeData = "${baseUrl}city?pincode=";
  static String editProfileData = "${baseUrl}users/edit-profile";
  static String categories = "${baseUrl}api/categories";
  static String subCategoriesFetch = baseUrl;
  static String subCategoriesRelated= "${baseUrl}sub-categories/related/";
  static String enquiry= "${baseUrl}enquiry/";
  static String notificationApi = "${baseUrl}notifications/admin/get";
}