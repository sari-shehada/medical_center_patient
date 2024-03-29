import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.leadingIcon,
    this.hintText,
    this.label,
    this.color,
    this.obscureText = false,
    this.suffixIcon,
    this.maxLength,
    this.keyboardType,
    this.inputAction,
    this.textDirection,
    this.suffixIconOnTap,
    this.onSubmitted,
  });

  final IconData? leadingIcon;
  final TextEditingController controller;
  final String? hintText;
  final String? label;
  final Color? color;
  final IconData? suffixIcon;
  final VoidCallback? suffixIconOnTap;
  final int? maxLength;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? inputAction;
  final TextDirection? textDirection;
  final void Function(String)? onSubmitted;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: color),
      textDirection: textDirection,
      decoration: InputDecoration(
        fillColor: const Color(0xFFDEECE8),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: color ?? Theme.of(context).colorScheme.primary,
          ),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        label: label != null
            ? Text(
                label!,
                style: TextStyle(color: color),
              )
            : null,
        prefixIcon: Icon(
          leadingIcon,
          color: color,
        ),
        prefixIconColor: MaterialStateColor.resolveWith(
          (state) {
            if (state.isEmpty) {
              return CupertinoColors.systemGrey;
            }
            if (state.first == MaterialState.focused) {
              return color ?? Theme.of(context).colorScheme.primary;
            }
            return CupertinoColors.systemGrey;
          },
        ),
        suffixIcon: InkWell(
          onTap: suffixIconOnTap,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Icon(
              suffixIcon,
              color: color,
            ),
          ),
        ),
      ),
      maxLength: maxLength,
      keyboardType: keyboardType,
      textInputAction: inputAction,
      onSubmitted: onSubmitted,
    );
  }
}
