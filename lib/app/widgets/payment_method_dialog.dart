import 'package:flutter/material.dart';
import 'package:yogo_pos/app/utils/static_colors.dart';
import 'package:yogo_pos/app/widgets/custom_btn.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class PaymentMethodDialog extends StatefulWidget {
  final Function(String paymentMethod) onSelectedPayment;

  const PaymentMethodDialog({
    super.key,
    required this.onSelectedPayment,
  });

  @override
  State<PaymentMethodDialog> createState() => _PaymentMethodDialogState();
}

class _PaymentMethodDialogState extends State<PaymentMethodDialog> {
  final List<String> _methodList = [
    "VISA",
    "MASTERCARD",
    "AMEX",
    "DEBIT_CARD",
    "CASH",
    "CASH_AND_CARD",
    "OTHERS",
    "GIFT_CARD"
  ];

  void _changeMethod(String value) {
    // Pass the selected payment method to the parent widget
    widget.onSelectedPayment(value);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      children: [
        Text(
          'Select Payment Method',
          style: theme.textTheme.titleLarge,
        ).marginOnly(bottom: 16),
        // Payment Method
        StaggeredGrid.count(
          crossAxisCount: 3,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: List.generate(_methodList.length, (index) {
            return PrimaryBtn(
              isOutline: true,
              borderWidth: 1.5,
              maxLines: 1,
              height: 70,
              textColor: Colors.white,
              fontWeight: FontWeight.w800,
              borderColor: StaticColors.blueColor,
              color: StaticColors.blueColor,
              onPressed: () {
                _changeMethod(_methodList[index]); // Call the method here
              },
              text: _methodList[index].replaceAll("_", " "),
            );
          }),
        ),
      ],
    );
  }
}
