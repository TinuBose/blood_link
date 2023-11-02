import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final IconData? data;
  final String? hintText;
  final int? maxlength;
  bool? isObscre = true;
  bool? enabled = true;
  final TextInputType? textInputType;

  CustomTextField(
      {this.controller,
      this.data,
      this.hintText,
      this.isObscre,
      this.enabled,
      this.maxlength,
      this.textInputType});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        enabled: enabled,
        controller: controller,
        obscureText: isObscre!,
        maxLength: maxlength,
        keyboardType: textInputType,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          prefixIcon: Icon(
            data,
            color: Colors.grey,
          ),
          focusColor: Theme.of(context).primaryColor,
          hintText: hintText,
        ),
      ),
    );
  }
}
