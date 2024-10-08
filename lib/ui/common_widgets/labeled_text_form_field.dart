import 'package:bhinder_internet/ui/common/app_colors.dart';
import 'package:bhinder_internet/ui/common/ui_helpers.dart';
import 'package:bhinder_internet/ui/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class LabeledTextFormField extends StatefulWidget {
  final String? title;
  final double? padding;
  Widget? prefix;
  final TextEditingController? controller;
  final String? hintText;
  final String? initialValue;
  final bool obscureText;
  final bool? enabled;
  final bool? autocorrect;
  final String? error;
  FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  final int? maxLines;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  LabeledTextFormField({
    super.key,
    this.focusNode,
    this.title,
    this.prefix,
    this.onFieldSubmitted,
    this.padding,
    this.controller,
    this.maxLines,
    this.hintText,
    this.initialValue,
    this.obscureText = false,
    this.enabled,
    this.error,
    this.keyboardType,
    this.onChanged,
    this.validator,
    this.autocorrect,
  });

  @override
  _LabeledTextFormFieldState createState() => _LabeledTextFormFieldState();
}

class _LabeledTextFormFieldState extends State<LabeledTextFormField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    // final isDark = Prefs.getBool(Prefs.DARKTHEME);

    return Padding(
      padding: EdgeInsets.only(bottom: widget.padding ?? 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          widget.title != null
              ? CustomText(
                  text: '${widget.title}:',
                  fontSize: extraMediumFontSize(context),
                )
              : Container(),
          verticalSpace(5),
          TextFormField(
            focusNode: widget.focusNode,
            maxLines: widget.maxLines ?? 1,
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText == true ? _obscureText : false,
            controller: widget.controller,
            enabled: widget.enabled ?? true,
            autocorrect: widget.autocorrect ?? true,
            decoration: InputDecoration(
              prefixIcon: widget.prefix,
              suffixIcon: widget.obscureText == true
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : null,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: blackPrimaryColor,
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: blackPrimaryColor,
                  width: 1.0,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: blackPrimaryColor,
                  width: 1.0,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: blackPrimaryColor,
                  width: 1.0,
                ),
              ),
              hintText: widget.hintText,
              hintStyle: TextStyle(
                fontSize: 16,
                color: blackPrimaryColor,
              ),
              errorText: widget.error,
            ),
            style: TextStyle(
              fontSize: 16,
              color: Colors.black.withOpacity(0.87),
            ),
            initialValue: widget.initialValue,
            cursorColor: kColorGrey,
            cursorWidth: 1,
            onChanged: widget.onChanged,
            validator: widget.validator,
            autofocus: true,
            onFieldSubmitted: (value) {
              if (widget.onFieldSubmitted != null) {
                widget.onFieldSubmitted!(value);
              }
              FocusScope.of(context).unfocus(); // Close the keyboard
            },
          ),
        ],
      ),
    );
  }
}
