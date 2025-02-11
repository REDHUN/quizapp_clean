
import 'package:flutter/material.dart';
import 'package:game_app/core/theme/app_colors.dart';
import 'package:game_app/features/question_manegement/presentation/pages/question_manage/question_edit/controllers/editquestion_controller.dart';
import 'edit_section_card.dart';

class EditAnswerOptionsSection extends StatefulWidget {
  final EditQuestionController controller;
  final String? Function(String?)? validator;

  const EditAnswerOptionsSection({
    super.key,
    required this.controller,
    this.validator,
  });

  @override
  State<EditAnswerOptionsSection> createState() => _EditAnswerOptionsSectionState();
}

class _EditAnswerOptionsSectionState extends State<EditAnswerOptionsSection> {
 List<TextEditingController> _controllers=[];
  @override
  void initState() {
   _controllers = List.generate(
      widget.controller.options.length,
          (index) => TextEditingController(),
    );
   for(int i =0;i<  widget.controller.options.length;i++){
     _controllers[i].text=  widget.controller.options[i];
   }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return EditQuestionSectionCard(
      title: 'Answer Options',
      icon: Icons.list_rounded,
      color: AppColors.accent,
      child: Column(
        children: [
          ...List.generate(
            widget.controller.options.length,
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
