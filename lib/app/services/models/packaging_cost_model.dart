class PackagingCostModel {
    PackagingCostModel({
        required this.title,
        required this.cost,
    });

    final String title;
    final num cost;

    factory PackagingCostModel.fromJson(Map<String, dynamic> json){ 
        return PackagingCostModel(
            title: json["title"] ?? "",
            cost: json["cost"] ?? 0,
        );
    }

    Map<String, dynamic> toJson() => {
        "title": title,
        "cost": cost,
    };

}