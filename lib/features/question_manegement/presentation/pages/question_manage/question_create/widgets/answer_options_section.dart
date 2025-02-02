
import 'package:flutter/material.dart';
import 'package:game_app/core/theme/app_colors.dart';
import 'package:game_app/features/question_manegement/presentation/pages/question_manage/question_create/controllers/question_controller.dart';
import 'section_card.dart';

class AnswerOptionsSection extends StatefulWidget {
  final QuestionController controller;
  final String? Function(String?)? validator;

  const AnswerOptionsSection({
    super.key,
    required this.controller,
    this.validator,
  });

  @override
  State<AnswerOptionsSection> createState() => _AnswerOptionsSectionState();
}

class _AnswerOptionsSectionState extends State<AnswerOptionsSection> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Answer Options',
      icon: Icons.list_rounded,
      color: AppColors.accent,
      child: Column(
        children: [
          ...List.generate(
            4,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Radio<int>(
                    value: index,
                    groupValue: widget.controller.correctAnswerIndex,
                    onChanged: (value) {
                      setState(() {
                        widget.controller.correctAnswerIndex = value;
                      });
                    },
                    activeColor: AppColors.success,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _controllers[index],
                      onChanged: (value) {
                        widget.controller.options[index] = value;
                      },
                      validator: widget.validator,
                      decoration: InputDecoration(
                        hintText: 'Option ${index + 1}',
                        filled: true,
                        fillColor: Theme.of(context).cardColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        errorStyle: const TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (widget.controller.correctAnswerIndex == null)
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                'Please select a correct answer',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
            ),
          const SizedBox(height: 8),
          Text(
            'Select the radio button next to the correct answer',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
