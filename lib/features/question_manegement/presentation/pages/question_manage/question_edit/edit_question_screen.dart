import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/core/di/get_it.dart';
import 'package:game_app/core/model/quiz_question_model/quiz_question_model.dart';
import 'package:game_app/features/question_manegement/domain/model/category_model/category_model.dart';
import 'package:game_app/features/question_manegement/domain/model/difficaulty_model/difficulty_model.dart';
import 'package:game_app/features/question_manegement/domain/model/question_type_model/question_type_model.dart';

import 'package:game_app/features/question_manegement/presentation/bloc/question_manage/question_manage_bloc.dart';
import 'package:game_app/features/question_manegement/presentation/bloc/question_manage/question_manage_event.dart';
import 'package:game_app/features/question_manegement/presentation/bloc/question_manage/question_manage_state.dart';
import 'package:game_app/features/question_manegement/presentation/pages/question_manage/question_edit/controllers/editquestion_controller.dart';
import 'package:game_app/features/question_manegement/presentation/pages/question_manage/question_edit/widgets/edit_preview_button.dart';
import 'package:game_app/features/question_manegement/presentation/pages/question_manage/question_edit/widgets/edit_question_form.dart';

class EditQuestionScreen extends StatefulWidget {
  final QuizQuestionModel questionModel;

  const EditQuestionScreen({super.key, required this.questionModel});

  static String route = '/questionEdit';

  @override
  State<EditQuestionScreen> createState() => _EditQuestionScreenState();
}

class _EditQuestionScreenState extends State<EditQuestionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = EditQuestionController();
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeQuestionData();
  }

  void _initializeQuestionData() {
    if (!_isInitialized) {
      _controller.options = widget.questionModel.options
             ;
      _controller.questionText = widget.questionModel.question ?? "";
      _controller.questionType =
          widget.questionModel.questionTypeId.toString() ?? "";
      _controller.category = widget.questionModel.categoryId.toString() ?? "";
      _controller.difficulty =
          widget.questionModel.difficultyId.toString() ?? "";

      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider(
      create: (context) =>
          getIt<QuestionManageBloc>()..add(FetchQuestionData()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Question'),
          elevation: 0,
        ),
        body: BlocBuilder<QuestionManageBloc, QuestionManageState>(
          builder: (context, state) {
            if (state.status == QuestionManageStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.categoryList == null ||
                state.questionDifficultyList == null ||
                state.questionTypeList == null) {
              return _buildErrorState();
            }

            return _buildEditForm(state, isDark);
          },
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Failed to load required data',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () =>
                context.read<QuestionManageBloc>().add(FetchQuestionData()),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildEditForm(QuestionManageState state, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? [Colors.grey[900]!, Colors.grey[850]!]
              : [Colors.grey[100]!, Colors.grey[50]!],
        ),
      ),
      child: Stack(
        children: [
          EditQuestionForm(
            options: widget.questionModel.options,
            correctAnswerId: widget.questionModel.correctAnswerId,
            questionDifficultyList: state.questionDifficultyList!,
            questionCategoryList: state.categoryList!,
            questionTypeList: state.questionTypeList!,
            formKey: _formKey,
            controller: _controller,
          ),
          EditPreviewButton(
            questionId: widget.questionModel.id??0,
            difficultyName: state.questionDifficultyList
                ?.firstWhere(
                  (difficulty) =>
                      difficulty.id.toString() == _controller.difficulty,
                  orElse: () => DifficultyModel(),
                )
                .name,
            categoryName: state.categoryList
                ?.firstWhere(
                  (category) => category.id.toString() == _controller.category,
                  orElse: () => CategoryModel(),
                )
                .name,
            questionTypeName: state.questionTypeList
                ?.firstWhere(
                  (questionType) =>
                      questionType.id.toString() == _controller.category,
                  orElse: () => QuestionTypeModel(),
                )
                .name,
            formKey: _formKey,
            controller: _controller,
          ),
        ],
      ),
    );
  }
}
