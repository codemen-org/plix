// ignore_for_file: constant_identifier_names
//live url
//const String url = "";
//test local
//const String url = "http://2961-118-179-44-20.ngrok.io";
//staging
const String url = "https://applix.squaredsys.com";

class NetworkConstants {
  static const ACCEPT = "Accept";
  static const APP_KEY = "App-Key";
  static const ACCEPT_LANGUAGE = "Accept-Language";
  static const ACCEPT_LANGUAGE_VALUE = "pt";
  static const APP_KEY_VALUE =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiZWJ1eS1hbmRyb2lkLWFwcHMiLCJpYXQiOjE1NzIzNzI3Nzh9.X1qxpv6WDUP";
  static const ACCEPT_TYPE = "application/json";
  static const AUTHORIZATION = "Authorization";
  static const CONTENT_TYPE = "content-Type";
}

class PaymentGateway {
  static String gateway(String orderId) =>
      "https://demo.vivapayments.com/web/checkout?ref={$orderId}";
}

class Endpoints {
  static String postlogin() => "/api/login";
  static String postSignUp() => "/api/signup";
  static String postVerify() => "/api/verify-code";
  static String getLogout() => "/api/logout";
  static String getSlider() => "/api/sliders";
  static String getShopProductCategory() => "/api/product-categories";
  static String getShopProducts() => "/api/products";
  static String postForgotPassword() => "/api/forgot-password";
  static String postResetPassword() => "/api/reset-password";
  static String getProductDetail(String slug) => "/api/products/$slug";
  static String getAllProductsByCategory(String slug) =>
      "/api/product-categories/$slug/products";
  static String postCart() => "/api/carts";
  static String postSaveAddress() => "/api/save-delivery-address";
  static String postUpdateAddress() => "/api/save-delivery-address";
  static String getDeliveryAddress() => "/api/delivery-addresses";
  static String getSingleDeliveryAddress(int id) => "/api/delivery-address/$id";
  static String DeleteDeliveryAddress(int id) => "/api/delivery-addresses/$id";
  static String getTimeSlot() => "/api/time-slots";
  static String getProfleData() => "/api/profile";
  static String postUpdatePhone() => "/api/update-profile";
  static String postCreateOrder() => "/api/orders";
  static String getDefaultDelivaryAddress() => "/api/delivery-addresses";
  static String deleteAccount() => "/api/delete-account";
  static String resetPassword() => "/api/change-password";
  static String getOrderList() => "/api/orders";
  static String getOrderDetail(String orderID) => "/api/orders/$orderID";

  // static String getDashBoard() => "/api/shop-dashboard";
  // static String getShopList() => "/api/shop-list";
  // static String getDeliveryBoyList() => "/api/delivery-men";
  // static String getShopDeliveryBoyList() => "/api/shop-delivery-men";
  // static String postShopDeliveryBoyList() => "/api/assign-shop-delivery-men";
  // static String postShopAddress(String shop) => "/api/save-shop-contact/$shop";
  // static String postShopSchedule() => "/api/save-shop-schedule";
  // static String getShopSchedule(String shop) => "/api/shop-schedule/$shop";
  // static String postShopHolidays() => "/api/save-shop-holiday";
  // static String postShopHolidaysDelete() => "/api/delete-shop-holiday";
  // static String deleteShop(String shop) => "/api/shop-delete/$shop";
  // static String getAllShopHolidaysList(String shop) =>
  //     "/api/shop-holiday-list/$shop";
  // static String getShopHolidaysList(String shop,
  //         {int record = 10, int page = 1}) =>
  //     "/api/shop-holidays/$shop?number=$record&page=$page";
  // static String getOrders(String status, {int record = 10, int page = 1}) =>
  //     "/api/order-list/$status?number=$record&page=$page";
  // static String getBalanceRecord(String shop,
  //         {int record = 10, int page = 1}) =>
  //     "/api/shop-balance-record/$shop?number=$record&page=$page";
  // static String getItemList(String shop, {int record = 10, int page = 1}) =>
  //     "/api/shop-product/$shop?number=$record&page=$page";
  // static String postProductCategory() => "/api/shop-product-category-save";
  // static String postOrderStatus() => "/api/order/order-status";
  // static String getOrderDetails(String orderID) =>
  //     "/api/restaurant-order-details/$orderID";
  // static String getProductCategory(String restaurantId) =>
  //     "/api/shop-product-category/$restaurantId";
  // static String postProductCategorySave() => "/api/shop-product-category-save";

  // static String getShopSubCategoryPopUpList(String categoriesId) =>
  //     "/api/shop-subcategories/$categoriesId";
  // static String updateShopCategory() => "/api/shop-product-category-save";
  // static String deleteProductCategory(String productCatID) =>
  //     "/api/shop-product-category-delete/$productCatID";
  // static String getOrderCount() => "/api/shop-order-count";
  // static String postSaveShopBasic() => "/api/save-shop-basic";
  // static String getCustomerRange() => "/api/shop-customer-range";
  // static String postShopCustomerRange(String shop) =>
  //     "/api/save-shop-customer-range/$shop";
  // static String postProductBasic() => "/api/save-product-basic";
  // static String postProductPriching() => "/api/save-product-pricing";
  // static String postProductAddonSave() => "/api/product-addon-save";
  // static String postShowProductAddon(String foodId,
  //         {int record = 10, int page = 1}) =>
  //     "/api/product-addon-list/$foodId?number=$record&page=$page";
  // static String deleteProductAddon(String addonId) =>
  //     "/api/product-addon-delete/$addonId";
  // static String getShowShopProduct(String foodId) =>
  //     "/api/show-shop-product/$foodId";
  // static String getDashBoardOrderList({int record = 10, int page = 1}) =>
  //     "/api/shop-dashboard-order-list/?number=$record&page=$page";
  // static String postDeviceToken() => "/api/device-token";
  // static String postIssues() => "/api/register-issue";
  // static String deleteProductOptionPrice() => "/api/delete-product-pricing";
  // static String postOrderAcceptReject(String orderNO, int status) =>
  //     "/api/order/$orderNO/accept-reject/$status";

  // static String deleteProduct() => "/api/product-delete";
  // static String postOrderTimeUpdate() => "/api/order-time-update";
}
