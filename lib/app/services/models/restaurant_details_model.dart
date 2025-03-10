import 'package:yogo_pos/app/services/models/restaurant_model.dart';

import 'business_profile_model.dart';

class RestaurantDetailsModel {
  RestaurantDetailsModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.status,
    required this.role,
    required this.isVerified,
    required this.businessProfile,
    required this.restaurant,
    required this.lastLoginAt,
    required this.id,
  });

  final String name;
  final String email;
  final String phone;
  final String address;
  final String status;
  final String role;
  final bool isVerified;
  final BusinessProfileModel businessProfile;
  final RestaurantModel restaurant;
  final DateTime? lastLoginAt;
  final String id;

  factory RestaurantDetailsModel.fromJson(Map<String, dynamic> json) {
    return RestaurantDetailsModel(
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      phone: json["phone"] ?? "",
      address: json["address"] ?? "",
      status: json["status"] ?? "",
      role: json["role"] ?? "",
      isVerified: json["isVerified"] ?? false,
      businessProfile: BusinessProfileModel.fromJson(json["businessProfile"]),
      restaurant: RestaurantModel.fromJson(json["restaurant"]),
      lastLoginAt: DateTime.tryParse(json["lastLoginAt"] ?? ""),
      id: json["id"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "status": status,
        "role": role,
        "isVerified": isVerified,
        "businessProfile": businessProfile.toJson(),
        "restaurant": restaurant.toJson(),
        "lastLoginAt": lastLoginAt?.toIso8601String(),
        "id": id,
      };
}
