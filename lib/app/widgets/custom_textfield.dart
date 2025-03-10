import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yogo_pos/app/widgets/my_custom_text.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool? obscureText;
  final bool? readOnly;
  final Widget? suffixIcon;
  final Widget? suffixIconColor;
  final Widget? prefixIcon;
  final String? hintText;
  final Widget? label;
  final String? extraLabel;
  final double? extraLabelFontSize;
  final TextStyle? labelStyle;
  final TextStyle? extraLabelStyle;
  final TextStyle? errorStyle;
  final VoidCallback? onTap;
  final AutovalidateMode? autovalidateMode;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Function(String)? onChange;
  final Function(String)? onFieldSubmitted;
  final EdgeInsetsGeometry? padding;
  final FocusNode? focusNode;
  final Color? cursorColor;
  final TextAlign? textAlign;
  final double? fontSize;
  final List<TextInputFormatter>? inputFormatters;
  final bool? autofocus;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final String? errorText;
  final VoidCallback? onEditingComplete;
  final int? maxLines;
  final double? marginBottom;
  final bool isFilled;
  final double? borderRadius;
  final String? prefixText;

  const CustomTextField({
    super.key,
    this.controller,
    this.obscureText,
    this.readOnly,
    this.suffixIcon,
    this.prefixIcon,
    this.hintText,
    this.label,
    this.onTap,
    this.autovalidateMode,
    this.keyboardType,
    this.validator,
    this.onChange,
    this.padding,
    this.cursorColor,
    this.inputFormatters,
    this.autofocus,
    this.textAlign,
    this.fontSize,
    this.style,
    this.errorText,
    this.onEditingComplete,
    this.maxLines,
    this.suffixIconColor,
    this.extraLabel,
    this.extraLabelFontSize,
    this.extraLabelStyle,
    this.labelStyle,
    this.errorStyle,
    this.marginBottom,
    this.hintStyle,
    this.borderRadius,
    this.isFilled = false,
    this.focusNode,
    this.prefixText,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ********** extraLabel ********
        if (extraLabel != null)
          MyCustomText(extraLabel ?? "", fontSize: extraLabelFontSize),
        if (extraLabel != null)
          const SizedBox(
            height: 10,
          ),
        TextFormField(
          enableInteractiveSelection: false,
          // ********** controller ********
          controller: controller,
          // ********** validator ********
          validator: validator,
          // ********** focusNode ********
          focusNode: focusNode,
          // ********** onChanged ********
          onChanged: onChange,
          // ********** obscureText ********
          obscureText: obscureText ?? false,
          // ********** readOnly ********
          readOnly: readOnly ?? false,
          // ********** autovalidateMode ********
          autovalidateMode: autovalidateMode,
          // ********** cursorColor ********
          cursorColor: cursorColor ?? theme.primaryColor,
          // ********** maxLines ********
          maxLines: maxLines ?? 1,
          // ********** autofocus ********
          autofocus: autofocus ?? false,
          // ********** textAlign ********
          textAlign: textAlign ?? TextAlign.start,
          // ********** onTap ********
          onTap: onTap,
          // ********** onFieldSubmitted ********
          onFieldSubmitted: onFieldSubmitted,
          // ********** style ********
          style: style ?? theme.textTheme.bodyLarge,
          // ********** controller ********
          onEditingComplete: onEditingComplete,
          // ********** keyboardType ********
          keyboardType: keyboardType,
          selectionControls:
              MaterialTextSelectionControls(), // Use default selection controls

          //! ********** decoration ********
          decoration: InputDecoration(
            filled: isFilled,
            fillColor: theme.scaffoldBackgroundColor,
            // ********** errorText ********
            errorText: errorText,
            errorStyle: errorStyle ??
                theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
            errorMaxLines: 5,
            // ********** padding ********

            contentPadding: padding ??
                const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            // ********** prefixIcon ********
            prefixIcon: prefixIcon,
            prefixText: prefixText,
            // ********** suffixIcon ********
            suffixIcon: suffixIcon,
            // ********** border ********
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 6),
                borderSide: BorderSide(color: theme.hintColor)),
            // ********** focusedBorder ********
            focusColor: theme.primaryColor,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 6),
                borderSide: BorderSide(color: theme.primaryColor)),
            // ********** enabledBorder ********
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 6),
                borderSide: BorderSide(color: theme.hintColor)),
            // ********** errorBorder ********
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 6),
                borderSide: const BorderSide(color: Colors.red)),
            // ********** errorBorder ********
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 6),
                borderSide: const BorderSide(color: Colors.red)),
            // ********** hintText ********
            hintText: hintText,
            hintStyle: hintStyle ??
                theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
            // ********** label ********
            label: label,
            labelStyle: labelStyle ?? theme.textTheme.labelMedium,
          ),

          // ********** inputFormatters ********
          inputFormatters:
              inputFormatters ?? [LengthLimitingTextInputFormatter(500)],
        ),
        // ********** marginBottom ********
        SizedBox(
          height: marginBottom,
        )
      ],
    );
  }
}

class CustomDropdownTextField extends StatelessWidget {
  const CustomDropdownTextField({
    super.key,
    this.label,
    required this.onChanged,
    this.hint,
    this.icon,
    this.enabledBorderColor,
    this.borderColor,
    this.hintStyle,
    this.value,
    required this.items,
  });

  final String? label;
  final Widget? hint;
  final Widget? icon;
  final Function(String?) onChanged;
  final Color? enabledBorderColor;
  final Color? borderColor;
  final TextStyle? hintStyle;
  final String? value;
  final List<DropdownMenuItem<String>>? items;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) MyCustomText(label ?? ""),
        SizedBox(height: label == null ? 0 : 8),
        DropdownButtonFormField<String>(
          hint: hint ??
              Text(
                'Select',
                style: theme.textTheme.bodyLarge
                    ?.copyWith(color: const Color(0xFFC0C0C0)),
              ),
          icon: icon,
          value: value,
          dropdownColor: theme.scaffoldBackgroundColor,
          focusColor: theme.scaffoldBackgroundColor,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: theme.hintColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: theme.hintColor)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: theme.hintColor)),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
              focusColor: theme.scaffoldBackgroundColor,
              hintStyle: hintStyle ??
                  theme.textTheme.bodyLarge?.copyWith(
                      color: theme.hintColor) // Set the background color here
              ),
          items: items,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class CustomSearchTextField extends StatelessWidget {
  final dynamic controller;
  final FocusNode? textFieldFocusNode;
  final FocusNode? searchFocusNode;
  final bool? clearOption;
  final bool? searchShowCursor;
  final int? dropDownItemCount;
  final bool? enableSearch;
  final TextInputType? searchKeyboardType;
  final List<DropDownValueModel> dropDownList;
  final Function(dynamic)? onChanged;
  final String? hintText;
  final bool? searchAutofocus;
  final bool? isFilled;
  final double? radius;
  final EdgeInsets? padding;
  final String? Function(String?)? validator;
  const CustomSearchTextField(
      {super.key,
      this.controller,
      this.textFieldFocusNode,
      this.searchFocusNode,
      this.clearOption,
      this.searchShowCursor,
      this.dropDownItemCount,
      this.enableSearch,
      this.searchKeyboardType,
      required this.dropDownList,
      this.onChanged,
      this.hintText,
      this.searchAutofocus,
      this.isFilled,
      this.radius,
      this.validator,
      this.padding});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return DropDownTextField(
      padding: padding,
      controller: controller,
      clearOption: clearOption ?? true,
      textFieldFocusNode: textFieldFocusNode,
      searchFocusNode: searchFocusNode,
      searchAutofocus: searchAutofocus ?? false,
      dropDownItemCount: dropDownItemCount ?? 6,
      searchShowCursor: searchShowCursor,
      enableSearch: enableSearch ?? false,
      searchKeyboardType: searchKeyboardType,
      dropDownList: dropDownList,
      onChanged: onChanged,
      validator: validator,
      listTextStyle: theme.textTheme.labelLarge?.copyWith(color: Colors.black),
      textFieldDecoration: InputDecoration(
        filled: isFilled,
        fillColor: theme.scaffoldBackgroundColor,
        // ********** padding ********
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        // // ********** prefixIcon ********
        // prefixIcon: prefixIcon,
        // // ********** suffixIcon ********
        // suffixIcon: suffixIcon,
        // ********** border ********
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 4),
            borderSide: BorderSide(color: theme.hintColor)),
        // ********** focusedBorder ********
        focusColor: theme.primaryColor,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 4),
            borderSide: BorderSide(color: theme.hintColor)),
        // ********** enabledBorder ********
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 4),
            borderSide: BorderSide(color: theme.hintColor)),
        // ********** errorBorder ********
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 4),
            borderSide: const BorderSide(color: Colors.red)),
        // ********** errorBorder ********
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 4),
            borderSide: const BorderSide(color: Colors.red)),
        // ********** hintText ********
        hintText: hintText,
        // ********** label ********
        labelStyle: theme.textTheme.labelLarge,
      ),
    );
  }
}
