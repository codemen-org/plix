import 'dart:convert';

ShopTimeSlotResponse shopTimeSlotResponseFromJson(String str) =>
    ShopTimeSlotResponse.fromJson(json.decode(str));

String shopTimeSlotResponseToJson(ShopTimeSlotResponse data) =>
    json.encode(data.toJson());

class ShopTimeSlotResponse {
  ShopTimeSlotResponse({
    required this.success,
    required this.message,
    this.data,
    required this.code,
  });

  bool success;
  String message;
  Data? data;
  int code;

  factory ShopTimeSlotResponse.fromJson(Map<String, dynamic> json) =>
      ShopTimeSlotResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
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
    required this.dates,
  });

  Map<String, List<DateSlot>> dates;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        dates: Map.from(json["dates"]).map((k, v) =>
            MapEntry<String, List<DateSlot>>(
                k, List<DateSlot>.from(v.map((x) => DateSlot.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "dates": Map.from(dates).map((k, v) => MapEntry<String, dynamic>(
            k, List<dynamic>.from(v.map((x) => x.toJson())))),
      };
}

class DateSlot {
  DateSlot({
    required this.slotValue,
    required this.slotDisplay,
    required this.status,
  });

  String slotValue;
  String slotDisplay;
  bool status;

  factory DateSlot.fromJson(Map<String, dynamic> json) => DateSlot(
        slotValue: json["slot_value"],
        slotDisplay: json["slot_display"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "slot_value": slotValue,
        "slot_display": slotDisplay,
        "status": status,
      };
}
