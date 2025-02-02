import 'package:flutter/material.dart';
import 'package:game_app/core/theme/app_colors.dart';

class CreateQuizCustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final TextInputType keyboardType;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

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
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fillColor = isDark
        ? Colors.grey[800] ?? Colors.black
        : Colors.grey[100] ?? Colors.white;
    return Container(
      decoration: BoxDecoration(
        color: fillColor,
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
        fillColor: isDark?null: Colors.white, // Set pure white background here
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),

      onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
