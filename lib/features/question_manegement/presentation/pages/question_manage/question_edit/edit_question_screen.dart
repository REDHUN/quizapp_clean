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
    _loadInitialData();
  }

  void _loadInitialData() {
    final bloc = context.read<QuestionManageBloc>();
    if (!_isInitialized) {
      print("The question is ${widget.questionModel.question??""}");
      _controller.options = widget.questionModel.options
              ?.map((option) => option.text)
              .whereType<String>() // Removes any null values
              .toList() ??
          [];
      _controller.questionText= widget.questionModel.question ?? "";
      _controller.questionType = bloc.state.selectedQuestionTypeId ?? "";
      print("The question is ${  _controller.questionText??""}");
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Question'),
        elevation: 0,
      ),
      body: BlocSelector<
          QuestionManageBloc,
          QuestionManageState,
          (
            QuestionManageStatus,
            List<CategoryModel>?,
            List<DifficultyModel>?,
            List<QuestionTypeModel>?
          )>(
        selector: (state) => (
          state.status,
          state.categoryList,
          state.questionDifficultyList,
          state.questionTypeList,
        ),
        builder: (context, data) {
          final (status, categories, difficulties, types) = data;

          // Show loading when any of the required data is being fetched
          if (status == QuestionManageStatus.loading ||
              (status == QuestionManageStatus.initial && !_isInitialized)) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Show error if any of the required data is missing
          if (categories == null || difficulties == null || types == null) {
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
                    onPressed: _loadInitialData,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          // Show the form when all data is available
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
                  questionDifficultyList: difficulties,
                  questionCategoryList: categories,
                  questionTypeList: types,
                  formKey: _formKey,
                  controller: _controller,
                ),
                EditPreviewButton(
                  formKey: _formKey,
                  controller: _controller,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
