// To parse this JSON data, do
//
//     final ordersResponse = ordersResponseFromJson(jsonString);

import 'dart:convert';

OrdersResponse ordersResponseFromJson(String str) =>
    OrdersResponse.fromJson(json.decode(str));

String ordersResponseToJson(OrdersResponse data) => json.encode(data.toJson());

class OrdersResponse {
  OrdersResponse({
    required this.success,
    required this.message,
    this.data,
    required this.code,
  });

  bool success;
  String message;
  Data? data;
  int code;

  factory OrdersResponse.fromJson(Map<String, dynamic> json) => OrdersResponse(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
        "code": code,
      };
}

class Data {
  Data({
    this.orders,
  });

  Orders? orders;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        orders: Orders.fromJson(json["orders"]),
      );

  Map<String, dynamic> toJson() => {
        "orders": orders?.toJson(),
      };
}

class Orders {
  Orders({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int? currentPage;
  List<Datum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  Datum({
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
  });

  int? id;
  String? orderCode;
  int? customerId;
  int? restaurantId;
  int? paymentMethodId;
  int? deliveryManId;
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
  dynamic note;
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        orderCode: json["order_code"],
        customerId: json["customer_id"],
        restaurantId: json["restaurant_id"],
        paymentMethodId: json["payment_method_id"],
        deliveryManId:
            json["delivery_man_id"] == null ? null : json["delivery_man_id"],
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_code": orderCode,
        "customer_id": customerId,
        "restaurant_id": restaurantId,
        "payment_method_id": paymentMethodId,
        "delivery_man_id": deliveryManId == null ? null : deliveryManId,
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
            "${deliveryDate?.year.toString().padLeft(4, '0')}-${deliveryDate?.month.toString().padLeft(2, '0')}-${deliveryDate?.day.toString().padLeft(2, '0')}",
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
  });

  int? id;
  String? firstName;
  String? lastName;
  String? email;
  int? roleId;
  int? registerType;
  dynamic socialAuthId;
  String? phone;
  String? profilePhotoPath;
  dynamic country;
  dynamic state;
  dynamic city;
  dynamic postalCode;
  dynamic address;
  dynamic emailVerifiedAt;
  dynamic emailVerificationCode;
  String? phoneVerificationCode;
  int? emailVerificationStatus;
  int? phoneVerificationStatus;
  int? status;
  int? moduleId;
  dynamic latitude;
  dynamic longitude;
  String? balance;
  dynamic deliveryCommission;
  dynamic iban;
  dynamic lastWithdraw;
  String? nif;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? profilePhotoFullPath;
  String? balanceInEuro;

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
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.imageFullPath,
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
  dynamic email;
  String? shortDescription;
  String? description;
  String? iban;
  String? address;
  String? latitude;
  String? longitude;
  String? city;
  String? state;
  dynamic postalCode;
  String? country;
  String? featuredImage;
  dynamic facebookLink;
  dynamic youtubeLink;
  dynamic twitterLink;
  dynamic instagramLink;
  dynamic websiteLink;
  String? adminCommission;
  int? status;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? imageFullPath;

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
        status: json["status"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        imageFullPath: json["image_full_path"],
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
        "status": status,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "image_full_path": imageFullPath,
      };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"] == null ? null : json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "label": label,
        "active": active,
      };
}
