import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/core/di/get_it.dart';
import 'package:game_app/features/question_manegement/domain/model/category_model/category_model.dart';
import 'package:game_app/features/question_manegement/domain/model/difficaulty_model/difficulty_model.dart';
import 'package:game_app/features/question_manegement/domain/model/question_type_model/question_type_model.dart';
import 'package:game_app/features/question_manegement/presentation/bloc/question_manage/question_manage_bloc.dart';
import 'package:game_app/features/question_manegement/presentation/bloc/question_manage/question_manage_event.dart';
import 'package:game_app/features/question_manegement/presentation/bloc/question_manage/question_manage_state.dart';

import 'controllers/question_controller.dart';
import 'widgets/preview_button.dart';
import 'widgets/question_form.dart';

class CreateQuestionScreen extends StatefulWidget {
  const CreateQuestionScreen({super.key});

  static String route = '/questionCreate';

  @override
  State<CreateQuestionScreen> createState() => _CreateQuestionScreenState();
}

class _CreateQuestionScreenState extends State<CreateQuestionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = QuestionController();
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  void _loadInitialData() {
    if (!_isInitialized) {
      _isInitialized = true;
      Future.microtask(() {
        final bloc = context.read<QuestionManageBloc>();
        bloc.add(ResetQuestionManageState());
        bloc.add(GetQuestionCategory());
        bloc.add(GetQuestionDifficulty());
        bloc.add(GetQuestionType());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Question'),
        elevation: 0,
      ),
      body: BlocSelector<QuestionManageBloc, QuestionManageState,
          (QuestionManageStatus, List<CategoryModel>?, List<DifficultyModel>?, List<QuestionTypeModel>?)>(
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
                QuestionForm(
                  questionDifficultyList: difficulties,
                  questionCategoryList: categories,
                  questionTypeList: types,
                  formKey: _formKey,
                  controller: _controller,
                ),
                PreviewButton(
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