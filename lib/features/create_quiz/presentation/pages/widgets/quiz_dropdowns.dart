import 'package:flutter/material.dart';
import 'package:game_app/features/create_quiz/presentation/pages/widgets/create_quiz_custom_dropdown.dart';


class QuizDropdowns extends StatelessWidget {
  final String? selectedCategory;
  final String? selectedGroup;
  final List<String> categories;
  final List<String> groups;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final Function(String?) onCategoryChanged;
  final Function(String?) onGroupChanged;
  final bool isWide;

  const QuizDropdowns({
    super.key,
    required this.selectedCategory,
    required this.selectedGroup,
    required this.categories,
    required this.groups,
    required this.backgroundColor,
    required this.textColor,
    required this.iconColor,
    required this.onCategoryChanged,
    required this.onGroupChanged,
  }) : isWide = false;

  const QuizDropdowns.wide({
    super.key,
    required this.selectedCategory,
    required this.selectedGroup,
    required this.categories,
    required this.groups,
    required this.backgroundColor,
    required this.textColor,
    required this.iconColor,
    required this.onCategoryChanged,
    required this.onGroupChanged,
  }) : isWide = true;

  @override
  Widget build(BuildContext context) {
    if (isWide) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildCategoryDropdown(),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildGroupDropdown(),
              ),
            ],
          ),
        ],
      );
    }

    return Column(
      children: [
        _buildCategoryDropdown(),
        const SizedBox(height: 16),
        _buildGroupDropdown(),
      ],
    );
  }

  Widget _buildCategoryDropdown() {
    return CreateQuizCustomDropdown(
      value: selectedCategory,
      label: 'Select Category',
      icon: Icons.category,
      backgroundColor: backgroundColor,
      textColor: textColor,
      iconColor: iconColor,
      items: categories,
      onChanged: onCategoryChanged,
    );
  }

  Widget _buildGroupDropdown() {
    return CreateQuizCustomDropdown(
      value: selectedGroup,
      label: 'Select Group',
      icon: Icons.group,
      backgroundColor: backgroundColor,
      textColor: textColor,
      iconColor: iconColor,
      items: groups,
      onChanged: onGroupChanged,
    );
  }
}
