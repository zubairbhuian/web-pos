import 'package:flutter/material.dart';
import 'package:yogo_pos/app/modules/onlineOrder/models/order_model.dart';
import 'package:yogo_pos/app/modules/onlineOrder/widgets/custom_table_item.dart';
import 'package:yogo_pos/app/services/controller/base_controller.dart';
import 'package:yogo_pos/app/utils/my_func.dart';
import 'package:yogo_pos/app/utils/static_colors.dart';
import 'package:yogo_pos/app/widgets/custom_textfield.dart';
import 'package:yogo_pos/app/widgets/my_custom_text.dart';
import 'package:get/get.dart';

class OrderDetailsView extends StatelessWidget {
  final OrderModel order;
  const OrderDetailsView(this.order, {super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title area
                  _titleRow(theme, order).marginOnly(left: 25),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // for order details
                        Expanded(child: _itemDetails(theme, order)),
                        // order setup
                        SizedBox(width: 400, child: _orderSetup(theme, order)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // title row widgets
  Widget _titleRow(ThemeData theme, OrderModel data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            "Check: #${data.orderId}",
            // 'Order: #${data.orderId}',
            style: theme.textTheme.titleMedium,
          ).marginOnly(right: 16),
          Text(
            "Token: ${data.tokenId}",
            // 'Order: #${data.orderId}',
            style: theme.textTheme.titleMedium,
          ).marginOnly(right: 16),
          Text(
            'Items: ${data.carts.length}',
            style: theme.textTheme.titleMedium,
          ).marginOnly(right: 16),
          Visibility(
            visible:order.orderType == "DINE_IN",
            child: Text(
              'Table: ${data.tableName}',
              style: theme.textTheme.titleMedium,
            ).marginOnly(right: 16),
          ),
          Visibility(
            visible: order.orderType == "DINE_IN",
            child: Text(
              'Guests: ${data.numberOfPeople}',
              style: theme.textTheme.titleMedium,
            ).marginOnly(right: 16),
          ),
          Row(
            children: [
              Text(
                'Server: ${MyFunc.capitalizeEachWord(s: data.employee?.firstName)}',
                style: theme.textTheme.titleMedium,
              ),
              Visibility(
                visible: data.paymentStatus == "UNPAID",
                child: const Icon(
                  Icons.edit_square,
                  color: StaticColors.orangeColor,
                ),
              )
            ],
          ).marginOnly(right: 16),
          Text(
            'Order Type: ${data.orderType}'.replaceAll("_", " "),
            style: theme.textTheme.titleMedium,
          ).marginOnly(right: 16),
          Visibility(
            visible: data.orderType == 'TAKEOUT',
            child: Text(
              'Takeout Type: ${data.takeOutType}'.replaceAll("_", " "),
              style: theme.textTheme.titleMedium,
            ).marginOnly(right: 16),
          ),
          Visibility(
            visible: data.orderType == 'TAKEOUT',
            child: const Row(
              children: [
                Text(
                  'Notes',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                ),
                SizedBox(width: 8),
                Icon(Icons.visibility, color: StaticColors.blueColor),
              ],
            ),
          )
        ],
      ),
    );
  }

  // order setup
  Widget _orderSetup(ThemeData theme, OrderModel data) {
    // OrderModel order = PosController.to.myOrder;
    return Column(
      children: [
        Expanded(
            child: SingleChildScrollView(
          child: Column(
            children: [
              // cal 1
              Container(
                margin: const EdgeInsets.only(left: 16),
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Status',
                      style: theme.textTheme.headlineMedium,
                    ),
                    // const SizedBox(height: 16),
                    // Text(
                    //   'Change Order Status',
                    //   style: theme.textTheme.titleLarge,
                    // ),
                    const SizedBox(height: 12),
                    CustomSearchTextField(
                      
                      hintText: data.orderStatus,
                      dropDownList: [],
                    
                    ),
                  ],
                ),
              ),
              // payment Method
              Visibility(
                visible: data.orderStatus == "CANCELED",
                replacement: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(left: 16, top: 16),
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                  ),
                  child: Visibility(
                    visible: data.paymentStatus == "UNPAID",
                    replacement: SizedBox(),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Payment Method : ",
                              style: theme.textTheme.titleSmall?.copyWith(
                                  fontSize: 17, fontWeight: FontWeight.w800),
                            ),
                            Flexible(
                              child: Text(
                                data.payment?.methods
                                        .join(', ')
                                        .replaceAll('_', ' ') ??
                                    "",
                                style: theme.textTheme.titleSmall?.copyWith(
                                    fontSize: 17, fontWeight: FontWeight.w800),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        if (data.payment?.cardType != '')
                          _row(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            theme,
                            title: "Card : ",
                            value:
                                "${data.payment?.cardType.replaceAll('_', ' ')}",
                          ),
                        if ((data.payment?.cardPaidAmount ?? 0) > 0)
                          _row(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            theme,
                            title: "Card Amount : ",
                            value:
                                "\$${data.payment?.cardPaidAmount.toStringAsFixed(2)}",
                          ),
                        if ((data.payment?.cardTipAmount ?? 0) > 0)
                          _row(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            theme,
                            title: "Card Tip Amount : ",
                            value:
                                "\$${data.payment?.cardTipAmount.toStringAsFixed(2)}",
                          ),
                        if ((data.payment?.cashPaidAmount ?? 0) > 0)
                          _row(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            theme,
                            title: "Cash Amount : ",
                            value:
                                "\$${data.payment?.cashPaidAmount.toStringAsFixed(2)}",
                          ),
                        if ((data.payment?.cashTipAmount ?? 0) > 0)
                          _row(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            theme,
                            title: "Cash Tip Amount : ",
                            value:
                                "\$${data.payment?.cashTipAmount.toStringAsFixed(2)}",
                          ),
                        if ((data.payment?.change ?? 0) > 0)
                          _row(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            theme,
                            title: "Cash Change : ",
                            value:
                                "\$${data.payment?.change.toStringAsFixed(2)}",
                          ),
                        const SizedBox(height: 14),
                        _row(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            theme,
                            title: "Total Paid : ",
                            value:
                                '\$${data.totalOrderAmount.toStringAsFixed(2)}'),
                      ],
                    ),
                   
                   
                  ),
                ),
                child: const SizedBox(),
              ),
            ],
          ),
        )),
      ],
    );
  }

  // item details
  Widget _itemDetails(ThemeData theme, OrderModel data) {
    return Container(
      // width: double.infinity,
      // padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header
          // const SizedBox(height: 16),
          // header
          CustomTableItem(
            isSelected: true,
            isHeader: true,
            onChanged: (value) {
             
            },
          ),
          Expanded(
            child: SingleChildScrollView(
       
                child: Column(
                  children: [
                    Column(
                      children: List.generate(data.carts.length, (index) {
                        var item = data.carts[index];
                        var gratuity = (item.price - item.discountAmount) * .05;
                        var gst = (item.price - item.discountAmount) * .05;
                        var pst = (item.price - item.discountAmount) * .05;
                        var totalPrice = item.price * item.quantity;
                        var discount = item.discountAmount;
                        var totalDiscount = item.discountAmount * item.quantity;
                        return CustomTableItem(
                          onTap: () {
                           
                          },
                          isSelected: false,
                          onChanged: (value) {
                        
                          },
                          sl: "${index + 1}",
                          name: item.itemType == "weighing scale"
                              ? "${item.name}(${item.weight}LB)"
                              : item.name,
                          qty: "${item.quantity}",
                          discount: "\$ ${discount.toStringAsFixed(2)}",
                          totalDiscount:
                              "\$ ${totalDiscount.toStringAsFixed(2)}",
                          gratuity: "\$ ${gratuity.toStringAsFixed(2)}",
                          gst: "\$ ${gst.toStringAsFixed(2)}",
                          pst: "\$ ${pst.toStringAsFixed(2)}",
                          totalPrice: "\$ ${totalPrice.toStringAsFixed(2)}",
                          price: "\$ ${item.price.toStringAsFixed(2)}",
                          isUpdated: item.isUpdated,
                          modifiers: item.modifiers,
                          note: item.kitchenNote,
                          options: item.variationOptions,
                        );
                      }),
                    ),
                  ],
                ),
              )
            
            ,
          ),

          const Divider(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                _row(theme,
                    title: "Subtotal :",
                    fontSize: 15,
                    value: "\$ ${data.subTotal.toStringAsFixed(2)}",
                    fontWeight: FontWeight.w800),
                const SizedBox(height: 4),
                Visibility(
                  visible: data.totalGst > 0,
                  child: _row(
                    theme,
                    title:
                        "GST ${BaseController.to.restaurantDetails?.businessProfile.gstNumber ?? 0}% :",
                    fontSize: 13,
                    value: "\$ ${data.totalGst.toStringAsFixed(2)}",
                    fontWeight: FontWeight.w800,
                  ),
                ),
                if (data.totalGratuity > 0)
                  _row(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    theme,
                    title:
                        "Gratuity ${BaseController.to.restaurantDetails?.businessProfile.gratuity ?? 0}% : ",
                    value: "\$${data.totalGratuity.toStringAsFixed(2)}",
                  ),
                if (data.totalPst > 0)
                  _row(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    theme,
                    title:
                        "PST ${BaseController.to.restaurantDetails?.businessProfile.pstNumber ?? 0}% : ",
                    value: "\$${data.totalPst.toStringAsFixed(2)}",
                  ),
                if (data.totalPst2 > 0)
                  _row(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    theme,
                    title:
                        "PST2 ${BaseController.to.restaurantDetails?.businessProfile.pstNumber2 ?? 0}% : ",
                    value: "\$${data.totalPst2.toStringAsFixed(2)}",
                  ),
                if (data.tip > 0)
                  _row(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    theme,
                    title: "Tip : ",
                    value: "\$${data.tip.toStringAsFixed(2)}",
                  ),
                if (data.totalDiscount > 0)
                  _row(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    theme,
                    title: "Discount : ",
                    value: "\$${data.totalDiscount.toStringAsFixed(2)}",
                  ),
                Visibility(
                  visible: data.packagingCost > 0,
                  child: _row(
                    theme,
                    title:
                        "${(BaseController.to.restaurantDetails?.restaurant.packagingCostModel.title) ?? ""}: ",
                    value: "\$${data.packagingCost.toStringAsFixed(2)}",
                  ),
                ),
                const SizedBox(height: 8),
                _row(theme,
                    title: "Total :",
                    value: "\$ ${data.totalOrderAmount.toStringAsFixed(2)}",
                    fontSize: 16,
                    fontWeight: FontWeight.w800),
              ],
            ),
          ),

          const SizedBox(height: 16),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          //   child: GetBuilder<PosController>(builder: (pc) {
          //     return Visibility(
          //       visible: pc.checkSplitChecksAllPaid() ||
          //           data.paymentStatus == "PAID" ||
          //           data.orderStatus == "CANCELED",
          //       replacement: Row(
          //         children: [
          //           PrimaryBtn(
          //             width: 200,
          //             height: height,
          //             textMaxSize: textMaxSize,
          //             textMinSize: textMinSize,
          //             onPressed: () {
                   
          //             },
          //             // Add Items,Change Table,Guests
          //             text: 'Add Items ,\nChange Table, Guests'.toUpperCase(),
          //             textColor: Colors.white,
          //             padding: const EdgeInsets.symmetric(
          //                 horizontal: 6, vertical: 10),
          //             color: theme.primaryColor,
          //           ),
          //           GetBuilder<PosController>(builder: (context) {
          //             return Tooltip(
          //               message: context.selectedItemList.isEmpty
          //                   ? 'Select item first'
          //                   : '',
          //               child: PrimaryBtn(
          //                 onPressed: () {
          //                   context.repeatAllSelectedItems();
          //                 },
          //                 width: btnSize,
          //                 height: height,
          //                 isdisabled:
          //                     context.selectedItemList.isEmpty ? true : false,
          //                 textMaxSize: textMaxSize,
          //                 textMinSize: textMinSize,
          //                 text: 'Repeat Items'.toUpperCase(),
          //                 textColor: Colors.white,
          //                 color: StaticColors.greenColor,
          //                 padding: const EdgeInsets.symmetric(
          //                     horizontal: 6, vertical: 10),
          //               ).marginOnly(left: 12),
          //             );
          //           }),
          //           // todo : Transfer  Items
          //           // GetBuilder<PosController>(builder: (context) {
          //           //   return Tooltip(
          //           //     message: context.selectedItemList.isEmpty
          //           //         ? 'Select item first'
          //           //         : (context.myOrder.orderType == 'TAKEOUT'
          //           //             ? 'Transferring items is not possible with this order.'
          //           //             : ''),
          //           //     child: PrimaryBtn(
          //           //       onPressed: () {
          //           //         // PopupDialog.permissionDialogWithAccessPin(
          //           //         //     onSubmit: () {
          //           //         //       Get.back();
          //           //         //     },
          //           //         //     title: "Transfer Items?");
          //           //         DineInController.to.getTableCategories();
          //           //         PopupDialog.customDialog(
          //           //             width: Get.width * 0.8,
          //           //             child: const TableBody(
          //           //               isScrollable: false,
          //           //               isTransferItems: true,
          //           //             ));
          //           //       },
          //           //       width: btnSize,
          //           //       height: height,
          //           //       isdisabled: context.selectedItemList.isEmpty ||
          //           //               context.myOrder.orderType == 'TAKEOUT'
          //           //           ? true
          //           //           : false,
          //           //       textMaxSize: textMaxSize,
          //           //       textMinSize: textMinSize,
          //           //       padding: const EdgeInsets.symmetric(
          //           //           horizontal: 6, vertical: 10),
          //           //       text: 'Transfer Items'.toUpperCase(),
          //           //       textColor: Colors.white,
          //           //       color: StaticColors.pinkColor,
          //           //     ).marginOnly(left: 12),
          //           //   );
          //           // }),
          //           GetBuilder<PosController>(builder: (context) {
          //             return Tooltip(
          //               message: context.selectedItemList.isEmpty
          //                   ? 'Select item first'
          //                   : '',
          //               child: PrimaryBtn(
          //                 width: btnSize,
          //                 height: height,
          //                 isdisabled:
          //                     context.selectedItemList.isEmpty ? true : false,
          //                 textMaxSize: textMaxSize,
          //                 textMinSize: textMinSize,
          //                 onPressed: () {
          //                   PopupDialog.permissionDialogWithAccessPin(
          //                       onSubmit: () {
          //                         context.removeAllSelectedItems();
          //                         Get.back();
          //                       },
          //                       title: context.selectedItemList.length == 1
          //                           ? "Remove Item?"
          //                           : "Remove Items?");
          //                 },
          //                 // width: double.infinity,
          //                 text: 'Remove Items'.toUpperCase(),
          //                 textColor: Colors.white,
          //                 color: StaticColors.pinkColor,
          //               ).marginOnly(left: 12),
          //             );
          //           }),
          //         ],
          //       ),
          //       child: const Row(
          //         children: [
          //           // PrimaryBtn(
          //           //   onPressed: () {
          //           //     PopupDialog.showErrorMessage(
          //           //         "This feature will be available soon");
          //           //   },
          //           //   width: btnSize,
          //           //   height: height,
          //           //   textMaxSize: textMaxSize,
          //           //   textMinSize: textMinSize,
          //           //   padding: const EdgeInsets.symmetric(
          //           //       horizontal: 6, vertical: 10),
          //           //   text: 'ReCall'.toUpperCase(),
          //           //   textColor: Colors.white,
          //           //   color: StaticColors.orangeColor,
          //           // )
          //         ],
          //       ),
          //     );
          //   }),
          // ),
       
       
        ],
      ),
    );
  }
}

// row
Widget _row(
  ThemeData theme, {
  double? fontSize,
  FontWeight? fontWeight,
  Widget? child,
  required String title,
  required String value,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
                fontSize: fontSize ?? 14,
                fontWeight: fontWeight ?? FontWeight.w700),
          ),
          SizedBox(
            child: child,
          )
        ],
      ),
      Text(
        value,
        style: theme.textTheme.titleSmall?.copyWith(
            fontSize: fontSize ?? 14,
            fontWeight: fontWeight ?? FontWeight.w700),
      ),
    ],
  );
}

class ItemTile extends StatelessWidget {
  const ItemTile({
    super.key,
    required this.name,
    required this.qnty,
    required this.price,
    this.onTap,
    this.bgColor,
  });

  final String name;
  final int qnty;
  final double price;
  final VoidCallback? onTap;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: Theme.of(context).focusColor, width: 0.15),
        ),
        child: Row(
          children: [
            Expanded(flex: 4, child: MyCustomText(name)),
            Expanded(flex: 1, child: MyCustomText('x$qnty')),
            Expanded(
              flex: 2,
              child: MyCustomText('\$${price.toStringAsFixed(2)}'),
            ),
          ],
        ),
      ),
    );
  }
}
