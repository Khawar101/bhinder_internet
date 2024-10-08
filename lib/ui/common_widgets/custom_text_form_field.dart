import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {super.key,
      this.onFieldSubmitted,
      // this.padding,
      // this.variant,
      // this.fontStyle,
      this.alignment,
      this.width,
      this.height,
      this.margin,
      this.controller,
      this.focusNode,
      this.isObscureText = false,
      this.textInputAction = TextInputAction.next,
      this.textInputType = TextInputType.text,
      this.maxLines,
      this.hintText,
      this.prefix,
      this.prefixConstraints,
      this.suffix,
      this.suffixConstraints,
      this.border,
      this.enabledBorder,
      this.focusedBorder,
      this.disabledBorder,
      this.hintStyle,
      this.inputFormaters,
      this.initialValue,
      this.textAlign,
      this.onChanged,
      this.radius,
      this.fieldcolor,
      this.textColor,
      this.autofocus});

  TextAlign? textAlign;
  List<TextInputFormatter>? inputFormaters;
  // WidgetShape? shape;

  // WidgetPadding? padding;

  // WidgetVariant? variant;

  // WidgetFontStyle? fontStyle;

  Alignment? alignment;

  void Function(String)? onFieldSubmitted;

  void Function(String)? onChanged;

  double? width;

  double? height;

  double? radius;

  Color? textColor;

  Color? fieldcolor;

  EdgeInsetsGeometry? margin;

  TextEditingController? controller;

  FocusNode? focusNode;

  bool? isObscureText;

  TextInputAction? textInputAction;

  TextInputType? textInputType;

  int? maxLines;

  String? hintText;

  Widget? prefix;

  BoxConstraints? prefixConstraints;

  Widget? suffix;

  BoxConstraints? suffixConstraints;
  var initialValue;

  InputBorder? border;
  InputBorder? enabledBorder;
  InputBorder? focusedBorder;
  InputBorder? disabledBorder;
  InputBorder? errorBorder;
  //this.focusedErrorBorder,
  //this.disabledBorder,
  //this.enabledBorder,

  GestureTapCallback? onTap;

  TextStyle? hintStyle;

  bool? autofocus;
  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildTextFormFieldWidget(context),
          )
        : _buildTextFormFieldWidget(context);
  }

  _buildTextFormFieldWidget(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      width: double.infinity,
      margin: margin,
      child: TextFormField(
        autofocus: false,
        onFieldSubmitted: (value) {
          if (onFieldSubmitted != null) {
            onFieldSubmitted!(value);
          }
          FocusScope.of(context).unfocus(); // Close the keyboard
        },
        onTap: onTap,
        onChanged: onChanged,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        focusNode: focusNode,
        style: _setFontStyle(),
        obscureText: isObscureText!,
        textAlign: textAlign ?? TextAlign.start,
        textInputAction: textInputAction,
        keyboardType: textInputType,
        inputFormatters: inputFormaters,
        maxLines: maxLines ?? 1,
        decoration: _buildDecoration(),
        initialValue: initialValue,
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return 'Please enter some text';
        //   }
        //   return null;
        // },
      ),
    );
  }

  _buildDecoration() {
    return InputDecoration(
      hintText: hintText ?? "",
      hintStyle: hintStyle ?? _setHintFontStyle(),
      border: border ?? _setBorderStyle(),
      enabledBorder: enabledBorder ?? _setBorderStyle(),
      focusedBorder: focusedBorder ?? _setBorderStyle(),
      disabledBorder: disabledBorder ?? _setBorderStyle(),
      prefixIcon: prefix,
      prefixIconConstraints: prefixConstraints,
      suffixIcon: suffix,
      suffixIconConstraints: suffixConstraints,
      fillColor: fieldcolor ?? _setFillColor(),
      filled: true,
      isDense: true,
      contentPadding: _setPadding(),
    );
  }

  _setFontStyle() {
    return TextStyle(
      color: textColor ?? Colors.black,
      fontSize: 14,
      fontFamily: 'Roboto',
    );
  }

  _setHintFontStyle() {
    return TextStyle(
      color: textColor ?? Colors.grey,
      fontSize: 14,
      fontFamily: 'Roboto',
    );
  }

  // ignore: unused_element
  _setOutlineBorderRadius() {
    return BorderRadius.circular(
      radius ?? 15.00,
    );
  }

  _setBorderStyle() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        radius ?? 15.00,
      ),
      borderSide: const BorderSide(color: Colors.black, width: 1.0),
    );
  }
}

_setFillColor() {
  return Colors.white;
}

_setPadding() {}
