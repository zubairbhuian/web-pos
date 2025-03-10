import 'package:flutter/material.dart';
import 'package:fraction/fraction.dart';
import 'package:yogo_pos/app/utils/my_func.dart';
import 'package:yogo_pos/app/utils/static_colors.dart';
import 'package:yogo_pos/app/widgets/my_custom_text.dart';
import 'package:get/get.dart';

import '../models/option_model.dart';

class CustomTableItem extends StatelessWidget {
  final bool isHeader;
  final String name;
  final String sl;
  final String qty;
  final String price;
  final String discount;
  final String totalDiscount;
  final String gratuity;
  final String gst;
  final String pst;
  final String totalPrice;
  final String serveFirst;
  final String toGo;
  final String dontMake;
  final String rush;
  final String heat;
  final String note;
  final List<OptionModel> options;
  final List<String> modifiers;
  final bool isSelected;
  final bool isUpdated;
  final void Function(bool?)? onChanged;
  final dynamic Function()? onTap;
  const CustomTableItem(
      {super.key,
      this.isHeader = false,
      this.options = const [],
      this.modifiers = const [],
      this.sl = "",
      this.name = "",
      this.qty = "",
      this.price = "",
      this.discount = "",
      this.totalDiscount = "",
      this.gratuity = "",
      this.pst = "",
      this.gst = "",
      this.totalPrice = "",
      this.serveFirst = '',
      this.toGo = '',
      this.dontMake = '',
      this.rush = '',
      this.heat = '',
      this.note = '',
      this.onTap,
      this.isSelected = true,
      this.isUpdated = false,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: isHeader == true ? null : onTap,
      child: Container(
        //padding
        padding: EdgeInsets.symmetric(vertical: isHeader == true ? 2 : 0),
        // bg color
        color: isHeader
            ? theme.disabledColor.withOpacity(0.5)
            : isSelected
                ? isUpdated
                    ? const Color.fromARGB(255, 180, 180, 180).withOpacity(.2)
                    : StaticColors.blueColor.withOpacity(.2)
                : isUpdated
                    ? const Color.fromARGB(255, 180, 180, 180).withOpacity(.4)
                    : Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // item
            SizedBox(
              width: 30,
              child: Text(
                isHeader == true ? "No" : sl,
                style: isHeader == true
                    ? theme.textTheme.labelMedium
                    : theme.textTheme.bodyLarge,
              ),
            ).marginSymmetric(horizontal: 6),
            // item (Checkbox)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Checkbox(value: isSelected, onChanged: onChanged),
            ),
            // item 3
            Expanded(
              flex: 2,
              child: SizedBox(
                // width: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isHeader == true ? "Items" : name,
                      style: isHeader == true
                          ? theme.textTheme.labelMedium
                          : theme.textTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    //options
                    // const SizedBox(height: 4),
                    ...List.generate(options.length, (index) {
                      var optionData = options[index];
                      return Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "${MyFunc.capitalizeEachWord(s: optionData.name)}: ",
                              style: theme.textTheme.bodyMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            "\$${optionData.price.toStringAsFixed(2)}",
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      );
                    }),
                    //modifiers
                    const SizedBox(height: 4),
                    ...List.generate(modifiers.length, (index) {
                      return Row(
                        children: [
                          Flexible(
                            child: Text(
                              modifiers[index].trim().toUpperCase(),
                              style: theme.textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ).marginOnly(right: 10);
                    }),

                    //modifiers
                    // const SizedBox(height: 4),
                    if (serveFirst.isNotEmpty)
                      MyCustomText(serveFirst, fontSize: 12),
                    if (toGo.isNotEmpty) MyCustomText(toGo, fontSize: 12),
                    if (dontMake.isNotEmpty)
                      MyCustomText(dontMake, fontSize: 12),
                    if (rush.isNotEmpty) MyCustomText(rush, fontSize: 12),
                    if (heat.isNotEmpty)
                      MyCustomText('Heat: $heat', fontSize: 12),
                    if (note.isNotEmpty) MyCustomText(note, fontSize: 12),
                  ],
                ),
              ).marginAll(10),
            ),
            // item  4
            Expanded(
              flex: 1,
              child: SizedBox(
                child: Center(
                  child: Text(
                    isHeader == true
                        ? "Qty"
                        : double.parse(qty).toFraction().toString(),
                    style: isHeader == true
                        ? theme.textTheme.labelMedium
                        : theme.textTheme.bodyLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ).marginAll(10),
            ),
            // item 5
            Expanded(
              flex: 1,
              child: SizedBox(
                // width: 100,
                child: Text(
                  isHeader == true ? "Price" : price,
                  style: isHeader == true
                      ? theme.textTheme.labelMedium
                      : theme.textTheme.bodyLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ).marginAll(10),
            ),
            // item 6
            Expanded(
              flex: 1,
              child: SizedBox(
                // width: 100,
                child: Text(
                  isHeader == true ? "Discount" : discount,
                  style: isHeader == true
                      ? theme.textTheme.labelMedium
                      : theme.textTheme.bodyLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ).marginAll(10),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                // width: 100,
                child: Text(
                  isHeader == true ? "Total Discount" : totalDiscount,
                  style: isHeader == true
                      ? theme.textTheme.labelMedium
                      : theme.textTheme.bodyLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ).marginAll(10),
            ),
            // // ! Gratuity
            // Expanded(
            //   flex: 2,
            //   child: SizedBox(
            //     // width: 100,
            //     child: Text(
            //       isHeader == true ? "Gratuity" : gratuity,
            //       style: isHeader == true
            //           ? theme.textTheme.labelMedium
            //           : theme.textTheme.bodyLarge,
            //     ),
            //   ).marginAll(10),
            // ),
            // // ! GST
            // Expanded(
            //   flex: 2,
            //   child: SizedBox(
            //     // width: 100,
            //     child: Text(
            //       isHeader == true ? "GST" : gst,
            //       style: isHeader == true
            //           ? theme.textTheme.labelMedium
            //           : theme.textTheme.bodyLarge,
            //     ),
            //   ).marginAll(10),
            // ),
            // // ! PST
            // Expanded(
            //   flex: 2,
            //   child: SizedBox(
            //     // width: 100,
            //     child: Text(
            //       isHeader == true ? "PST" : pst,
            //       style: isHeader == true
            //           ? theme.textTheme.labelMedium
            //           : theme.textTheme.bodyLarge,
            //     ),
            //   ).marginAll(10),
            // ),
            // item 8
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  // width: 100,
                  child: Text(
                    isHeader == true ? "Total Price" : totalPrice,
                    style: isHeader == true
                        ? theme.textTheme.labelMedium
                        : theme.textTheme.bodyLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ).marginAll(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
