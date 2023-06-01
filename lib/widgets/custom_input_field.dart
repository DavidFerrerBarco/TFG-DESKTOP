import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_desktop_app/theme/app_theme.dart';

// ignore: must_be_immutable
class CustomInputField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextInputType? keyboardType;
  bool isPassword;
  final bool? allowPassword;
  final List<TextInputFormatter>? inputFormatters;
  final Function? onPressed;
  final String formProperty;
  final Map<String, dynamic> formValues;
  final int? maxLines;

  CustomInputField({
    super.key,
    this.hintText,
    this.labelText,
    this.helperText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.isPassword = false,
    required this.formProperty,
    required this.formValues,
    required this.controller,
    this.inputFormatters,
    this.onPressed,
    this.allowPassword = false,
    this.maxLines,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  void onPasswordVisualize() {
    setState(() {
      widget.isPassword = !widget.isPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final InputDecorationTheme theme = AppTheme.lightTheme.inputDecorationTheme;

    return TextFormField(
      controller: widget.controller,
      style: const TextStyle(
          color: Colors.black, backgroundColor: Colors.white, fontSize: 18),
      autofocus: true,
      textCapitalization: TextCapitalization.words,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword,
      onChanged: (value) {
        widget.formValues[widget.formProperty] = value;
      },
      validator: (value) {
        if (value != null && value.length < 4) {
          return 'Mínimo 4 caractéres';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        filled: true,
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText,
        suffixIcon: widget.suffixIcon == null
            ? null
            : IconButton(
                onPressed: () {
                  if (widget.allowPassword == false) {
                    widget.onPressed!();
                  } else {
                    onPasswordVisualize();
                  }
                },
                icon: Icon(widget.suffixIcon),
                splashRadius: 20,
              ),
        suffixIconColor: AppTheme.primary,
        prefixIcon: widget.prefixIcon == null ? null : Icon(widget.prefixIcon),
        prefixIconColor: AppTheme.primary,
        border: theme.border,
        focusedBorder: theme.focusedBorder,
        enabledBorder: theme.enabledBorder,
        floatingLabelStyle: theme.floatingLabelStyle,
        fillColor: theme.fillColor,
        hoverColor: Colors.white,
      ),
      inputFormatters: widget.inputFormatters,
      maxLines: widget.maxLines ?? 1,
    );
  }
}
