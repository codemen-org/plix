// To parse this JSON data, do
//
//     final addOneList = addOneListFromJson(jsonString);

import 'dart:convert';

AddOneList addOneListFromJson(String str) =>
    AddOneList.fromJson(json.decode(str));

String addOneListToJson(AddOneList data) => json.encode(data.toJson());

class AddOneList {
  AddOneList({
    required this.addons,
  });

  final List<Addon> addons;

  factory AddOneList.fromJson(Map<String, dynamic> json) => AddOneList(
        addons: List<Addon>.from(json["addons"].map((x) => Addon.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "addons": List<dynamic>.from(addons.map((x) => x.toJson())),
      };
}

class Addon {
  Addon({
    this.id,
    this.restaurantFoodId,
    this.name,
    this.price,
    this.icon,
    this.description,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.imageFullPath,
    this.priceInEuro,
  });

  final int? id;
  final int? restaurantFoodId;
  final String? name;
  final String? price;
  final String? icon;
  final String? description;
  final dynamic? deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? imageFullPath;
  final String? priceInEuro;

  factory Addon.fromJson(Map<String, dynamic> json) => Addon(
        id: json["id"] == null ? null : json["id"],
        restaurantFoodId: json["restaurant_food_id"] == null
            ? null
            : json["restaurant_food_id"],
        name: json["name"] == null ? null : json["name"],
        price: json["price"] == null ? null : json["price"],
        icon: json["icon"] == null ? null : json["icon"],
        description: json["description"] == null ? null : json["description"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        imageFullPath:
            json["image_full_path"] == null ? null : json["image_full_path"],
        priceInEuro:
            json["price_in_euro"] == null ? null : json["price_in_euro"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "restaurant_food_id":
            restaurantFoodId == null ? null : restaurantFoodId,
        "name": name == null ? null : name,
        "price": price == null ? null : price,
        "icon": icon == null ? null : icon,
        "description": description == null ? null : description,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "image_full_path": imageFullPath == null ? null : imageFullPath,
        "price_in_euro": priceInEuro == null ? null : priceInEuro,
      };
}
