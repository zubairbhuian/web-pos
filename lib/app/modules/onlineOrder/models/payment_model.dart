class PaymentModel {
  PaymentModel({
    this.methods = const [],
    this.cardPaidAmount = 0,
    this.cardTipAmount = 0,
    this.cashPaidAmount = 0,
    this.cashTipAmount = 0,
    this.cardType = "",
    this.change = 0,
    this.method = "",
  });

  String method;
  List<String> methods;
  num cardPaidAmount;
  num cardTipAmount;
  num cashPaidAmount;
  num cashTipAmount;
  String cardType;
  num change;

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      methods: List<String>.from(json["methods"] ?? []),
      method: json["method"] ?? "",
      cardPaidAmount: json["cardPaidAmount"] ?? 0,
      cardTipAmount: json["cardTipAmount"] ?? 0,
      cashPaidAmount: json["cashPaidAmount"] ?? 0,
      cashTipAmount: json["cashTipAmount"] ?? 0,
      cardType: json["cardType"] ?? "",
      change: json["change"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "methods": methods,
        "method": method,
        "cardPaidAmount": cardPaidAmount,
        "cardTipAmount": cardTipAmount,
        "cashPaidAmount": cashPaidAmount,
        "cashTipAmount": cashTipAmount,
        "cardType": cardType,
        "change": change,
      };
}
