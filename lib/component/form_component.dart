import 'package:flutter/material.dart';

// Modified inputForm function
Widget inputForm(
  String? Function(String?)? validator, {
  required TextEditingController controller,
  required String hintTxt,
  String? helperTxt,
  required IconData iconData,
  bool password = false,
}) {
  return TextFormField(
    controller: controller,
    obscureText: password,
    validator: validator,
    decoration: InputDecoration(
      hintText: hintTxt,
      helperText: helperTxt,
      prefixIcon: Icon(iconData),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
