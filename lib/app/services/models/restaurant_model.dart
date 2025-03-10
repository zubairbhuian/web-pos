import 'package:yogo_pos/app/services/models/packaging_cost_model.dart';

class RestaurantModel {
  RestaurantModel({
    required this.name,
    required this.groceriesMeat,
    required this.email,
    required this.password,
    required this.phone,
    required this.address,
    required this.restaurantModelType,
    required this.logo,
    required this.id,
    required this.lightLogo,
    required this.darkLogo,
    required this.openingTime,
    required this.closingTime,
    required this.printLogo,
    required this.dineIn,
    required this.takeout,
    required this.olo,
    required this.pickup,
    required this.numberOfReceipt,
    required this.gratuityPersonCount,
    required this.packagingCostModel,
  });

  final String name;
  final bool groceriesMeat;
  final String email;
  final String password;
  final String phone;
  final String address;
  final String restaurantModelType;
  final String id;
  final String logo;
  final String lightLogo;
  final String darkLogo;
  final String closingTime;
  final String openingTime;
  final String printLogo;
  final bool dineIn;
  final bool olo;
  final bool pickup;
  final bool takeout;
  final int numberOfReceipt;
  final int gratuityPersonCount;
  final PackagingCostModel packagingCostModel;

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      name: json["name"] ?? "",
      groceriesMeat: json["groceriesMeat"] ?? false,
      email: json["email"] ?? "",
      password: json["password"] ?? "",
      phone: json["phone"] ?? "",
      address: json["address"] ?? "",
      restaurantModelType: json["restaurantModelType"] ?? "",
      logo: json["logo"] ?? "",
      id: json["id"] ?? "",
      lightLogo: json["lightLogo"] ?? "",
      darkLogo: json["darkLogo"] ?? "",
      openingTime: json["openingTime"] ?? "",
      closingTime: json["closingTime"] ?? "",
      printLogo: json["printLogo"] ?? "",
      dineIn: json["dineIn"] ?? false,
      olo: json["olo"] ?? false,
      pickup: json["pickup"] ?? false,
      takeout: json["takeout"] ?? false,
      numberOfReceipt: json["numberOfReceipt"] ?? 1,
      gratuityPersonCount: json["gratuityPersonCount"] ?? 3,
      packagingCostModel: PackagingCostModel.fromJson(json["packagingCost"]),
    );
  }
  Map<String, dynamic> toJson() => {
        "name": name,
        "groceriesMeat": groceriesMeat,
        "email": email,
        "password": password,
        "phone": phone,
        "address": address,
        "restaurantModelType": restaurantModelType,
        "logo": logo,
        "id": id,
        "lightLogo": lightLogo,
        "darkLogo": darkLogo,
        "openingTime": openingTime,
        "closingTime": closingTime,
        "printLogo": printLogo,
        "olo": olo,
        "dineIn": dineIn,
        "takeout": takeout,
        "numberOfReceipt": numberOfReceipt,
        "gratuityPersonCount": gratuityPersonCount,
        "packagingCostModel": packagingCostModel.toJson(),
      };
}
