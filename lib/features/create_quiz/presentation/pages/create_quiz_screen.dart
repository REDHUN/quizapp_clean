import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/core/theme/app_colors.dart';
import 'package:game_app/core/ui/common_appbar.dart';
import 'package:game_app/features/create_quiz/presentation/bloc/create_quiz_bloc.dart';
import 'package:game_app/features/create_quiz/presentation/bloc/create_quiz_event.dart';
import 'package:game_app/features/create_quiz/presentation/bloc/create_quiz_state.dart';
import 'package:game_app/features/create_quiz/presentation/pages/widgets/create_quiz_success_dialog.dart';

import 'widgets/quiz_form.dart';

class CreateQuizScreen extends StatefulWidget {
  const CreateQuizScreen({super.key});
  static String route = '/createQuiz';

  @override
  State<CreateQuizScreen> createState() => _CreateQuizScreenState();
}

class _CreateQuizScreenState extends State<CreateQuizScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _questionsController = TextEditingController();
  String? _selectedCategory;
  String? _selectedGroup;

  final List<String> _categories = [
    'General Knowledge',
    'Science',
    'Mathematics',
    'History',
    'Geography',
  ];

  final List<String> _groups = [
    'Beginner',
    'Intermediate',
    'Advanced',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _questionsController.dispose();
    super.dispose();
  }

  void _showSuccessDialog() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final buttonColor = isDark ? AppColors.secondary : AppColors.primary;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CreateQuizSuccessDialog(
          buttonColor: buttonColor,
          onPressed: () {
            Navigator.of(context).pop();
            setState(() {
              _formKey.currentState?.reset();
              _titleController.clear();
              _descriptionController.clear();
              _questionsController.clear();
              _selectedCategory = null;
              _selectedGroup = null;
            });
            setState(() {});
          },
        );
      },
    );
  }

  void _createQuiz() {
    if (_formKey.currentState?.validate() ?? false) {
      final title = _titleController.text;
      final description = _descriptionController.text;
      final numberOfQuestions = int.tryParse(_questionsController.text) ?? 0;
      final category = _selectedCategory ?? 'Uncategorized';
      final group = _selectedGroup ?? 'Ungrouped';



    context.read<CreateQuizBloc>().add(
        CreateQuiz(
    quizDescription: description,
          noOfQuestions: numberOfQuestions,
          quizTitle: title,
        ),
      );


    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark
        ? Colors.grey[800] ?? Colors.black
        : Colors.grey[100] ?? Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final iconColor = isDark ? Colors.white : AppColors.primary;
    final buttonColor = isDark ? AppColors.secondary : AppColors.primary;

    return Scaffold(

      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWideScreen = constraints.maxWidth > 600;
          return Center(
            child: Container(
              decoration: BoxDecoration(
                gradient: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.darkGradient
                    : AppColors.primaryGradient,
              ),
              child: SafeArea(
                bottom: false,
                child: BlocListener<CreateQuizBloc, CreateQuizState>(
  listener: (context, state) {
  if(state.status==CreateQuizStatus.success){
    _showSuccessDialog();
  }
  else if(state.status==CreateQuizStatus.error){
    print("error occured");
  }
  },
  child: Column(
                  children: [
                    const CommonAppbar(title: "Create Quiz"),
                    Expanded(
                      child: Container(
                        decoration:  BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(30),
                          ),
                        ),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                              maxWidth: isWideScreen ? 800 : double.infinity),
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(16.0),
                            child: QuizForm(
                              formKey: _formKey,
                              isWideScreen: isWideScreen,
                              titleController: _titleController,
                              descriptionController: _descriptionController,
                              questionsController: _questionsController,
                              selectedCategory: _selectedCategory,
                              selectedGroup: _selectedGroup,
                              categories: _categories,
                              groups: _groups,
                              backgroundColor: backgroundColor,
                              textColor: textColor,
                              iconColor: iconColor,
                              buttonColor: buttonColor,
                              onCategoryChanged: (value) {
                                setState(() {
                                  _selectedCategory = value;
                                });
                                _formKey.currentState?.validate();
                              },
                              onGroupChanged: (value) {
                                setState(() {
                                  _selectedGroup = value;
                                });
                                _formKey.currentState?.validate();
                              },
                              onSubmit: _createQuiz,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
),
              ),
            ),
          );
        },
      ),
    );
  }
}
