import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color.dart';

class CommonTextFormField extends StatefulWidget {
  const CommonTextFormField(
      {Key? key,
      required this.controller,
      required this.validator,
      required this.hintText,
      required this.obscureText,
      this.suffixIcon,
      this.onTap})
      : super(key: key);

  final TextEditingController controller;
  final FormFieldValidator validator;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final GestureTapCallback? onTap;
  @override
  State<CommonTextFormField> createState() => _CommonTextFormFieldState();
}

class _CommonTextFormFieldState extends State<CommonTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      controller: widget.controller,
      obscureText: widget.obscureText,
      validator: widget.validator,
      cursorColor: PickColor.primaryColor,
      maxLines: 1,
      decoration: InputDecoration(
        suffixIcon: widget.suffixIcon,
        contentPadding: EdgeInsets.only(
          left: 20.w,
        ),
        filled: true,
        fillColor: PickColor.fillColor,
        hintText: widget.hintText,
        hintStyle: TextStyle(color: PickColor.hintColor, fontSize: 14.sp),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.r),
            borderSide: BorderSide(color: PickColor.borderColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.r),
            borderSide: BorderSide(color: PickColor.borderColor)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.r),
            borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.r),
            borderSide: BorderSide(color: Colors.red)),
      ),
    );
  }
}

TextFormField formField(
    {required String hintText,
    required TextEditingController controller,
    required FormFieldValidator validator}) {
  return TextFormField(
    controller: controller,
    validator: validator,
    cursorColor: PickColor.primaryColor,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: PickColor.hintColor,
        fontWeight: FontWeight.w400,
        fontSize: 18.sp,
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: PickColor.formBorderColor,
        ),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: PickColor.formBorderColor,
        ),
      ),
      errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: PickColor.formBorderColor,
        ),
      ),
      focusedErrorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: PickColor.formBorderColor,
        ),
      ),
    ),
  );
}
