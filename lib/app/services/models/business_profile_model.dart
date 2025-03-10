class BusinessProfileModel {
    BusinessProfileModel({
        required this.legalName,
        required this.dbaName,
        required this.phoneNumber,
        required this.businessEmail,
        required this.businessAddress,
        required this.gstNumber,
        required this.pstNumber,
        required this.pstNumber2,
        required this.gratuity,
        required this.country,
        required this.timeZone,
        required this.currency,
        required this.referralSource,
        required this.notes,
        required this.locations,
        required this.id,
    });

    final String legalName;
    final String dbaName;
    final String phoneNumber;
    final String businessEmail;
    final String businessAddress;
    final int gstNumber;
    final int pstNumber;
    final int pstNumber2;
    final int gratuity;
    final String country;
    final String timeZone;
    final String currency;
    final String referralSource;
    final String notes;
    final List<dynamic> locations;
    final String id;

    factory BusinessProfileModel.fromJson(Map<String, dynamic> json){ 
        return BusinessProfileModel(
            legalName: json["legalName"] ?? "",
            dbaName: json["DBAName"] ?? "",
            phoneNumber: json["phoneNumber"] ?? "",
            businessEmail: json["businessEmail"] ?? "",
            businessAddress: json["businessAddress"] ?? "",
            gstNumber: json["GSTNumber"] ?? 0,
            pstNumber: json["PSTNumber"] ?? 0,
            pstNumber2: json["PSTNumber2"] ?? 0,
            gratuity: json["gratuity"] ?? 0,
            country: json["country"] ?? "",
            timeZone: json["timeZone"] ?? "",
            currency: json["currency"] ?? "",
            referralSource: json["referralSource"] ?? "",
            notes: json["notes"] ?? "",
            locations: json["locations"] == null ? [] : List<dynamic>.from(json["locations"]!.map((x) => x)),
            id: json["id"] ?? "",
        );
    }

    Map<String, dynamic> toJson() => {
        "legalName": legalName,
        "DBAName": dbaName,
        "phoneNumber": phoneNumber,
        "businessEmail": businessEmail,
        "businessAddress": businessAddress,
        "GSTNumber": gstNumber,
        "PSTNumber": pstNumber,
        "PSTNumber2": pstNumber2,
        "gratuity": gratuity,
        "country": country,
        "timeZone": timeZone,
        "currency": currency,
        "referralSource": referralSource,
        "notes": notes,
        "locations": locations.map((x) => x).toList(),
        "id": id,
    };

}