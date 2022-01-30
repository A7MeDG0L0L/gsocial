import 'package:flutter/material.dart';

Widget myTextFormField(
    {required TextEditingController controller,
    required TextInputType textInputType,
    required  validation,
    String? label,
    IconData? icon,
    bool isObscure = false,}) {
  return TextFormField(
    controller: controller,
    keyboardType: textInputType,
    validator: validation,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
    ),
 obscureText: isObscure,
  );
}
