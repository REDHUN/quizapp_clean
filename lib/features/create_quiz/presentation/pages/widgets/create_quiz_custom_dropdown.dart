import 'package:flutter/material.dart';

class CreateQuizCustomDropdown extends StatelessWidget {
  final String? value;
  final String label;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final List<String> items;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;

  const CreateQuizCustomDropdown({
    super.key,
    required this.value,
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.textColor,
    required this.iconColor,
    required this.items,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: iconColor),
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
          fillColor: isDark?null: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          labelStyle: TextStyle(color: textColor.withOpacity(0.7)),
        ),
        dropdownColor: backgroundColor,
        icon: Icon(Icons.arrow_drop_down_rounded, color: iconColor),
        isExpanded: true,
        menuMaxHeight: 300,
        style: TextStyle(
          color: textColor,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        borderRadius: BorderRadius.circular(16),
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.circle, size: 10, color: iconColor),
                  const SizedBox(width: 12),
                  Text(
                    item,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        validator: validator,
        selectedItemBuilder: (BuildContext context) {
          return items.map<Widget>((String item) {
            return Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                item,
                style: TextStyle(
                  color: textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList();
        },
      ),
    );
  }
}
