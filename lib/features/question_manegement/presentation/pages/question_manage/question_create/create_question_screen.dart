import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/core/di/get_it.dart';
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

  @override
  void initState() {
    super.initState();

    /// Dispatching multiple events after the widget is built
    Future.microtask(() {

      context.read<QuestionManageBloc>().add(GetQuestionCategory());
      context.read<QuestionManageBloc>().add(GetQuestionDifficulty());
      context.read<QuestionManageBloc>().add(GetQuestionType());

    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Question'),
        elevation: 0,
      ),
      body: BlocBuilder<QuestionManageBloc, QuestionManageState>(
        builder: (context, state) {
          if (state.status == QuestionManageStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status == QuestionManageStatus.success) {
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
                    questionDifficultyList: state.questionDifficultyList??[],
                    questionCategoryList: state.categoryList??[],
                    questionTypeList: state.questionTypeList ?? [],
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
          } else {
            return const Center(
              child: Text(
                'No data available',
                style: TextStyle(fontSize: 16),
              ),
            );
          }
        },
      ),
    );
  }
}
