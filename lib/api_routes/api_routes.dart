class ApiRoutes {
  static String preProductionUrl = "http://13.201.65.104/";
  static String baseUrl = preProductionUrl;

  static String mobileNumberApi = "${baseUrl}api/users/phone-login";
  static String verifyOtp = "${baseUrl}api/users/otp-verify";
  static String bannerApi = "${baseUrl}api/banners";
  static String subCategories = "${baseUrl}api/sub-categories?categoryID=";
  static String allProducts = "${baseUrl}api/products?subCategoryID=";
  static String allProductsDetails = "${baseUrl}api/products?id=";
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
  static String addToCartApi = "${baseUrl}api/cart/";
  static String addToCartFetchApi = "${baseUrl}api/cart/your-cart";
  static String deleteAddToCartApi = "${baseUrl}api/cart/";
  static String editAddToCartApi = "${baseUrl}api/cart/edit/";
}