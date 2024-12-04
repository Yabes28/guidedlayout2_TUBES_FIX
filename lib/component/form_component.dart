import 'package:flutter/material.dart';

// Modified inputForm function
Padding inputForm(
  String? Function(String?) validasi, {
  required TextEditingController controller,
  required String hintTxt,
  required IconData iconData,
  required String helperTxt,
  bool password = false,

}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    child: TextFormField(
      validator: validasi, // Validation logic
      controller: controller, // Controller for input field
      obscureText: password, // For password fields
      decoration: InputDecoration(
        helperText: helperTxt,
        // Hint text (shown inside the input field)
        hintText: hintTxt,
        // Helper text (optional text below the input field)
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20), // Rounded borders
        ),
        
        prefixIcon: Icon(iconData), // Icon inside the input field
        filled: true, // Adds background fill color
        fillColor: Colors.white, // Background color for the input field
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      ),
    ),
  );
}
