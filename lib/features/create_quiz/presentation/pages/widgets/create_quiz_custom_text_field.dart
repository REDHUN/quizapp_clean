import 'package:flutter/material.dart';

class CreateQuizCustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final TextInputType keyboardType;
  final Function(String)? onChanged;

  const CreateQuizCustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.textColor,
    required this.iconColor,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(fontSize: 16, color: textColor),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: textColor.withOpacity(0.7),
            fontSize: 14,
          ),
          prefixIcon: Icon(
            icon,
            color: iconColor,
            size: 22,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          errorStyle: TextStyle(
            color: Colors.red.shade400,
            fontSize: 13,
            fontWeight: FontWeight.w500,
            height: 0.8,
          ),
          filled: true,
          fillColor: backgroundColor,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
        onChanged: onChanged,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '⚠ Please enter $label';
          }
          return null;
        },
      ),
    );
  }
}
