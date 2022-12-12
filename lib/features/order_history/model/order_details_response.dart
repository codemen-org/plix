// To parse this JSON data, do
//
//     final orderDetailsResponse = orderDetailsResponseFromJson(jsonString);

import 'dart:convert';

OrderDetailsResponse orderDetailsResponseFromJson(String str) =>
    OrderDetailsResponse.fromJson(json.decode(str));

String orderDetailsResponseToJson(OrderDetailsResponse data) =>
    json.encode(data.toJson());

class OrderDetailsResponse {
  OrderDetailsResponse({
    required this.success,
    required this.message,
    this.data,
    required this.code,
  });

  bool success;
  String message;
  Data? data;
  int code;

  factory OrderDetailsResponse.fromJson(Map<String, dynamic> json) =>
      OrderDetailsResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? null : data!.toJson(),
        "code": code,
      };
}

class Data {
  Data({
    this.order,
  });

  Order? order;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        order: Order.fromJson(json["order"]),
      );

  Map<String, dynamic> toJson() => {
        "order": order == null ? null : order!.toJson(),
      };
}

class Order {
  Order({
    this.id,
    this.orderCode,
    this.customerId,
    this.restaurantId,
    this.paymentMethodId,
    this.deliveryManId,
    this.distance,
    this.duration,
    this.latitude,
    this.longitude,
    this.deliveryAddress,
    this.contactNumber,
    this.itemTotalQuantity,
    this.itemTotalPrice,
    this.deliveryCharge,
    this.subTotalPrice,
    this.discountAmount,
    this.totalPrice,
    this.paidAmount,
    this.expectedDeliveryTime,
    this.deliveryDate,
    this.timeSlot,
    this.pickupTimeSlot,
    this.confirmedDeliveryTime,
    this.note,
    this.paymentStatus,
    this.status,
    this.deliveryStatus,
    this.adminIncome,
    this.shopIncome,
    this.deliveryIncome,
    this.expiresAt,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.statusText,
    this.deliveryStatusText,
    this.pickupDateTime,
    this.calculatedPredictedTime,
    this.deliveredat,
    this.paymentStatusText,
    this.totalPriceInEuro,
    this.subTotalPriceInEuro,
    this.itemTotalPriceInEuro,
    this.deliveryChargeInEuro,
    this.discountAmountInEuro,
    this.paidAmountInEuro,
    this.adminIncomeInEuro,
    this.shopIncomeInEuro,
    this.deliveryIncomeInEuro,
    this.restaurant,
    this.customer,
    this.deliveryMan,
    this.orderItems,
    this.statusHistories,
    this.paymentMethod,
    this.order_status_history,
    this.order_placed,
  });

  int? id;
  String? orderCode;
  int? customerId;
  int? restaurantId;
  int? paymentMethodId;
  dynamic deliveryManId;
  String? distance;
  int? duration;
  String? latitude;
  String? longitude;
  String? deliveryAddress;
  String? contactNumber;
  int? itemTotalQuantity;
  String? itemTotalPrice;
  String? deliveryCharge;
  String? subTotalPrice;
  String? discountAmount;
  String? totalPrice;
  String? paidAmount;
  String? expectedDeliveryTime;
  DateTime? deliveryDate;
  String? timeSlot;
  String? pickupTimeSlot;
  dynamic confirmedDeliveryTime;
  String? note;
  int? paymentStatus;
  int? status;
  int? deliveryStatus;
  String? adminIncome;
  String? shopIncome;
  String? deliveryIncome;
  dynamic expiresAt;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? statusText;
  String? deliveryStatusText;
  String? pickupDateTime;
  String? calculatedPredictedTime;
  String? deliveredat;
  String? paymentStatusText;
  String? totalPriceInEuro;
  String? subTotalPriceInEuro;
  String? itemTotalPriceInEuro;
  String? deliveryChargeInEuro;
  String? discountAmountInEuro;
  String? paidAmountInEuro;
  String? adminIncomeInEuro;
  String? shopIncomeInEuro;
  String? deliveryIncomeInEuro;
  Restaurant? restaurant;
  Customer? customer;
  Customer? deliveryMan;
  List<OrderItem>? orderItems;
  List<StatusHistory>? statusHistories;
  PaymentMethod? paymentMethod;
  List<OrderStatus>? order_status_history;
  String? order_placed;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        orderCode: json["order_code"],
        customerId: json["customer_id"],
        restaurantId: json["restaurant_id"],
        paymentMethodId: json["payment_method_id"],
        deliveryManId: json["delivery_man_id"],
        distance: json["distance"],
        duration: json["duration"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        deliveryAddress: json["delivery_address"],
        contactNumber: json["contact_number"],
        itemTotalQuantity: json["item_total_quantity"],
        itemTotalPrice: json["item_total_price"],
        deliveryCharge: json["delivery_charge"],
        subTotalPrice: json["sub_total_price"],
        discountAmount: json["discount_amount"],
        totalPrice: json["total_price"],
        paidAmount: json["paid_amount"],
        expectedDeliveryTime: json["expected_delivery_time"],
        deliveryDate: DateTime.parse(json["delivery_date"]),
        timeSlot: json["time_slot"],
        pickupTimeSlot: json["pickup_time_slot"],
        confirmedDeliveryTime: json["confirmed_delivery_time"],
        note: json["note"],
        paymentStatus: json["payment_status"],
        status: json["status"],
        deliveryStatus: json["delivery_status"],
        adminIncome: json["admin_income"],
        shopIncome: json["shop_income"],
        deliveryIncome: json["delivery_income"],
        expiresAt: json["expires_at"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        statusText: json["status_text"],
        deliveryStatusText: json["delivery_status_text"],
        pickupDateTime: json["pickup_date_time"],
        calculatedPredictedTime: json["calculated_predicted_time"],
        deliveredat: json['delivered_at'],
        paymentStatusText: json["payment_status_text"],
        totalPriceInEuro: json["total_price_in_euro"],
        subTotalPriceInEuro: json["sub_total_price_in_euro"],
        itemTotalPriceInEuro: json["item_total_price_in_euro"],
        deliveryChargeInEuro: json["delivery_charge_in_euro"],
        discountAmountInEuro: json["discount_amount_in_euro"],
        paidAmountInEuro: json["paid_amount_in_euro"],
        adminIncomeInEuro: json["admin_income_in_euro"],
        shopIncomeInEuro: json["shop_income_in_euro"],
        deliveryIncomeInEuro: json["delivery_income_in_euro"],
        restaurant: Restaurant.fromJson(json["restaurant"]),
        customer: Customer.fromJson(json["customer"]),
        deliveryMan: Customer.fromJson(json["customer"]),
        orderItems: List<OrderItem>.from(
            json["order_items"].map((x) => OrderItem.fromJson(x))),
        statusHistories: List<StatusHistory>.from(
            json["status_histories"].map((x) => StatusHistory.fromJson(x))),
        paymentMethod: PaymentMethod.fromJson(json["payment_method"]),
        order_status_history: List<OrderStatus>.from(
            json["order_status_history"].map((x) => OrderStatus.fromJson(x))),
        order_placed: json["order_placed"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_code": orderCode,
        "customer_id": customerId,
        "restaurant_id": restaurantId,
        "payment_method_id": paymentMethodId,
        "delivery_man_id": deliveryManId,
        "distance": distance,
        "duration": duration,
        "latitude": latitude,
        "longitude": longitude,
        "delivery_address": deliveryAddress,
        "contact_number": contactNumber,
        "item_total_quantity": itemTotalQuantity,
        "item_total_price": itemTotalPrice,
        "delivery_charge": deliveryCharge,
        "sub_total_price": subTotalPrice,
        "discount_amount": discountAmount,
        "total_price": totalPrice,
        "paid_amount": paidAmount,
        "expected_delivery_time": expectedDeliveryTime,
        "delivery_date":
            "${deliveryDate!.year.toString().padLeft(4, '0')}-${deliveryDate!.month.toString().padLeft(2, '0')}-${deliveryDate!.day.toString().padLeft(2, '0')}",
        "time_slot": timeSlot,
        "pickup_time_slot": pickupTimeSlot,
        "confirmed_delivery_time": confirmedDeliveryTime,
        "note": note,
        "payment_status": paymentStatus,
        "status": status,
        "delivery_status": deliveryStatus,
        "admin_income": adminIncome,
        "shop_income": shopIncome,
        "delivery_income": deliveryIncome,
        "expires_at": expiresAt,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "status_text": statusText,
        "delivery_status_text": deliveryStatusText,
        "pickup_date_time": pickupDateTime,
        "calculated_predicted_time": calculatedPredictedTime,
        "delivered_at": deliveredat,
        "payment_status_text": paymentStatusText,
        "total_price_in_euro": totalPriceInEuro,
        "sub_total_price_in_euro": subTotalPriceInEuro,
        "item_total_price_in_euro": itemTotalPriceInEuro,
        "delivery_charge_in_euro": deliveryChargeInEuro,
        "discount_amount_in_euro": discountAmountInEuro,
        "paid_amount_in_euro": paidAmountInEuro,
        "admin_income_in_euro": adminIncomeInEuro,
        "shop_income_in_euro": shopIncomeInEuro,
        "delivery_income_in_euro": deliveryIncomeInEuro,
        "restaurant": restaurant?.toJson(),
        "customer": customer?.toJson(),
        "delivery_man": deliveryMan?.toJson(),
        "order_items": List<dynamic>.from(orderItems!.map((x) => x.toJson())),
        "status_histories":
            List<dynamic>.from(statusHistories!.map((x) => x.toJson())),
        "payment_method": paymentMethod!.toJson(),
        "order_status_history":
            List<dynamic>.from(order_status_history!.map((x) => x.toJson)),
        "order_placed": order_placed
      };
}

OrderStatus orderStatusFromJson(String str) =>
    OrderStatus.fromJson(json.decode(str));

String orderStatusToJson(OrderStatus data) => json.encode(data.toJson());

class OrderStatus {
  OrderStatus({
    this.orderStatus,
    this.comment,
    this.deliveryStatus,
    this.createdAt,
  });

  int? orderStatus;
  dynamic comment;
  dynamic deliveryStatus;
  String? createdAt;

  factory OrderStatus.fromJson(Map<String, dynamic> json) => OrderStatus(
        orderStatus: json["order_status"] == null ? null : json["order_status"],
        comment: json["comment"],
        deliveryStatus: json["delivery_status"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "order_status": orderStatus == null ? null : orderStatus,
        "comment": comment,
        "delivery_status": deliveryStatus,
        "created_at": createdAt == null ? null : createdAt,
      };
}

class Customer {
  Customer({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.roleId,
    this.registerType,
    this.socialAuthId,
    this.phone,
    this.profilePhotoPath,
    this.country,
    this.state,
    this.city,
    this.postalCode,
    this.address,
    this.emailVerifiedAt,
    this.emailVerificationCode,
    this.phoneVerificationCode,
    this.emailVerificationStatus,
    this.phoneVerificationStatus,
    this.status,
    this.moduleId,
    this.latitude,
    this.longitude,
    this.balance,
    this.deliveryCommission,
    this.iban,
    this.lastWithdraw,
    this.nif,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.profilePhotoFullPath,
    this.balanceInEuro,
    this.rating,
    this.defaultDeliveryAddress,
  });

  int? id;
  String? firstName;
  String? lastName;
  String? email;
  int? roleId;
  int? registerType;
  dynamic socialAuthId;
  String? phone;
  dynamic profilePhotoPath;
  String? country;
  String? state;
  String? city;
  dynamic postalCode;
  String? address;
  dynamic emailVerifiedAt;
  dynamic emailVerificationCode;
  String? phoneVerificationCode;
  int? emailVerificationStatus;
  int? phoneVerificationStatus;
  int? status;
  int? moduleId;
  String? latitude;
  String? longitude;
  String? balance;
  dynamic deliveryCommission;
  dynamic iban;
  dynamic lastWithdraw;
  dynamic nif;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? profilePhotoFullPath;
  String? balanceInEuro;
  String? rating;
  DefaultDeliveryAddress? defaultDeliveryAddress;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        roleId: json["role_id"],
        registerType: json["register_type"],
        socialAuthId: json["social_auth_id"],
        phone: json["phone"],
        profilePhotoPath: json["profile_photo_path"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        postalCode: json["postal_code"],
        address: json["address"],
        emailVerifiedAt: json["email_verified_at"],
        emailVerificationCode: json["email_verification_code"],
        phoneVerificationCode: json["phone_verification_code"],
        emailVerificationStatus: json["email_verification_status"],
        phoneVerificationStatus: json["phone_verification_status"],
        status: json["status"],
        moduleId: json["module_id"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        balance: json["balance"],
        deliveryCommission: json["delivery_commission"],
        iban: json["iban"],
        lastWithdraw: json["last_withdraw"],
        nif: json["nif"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        profilePhotoFullPath: json["profile_photo_full_path"],
        balanceInEuro: json["balance_in_euro"],
        rating: json["rating"],
        defaultDeliveryAddress:
            DefaultDeliveryAddress.fromJson(json["default_delivery_address"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "role_id": roleId,
        "register_type": registerType,
        "social_auth_id": socialAuthId,
        "phone": phone,
        "profile_photo_path": profilePhotoPath,
        "country": country,
        "state": state,
        "city": city,
        "postal_code": postalCode,
        "address": address,
        "email_verified_at": emailVerifiedAt,
        "email_verification_code": emailVerificationCode,
        "phone_verification_code": phoneVerificationCode,
        "email_verification_status": emailVerificationStatus,
        "phone_verification_status": phoneVerificationStatus,
        "status": status,
        "module_id": moduleId,
        "latitude": latitude,
        "longitude": longitude,
        "balance": balance,
        "delivery_commission": deliveryCommission,
        "iban": iban,
        "last_withdraw": lastWithdraw,
        "nif": nif,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "profile_photo_full_path": profilePhotoFullPath,
        "balance_in_euro": balanceInEuro,
        "rating": rating,
        "default_delivery_address": defaultDeliveryAddress?.toJson(),
      };
}

class DefaultDeliveryAddress {
  DefaultDeliveryAddress({
    this.id,
    this.userId,
    this.addressName,
    this.isDefault,
    this.phone,
    this.country,
    this.state,
    this.city,
    this.postalCode,
    this.address,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  String? addressName;
  int? isDefault;
  String? phone;
  String? country;
  String? state;
  String? city;
  String? postalCode;
  String? address;
  String? latitude;
  String? longitude;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory DefaultDeliveryAddress.fromJson(Map<String, dynamic> json) =>
      DefaultDeliveryAddress(
        id: json["id"],
        userId: json["user_id"],
        addressName: json["address_name"],
        isDefault: json["is_default"],
        phone: json["phone"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        postalCode: json["postal_code"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "address_name": addressName,
        "is_default": isDefault,
        "phone": phone,
        "country": country,
        "state": state,
        "city": city,
        "postal_code": postalCode,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class OrderItem {
  OrderItem({
    this.id,
    this.orderId,
    this.restaurantFoodId,
    this.foodOptionId,
    this.name,
    this.unitPrice,
    this.quantity,
    this.discount,
    this.specialRequest,
    this.unitPriceInEuro,
    this.food,
    this.option,
    this.orderAddons,
  });

  int? id;
  int? orderId;
  int? restaurantFoodId;
  int? foodOptionId;
  String? name;
  String? unitPrice;
  int? quantity;
  String? discount;
  dynamic specialRequest;
  String? unitPriceInEuro;
  Food? food;
  Option? option;
  List<dynamic>? orderAddons;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["id"],
        orderId: json["order_id"],
        restaurantFoodId: json["restaurant_food_id"],
        foodOptionId: json["food_option_id"],
        name: json["name"],
        unitPrice: json["unit_price"],
        quantity: json["quantity"],
        discount: json["discount"],
        specialRequest: json["special_request"],
        unitPriceInEuro: json["unit_price_in_euro"],
        food: Food.fromJson(json["food"]),
        option: Option.fromJson(json["option"]),
        orderAddons: List<dynamic>.from(json["order_addons"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "restaurant_food_id": restaurantFoodId,
        "food_option_id": foodOptionId,
        "name": name,
        "unit_price": unitPrice,
        "quantity": quantity,
        "discount": discount,
        "special_request": specialRequest,
        "unit_price_in_euro": unitPriceInEuro,
        "food": food?.toJson(),
        "option": option?.toJson(),
        "order_addons": List<dynamic>.from(orderAddons!.map((x) => x)),
      };
}

class Food {
  Food({
    this.id,
    this.restaurantId,
    this.foodCategoryId,
    this.cuisineId,
    this.name,
    this.slug,
    this.description,
    this.featuredImage,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.shortDescription,
    this.price,
    this.imageFullPath,
    this.priceInEuro,
  });

  int? id;
  int? restaurantId;
  int? foodCategoryId;
  int? cuisineId;
  String? name;
  String? slug;
  String? description;
  String? featuredImage;
  int? status;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? shortDescription;
  String? price;
  String? imageFullPath;
  String? priceInEuro;

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        id: json["id"],
        restaurantId: json["restaurant_id"],
        foodCategoryId: json["food_category_id"],
        cuisineId: json["cuisine_id"],
        name: json["name"],
        slug: json["slug"],
        description: json["description"],
        featuredImage: json["featured_image"],
        status: json["status"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        shortDescription: json["short_description"],
        price: json["price"],
        imageFullPath: json["image_full_path"],
        priceInEuro: json["price_in_euro"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "restaurant_id": restaurantId,
        "food_category_id": foodCategoryId,
        "cuisine_id": cuisineId,
        "name": name,
        "slug": slug,
        "description": description,
        "featured_image": featuredImage,
        "status": status,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "short_description": shortDescription,
        "price": price,
        "image_full_path": imageFullPath,
        "price_in_euro": priceInEuro,
      };
}

class Option {
  Option({
    this.id,
    this.restaurantId,
    this.restaurantFoodId,
    this.name,
    this.price,
    this.discount,
    this.isDefault,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.priceInEuro,
  });

  int? id;
  int? restaurantId;
  int? restaurantFoodId;
  String? name;
  String? price;
  String? discount;
  int? isDefault;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? priceInEuro;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["id"],
        restaurantId: json["restaurant_id"],
        restaurantFoodId: json["restaurant_food_id"],
        name: json["name"],
        price: json["price"],
        discount: json["discount"],
        isDefault: json["is_default"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        priceInEuro: json["price_in_euro"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "restaurant_id": restaurantId,
        "restaurant_food_id": restaurantFoodId,
        "name": name,
        "price": price,
        "discount": discount,
        "is_default": isDefault,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "price_in_euro": priceInEuro,
      };
}

class PaymentMethod {
  PaymentMethod({
    this.id,
    this.name,
    this.icon,
    this.status,
  });

  int? id;
  String? name;
  String? icon;
  int? status;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        id: json["id"],
        name: json["name"],
        icon: json["icon"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
        "status": status,
      };
}

class Restaurant {
  Restaurant({
    this.id,
    this.name,
    this.slug,
    this.restaurantGroupId,
    this.userId,
    this.managerId,
    this.restaurantCategoryId,
    this.isTrending,
    this.isFeatured,
    this.phone,
    this.email,
    this.shortDescription,
    this.description,
    this.iban,
    this.address,
    this.latitude,
    this.longitude,
    this.city,
    this.state,
    this.postalCode,
    this.country,
    this.featuredImage,
    this.facebookLink,
    this.youtubeLink,
    this.twitterLink,
    this.instagramLink,
    this.websiteLink,
    this.adminCommission,
    this.customerRange,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.imageFullPath,
    this.rating,
  });

  int? id;
  String? name;
  String? slug;
  int? restaurantGroupId;
  int? userId;
  dynamic managerId;
  int? restaurantCategoryId;
  int? isTrending;
  int? isFeatured;
  String? phone;
  String? email;
  dynamic shortDescription;
  dynamic description;
  String? iban;
  String? address;
  String? latitude;
  String? longitude;
  String? city;
  dynamic state;
  String? postalCode;
  dynamic country;
  String? featuredImage;
  dynamic facebookLink;
  dynamic youtubeLink;
  dynamic twitterLink;
  dynamic instagramLink;
  dynamic websiteLink;
  String? adminCommission;
  dynamic customerRange;
  int? status;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? imageFullPath;
  String? rating;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        restaurantGroupId: json["restaurant_group_id"],
        userId: json["user_id"],
        managerId: json["manager_id"],
        restaurantCategoryId: json["restaurant_category_id"],
        isTrending: json["is_trending"],
        isFeatured: json["is_featured"],
        phone: json["phone"],
        email: json["email"],
        shortDescription: json["short_description"],
        description: json["description"],
        iban: json["iban"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        city: json["city"],
        state: json["state"],
        postalCode: json["postal_code"],
        country: json["country"],
        featuredImage: json["featured_image"],
        facebookLink: json["facebook_link"],
        youtubeLink: json["youtube_link"],
        twitterLink: json["twitter_link"],
        instagramLink: json["instagram_link"],
        websiteLink: json["website_link"],
        adminCommission: json["admin_commission"],
        customerRange: json["customer_range"],
        status: json["status"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        imageFullPath: json["image_full_path"],
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "restaurant_group_id": restaurantGroupId,
        "user_id": userId,
        "manager_id": managerId,
        "restaurant_category_id": restaurantCategoryId,
        "is_trending": isTrending,
        "is_featured": isFeatured,
        "phone": phone,
        "email": email,
        "short_description": shortDescription,
        "description": description,
        "iban": iban,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "city": city,
        "state": state,
        "postal_code": postalCode,
        "country": country,
        "featured_image": featuredImage,
        "facebook_link": facebookLink,
        "youtube_link": youtubeLink,
        "twitter_link": twitterLink,
        "instagram_link": instagramLink,
        "website_link": websiteLink,
        "admin_commission": adminCommission,
        "customer_range": customerRange,
        "status": status,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "image_full_path": imageFullPath,
        "rating": rating,
      };
}

class StatusHistory {
  StatusHistory({
    this.id,
    this.orderId,
    this.createdBy,
    this.orderStatus,
    this.deliveryStatus,
    this.comment,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? orderId;
  int? createdBy;
  int? orderStatus;
  dynamic deliveryStatus;
  dynamic comment;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory StatusHistory.fromJson(Map<String, dynamic> json) => StatusHistory(
        id: json["id"],
        orderId: json["order_id"],
        createdBy: json["created_by"],
        orderStatus: json["order_status"],
        deliveryStatus: json["delivery_status"],
        comment: json["comment"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "created_by": createdBy,
        "order_status": orderStatus,
        "delivery_status": deliveryStatus,
        "comment": comment,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
