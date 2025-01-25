import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPassword = false;
  final TextInputType? keyboardType;
  final TextEditingController textEditingController;

  const AuthTextField(
      {super.key,
      required this.icon,
        required this.textEditingController,
      required this.keyboardType,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: textEditingController,
        obscureText: isPassword,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
          prefixIcon: Icon(
            icon,
            color: const Color(0xFF6366F1),
            size: 22,
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: const Icon(Icons.visibility_outlined),
                  onPressed: () {},
                  color: Colors.grey[600],
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[100],
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}
