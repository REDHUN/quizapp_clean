import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/features/question_manegement/domain/model/question_type_model/question_type_model.dart';
import 'package:game_app/features/question_manegement/presentation/bloc/question_manage/question_manage_bloc.dart';
import 'package:game_app/features/question_manegement/presentation/bloc/question_manage/question_manage_event.dart';
import 'package:game_app/features/question_manegement/presentation/bloc/question_manage/question_manage_state.dart';

import '../controllers/editquestion_controller.dart';

class EditQuestionTypeDropdown extends StatelessWidget {
  final EditQuestionController controller;
  final String? Function(String?)? validator;
  final List<QuestionTypeModel> questionTypeList;

  const EditQuestionTypeDropdown({
    super.key,
    required this.controller,
    required this.questionTypeList,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<QuestionManageBloc, QuestionManageState, String?>(
      selector: (state) => state.selectedQuestionTypeId?.toString(),
      builder: (context, selectedQuestionTypeId) {
        return DropdownButtonFormField<String>(
          value:  controller.questionType,
          onChanged: (value) {
            if (value != null) {
              controller.questionType=value;
              context.read<QuestionManageBloc>().add(SelectQuestionTypeId(questiontypeId: value));
            }
          },
          validator: validator,
          items: questionTypeList
              .map((type) => DropdownMenuItem(
            value: type.id.toString(),
            child: Text(type.name ?? ""),
          ))
              .toList(),
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).cardColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        );
      },
    );
  }
}