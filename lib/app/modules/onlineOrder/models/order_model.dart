
import 'package:yogo_pos/app/modules/onlineOrder/models/option_model.dart';

import 'payment_model.dart';

class OrderModel {
  OrderModel({
    List<CartModel>? carts,
    this.splitPaymentMethods = const [],
    this.tokenId = "",
    this.guestName = "",
    this.guestEmail = "",
    this.guestPhoneNumber = "",
    this.orderType = "",
    this.orderStatus = "",
    this.totalOrderAmount = 0,
    this.subTotal = 0,
    this.tableName = "",
    this.notes = "",
    this.employeeId = "",
    this.employeeName = "",
    this.numberOfPeople = 1,
    this.paymentStatus = "",
    this.paymentMethod = "",
    this.totalGratuity = 0,
    this.totalGst = 0,
    this.totalPst = 0,
    this.totalPst2 = 0,
    this.packagingCost = 0,
    this.totalDiscount = 0,
    this.addOn = 0,
    this.createdAt,
    this.updatedAt,
    this.employee,
    this.table,
    this.orderSeen = false,
    this.id = "",
    this.estimatedTime = "",
    this.estimatedDate,
    this.orderId = "",
    this.orderNote = "",
    this.oloPaymentType = "",
    this.takeOutType,
    this.tip = 0,
    this.refund = false,
    this.recall = false,
    this.isNewOrder = true,
    this.cashPaidAmount,
    this.cashTipAmount,
    this.change = 0,
    this.cardPaidAmount,
    this.cardTipAmount,
    this.extraAmount = 0,
    this.cardType,
    this.payment,
  }) : carts = carts ?? [];

  List<CartModel> carts;
  List<String> splitPaymentMethods;
  String tokenId;
  String guestName;
  String guestEmail;
  String guestPhoneNumber;
  String orderType;
  String orderStatus;
  num totalOrderAmount;
  num subTotal;
  // String? tableId;
  String tableName;
  String notes;
  String employeeId;
  String employeeName;
  int numberOfPeople;
  String paymentStatus;
  String paymentMethod;
  String oloPaymentType;
  num totalGratuity;
  num totalGst;
  num totalPst;
  num totalPst2;
  num packagingCost;
  num totalDiscount;
  num addOn;
  String orderNote;
  String id;
  String estimatedTime;
  DateTime? estimatedDate;
  String? table;
  String? takeOutType;
  bool orderSeen;
  Employee? employee;
  DateTime? createdAt;
  DateTime? updatedAt;
  String orderId;
  num tip;
  final bool refund;
  final bool recall;
  final bool isNewOrder;
  //cash payment
  num? cashPaidAmount;
  num? cashTipAmount;
  num change;
  //cash&card payment
  num? cardPaidAmount;
  num? cardTipAmount;
  num extraAmount;
  String? cardType;
  // new payment
  PaymentModel? payment;
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
        carts: json["carts"] == null
            ? []
            : List<CartModel>.from(
                json["carts"]!.map((x) => CartModel.fromJson(x))),
        // splitOrders: json["splitOrders"] == null
        //     ? []
        //     : List<OrderModel>.from(
        //         json["splitOrders"]!.map((x) => OrderModel.fromJson(x))),
        tokenId: json["tokenId"] ?? "",
        guestName: json["guestName"] ?? "",
        guestEmail: json["guestEmail"] ?? "",
        guestPhoneNumber: json["guestPhoneNumber"] ?? "",
        orderType: json["orderType"] ?? "",
        orderStatus: json["orderStatus"] ?? "",
        notes: json["notes"] ?? "",
        oloPaymentType: json["oloPaymentType"] ?? "",
        totalOrderAmount: json["totalOrderAmount"] ?? 0,
        packagingCost: json["packagingCost"] ?? 0,
        employeeId: json["employeeId"] ?? "",
        numberOfPeople: json["numberOfPeople"] ?? 0,
        paymentStatus: json["paymentStatus"] ?? "",
        paymentMethod: json["paymentMethod"] ?? "",
        totalGratuity: json["totalGratuity"] ?? 0,
        totalGst: json["totalGst"] ?? 0,
        orderSeen: json["orderSeen"] ?? false,
        totalPst: json["totalPst"] ?? 0,
        totalPst2: json["totalPst2"] ?? 0,
        totalDiscount: json["totalDiscount"] ?? 0,
        addOn: json["addOn"] ?? 0,
        id: json["id"] ?? "",
        estimatedDate: json["estimatedDate"] == null
            ? null
            : DateTime.tryParse(json["estimatedDate"]),
        estimatedTime: json["estimatedTime"] ?? "",
        orderId: json["orderId"] ?? "",
        subTotal: json["subTotal"] ?? "",
        tableName: json["tableName"] ?? "",
        takeOutType: json["takeoutType"] ?? "",
        extraAmount: json["extraAmount"] ?? 0,
        //todo need to uocomment tip
        tip: json["tip"] ?? 0,
        refund: json["refund"] ?? false,
        recall: json["recall"] ?? false,
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.tryParse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.tryParse(json["updatedAt"]),
        orderNote: json["orderNote"] ?? "",
        table: json["table"] ?? "",
        isNewOrder: false,
        employee: json["employee"] == null
            ? null
            : (json["employee"] is Map<String, dynamic>
                ? Employee.fromJson(json["employee"])
                : null),
        // employee:
        //     json["employee"] == null ? null : Employee.fromJson(json["employee"]),
        payment: json["payment"] == null
            ? null
            : PaymentModel.fromJson(json["payment"]),
        splitPaymentMethods:
            List<String>.from(json["splitPaymentMethods"] ?? []));
  }

  Map<String, dynamic> toJson() => {
        "carts": carts.map((x) => x.toJson()).toList(),
        "guestName": guestName,
        "guestEmail": guestEmail,
        "orderType": orderType,
        "orderStatus": orderStatus,
        "totalOrderAmount": totalOrderAmount,
        if (table != null) "table": table,
        "employeeId": employeeId,
        "numberOfPeople": numberOfPeople,
        "notes": notes,
        "paymentStatus": paymentStatus,
        "paymentMethod": paymentMethod,
        "totalGratuity": totalGratuity,
        "totalGst": totalGst,
        "packagingCost": packagingCost,
        "totalPst": totalPst,
        "totalPst2": totalPst2,
        "totalDiscount": totalDiscount,
        "orderSeen": orderSeen,
        "addOn": addOn,
        "estimatedDate": estimatedDate.toString(),
        "estimatedTime": estimatedTime,
        "orderNote": orderNote,
        "subTotal": subTotal,
        "tip": tip,
        // if (tableName != "") "tableName":tableName ,
        "extraAmount": extraAmount,
        "guestPhoneNumber": guestPhoneNumber,
        "splitPaymentMethods": splitPaymentMethods,
        "orderId": orderId,
        if (takeOutType != null) "takeOutType": takeOutType,
        if (cashPaidAmount != null) "cashPaidAmount": cashPaidAmount,
        if (cashTipAmount != null) "cashTipAmount": cashTipAmount,
        "change": change,
        if (cardPaidAmount != null) "cardPaidAmount": cardPaidAmount,
        if (cardTipAmount != null) "cardTipAmount": cardTipAmount,
        // payment change
        if (payment != null) "payment": payment,
      };

  OrderModel copyWith(
      {List<CartModel>? carts,
      List<CartModel>? splitOrderCarts,
      List<String>? splitPaymentMethods,
      String? tokenId,
      String? guestName,
      String? guestEmail,
      String? guestPhoneNumber,
      String? orderType,
      String? takeOutType,
      String? orderStatus,
      num? totalOrderAmount,
      num? subTotal,
      String? tableId,
      String? tableName,
      String? employeeId,
      String? employeeName,
      int? numberOfPeople,
      String? paymentStatus,
      String? paymentMethod,
      num? totalGratuity,
      num? totalGst,
      num? totalPst,
      num? totalPst2,
      num? totalDiscount,
      num? addOn,
      String? orderNote,
      String? id,
      String? table,
      String? notes,
      bool? orderSeen,
      Employee? employee,
      DateTime? createdAt,
      String? orderId,
      String? estimatedTime,
      DateTime? estimatedDate,
      String? oloPaymentType,
      num? tip,
      bool? refund,
      bool? recall,
      num? packagingCost,
      bool? isNewOrder,
      num? cashPaidAmount,
      num? cashTipAmount,
      num? change,
      num? cardPaidAmount,
      num? cardTipAmount,
      num? extraAmount,
      String? cardType,
      PaymentModel? payment}) {
    return OrderModel(
      carts: carts ?? this.carts,
      tokenId: tokenId ?? this.tokenId,
      guestName: guestName ?? this.guestName,
      guestEmail: guestEmail ?? this.guestEmail,
      guestPhoneNumber: guestPhoneNumber ?? this.guestPhoneNumber,
      orderType: orderType ?? this.orderType,
      orderStatus: orderStatus ?? this.orderStatus,
      notes: notes ?? this.notes,
      totalOrderAmount: totalOrderAmount ?? this.totalOrderAmount,
      subTotal: subTotal ?? this.subTotal,
      tableName: tableName ?? this.tableName,
      employeeId: employeeId ?? this.employeeId,
      employeeName: employeeName ?? this.employeeName,
      numberOfPeople: numberOfPeople ?? this.numberOfPeople,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      orderSeen: orderSeen ?? this.orderSeen,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      totalGratuity: totalGratuity ?? this.totalGratuity,
      totalGst: totalGst ?? this.totalGst,
      totalPst: totalPst ?? this.totalPst,
      totalPst2: totalPst2 ?? this.totalPst2,
      totalDiscount: totalDiscount ?? this.totalDiscount,
      addOn: addOn ?? this.addOn,
      orderNote: orderNote ?? this.orderNote,
      id: id ?? this.id,
      table: table ?? this.table,
      takeOutType: takeOutType ?? this.takeOutType,
      employee: employee ?? this.employee,
      createdAt: createdAt ?? this.createdAt,
      orderId: orderId ?? this.orderId,
      tip: tip ?? this.tip,
      refund: refund ?? this.refund,
      recall: recall ?? this.recall,
      estimatedDate: estimatedDate ?? this.estimatedDate,
      estimatedTime: estimatedTime ?? this.estimatedTime,
      oloPaymentType: oloPaymentType ?? this.oloPaymentType,
      isNewOrder: isNewOrder ?? this.isNewOrder,
      cashPaidAmount: cashPaidAmount ?? this.cashPaidAmount,
      cashTipAmount: cashTipAmount ?? this.cashTipAmount,
      extraAmount: extraAmount ?? this.extraAmount,
      change: change ?? this.change,
      cardPaidAmount: cardPaidAmount ?? this.cardPaidAmount,
      cardTipAmount: cardTipAmount ?? this.cardTipAmount,
      cardType: cardType ?? this.cardType,
      payment: payment ?? this.payment,
      packagingCost: packagingCost ?? this.packagingCost,
      splitPaymentMethods: splitPaymentMethods ?? this.splitPaymentMethods,
    );
  }
}

class CartModel {
  CartModel({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    this.itemType = "",
    this.kitchenNote = "",
    this.discountAmount = 0,
    this.pstAmount = 0,
    this.weight = 0,
    this.description = "",
    this.isCustomProduct = false,
    this.isUpdated = false,
    this.variationOptions = const [],
    this.modifiers = const [],
  });

  String id;
  String name;
  num price;
  num quantity;
  String kitchenNote;
  String itemType;
  num discountAmount;
  num pstAmount;
  num weight;
  String description;
  bool isCustomProduct;
  bool isUpdated;
  List<OptionModel> variationOptions;
  List<String> modifiers;

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      price: json["price"] ?? 0,
      quantity: json["quantity"] ?? 1,
      weight: json["weight"] ?? 0,
      kitchenNote: json["kitchenNote"] ?? "",
      discountAmount: json["discountAmount"] ?? 0,
      pstAmount: json["pstAmount"] ?? 0,
      description: json["description"] ?? "",
      itemType: json["itemType"] ?? "",
      isCustomProduct: json["isCustomProduct"] ?? false,
      isUpdated: true,
      variationOptions: json["variationOptions"] == null
          ? []
          : List<OptionModel>.from(
              json["variationOptions"].map((x) => OptionModel.fromJson(x))),
      modifiers:
          json["modifiers"] == null ? [] : List<String>.from(json["modifiers"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "quantity": quantity,
        "kitchenNote": kitchenNote,
        "weight": weight,
        "discountAmount": discountAmount,
        "pstAmount": pstAmount,
        "itemType": itemType,
        "description": description,
        "isCustomProduct": isCustomProduct,
        "variationOptions": variationOptions.map((x) => x.toJson()).toList(),
        "modifiers": modifiers,
      };

  CartModel copyWith(
      {String? id,
      String? name,
      num? price,
      num? quantity,
      String? itemType,
      String? kitchenNote,
      String? toGo,
      String? serveFirst,
      String? dontMake,
      String? rush,
      num? discountAmount,
      num? pstAmount,
      num? weight,
      String? heat,
      String? description,
      bool? isCustomProduct,
      bool? isUpdated,
      List<OptionModel>? variationOptions,
      List<String>? modifiers}) {
    return CartModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      itemType: itemType ?? this.itemType,
      kitchenNote: kitchenNote ?? this.kitchenNote,
      weight: weight ?? this.weight,
      discountAmount: discountAmount ?? this.discountAmount,
      pstAmount: pstAmount ?? this.pstAmount,
      description: description ?? this.description,
      isCustomProduct: isCustomProduct ?? this.isCustomProduct,
      isUpdated: isUpdated ?? this.isUpdated,
      variationOptions: variationOptions ?? this.variationOptions,
      modifiers: modifiers ?? this.modifiers,
    );
  }
}

class Employee {
  Employee({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  final String id;
  final String firstName;
  final String lastName;

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json["id"] ?? "",
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
      };
}

class Table {
  Table({
    required this.id,
    required this.tableName,
  });

  final String id;
  final String tableName;

  factory Table.fromJson(Map<String, dynamic> json) {
    return Table(
      id: json["id"] ?? "",
      tableName: json["tableName"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "tableName": tableName,
      };
}
