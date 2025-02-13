import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/core/di/get_it.dart';
import 'package:game_app/core/theme/app_colors.dart';
import 'package:game_app/features/question_manegement/domain/model/category_model/category_model.dart';
import 'package:game_app/features/question_manegement/domain/model/difficaulty_model/difficulty_model.dart';
import 'package:game_app/features/question_manegement/domain/model/question_type_model/question_type_model.dart';
import 'package:game_app/features/question_manegement/presentation/bloc/question_manage/question_manage_bloc.dart';
import 'package:game_app/features/question_manegement/presentation/bloc/question_manage/question_manage_event.dart';
import 'package:game_app/features/question_manegement/presentation/bloc/question_manage/question_manage_state.dart';
import 'package:game_app/features/question_manegement/presentation/pages/question_manage/question_edit/edit_question_screen.dart';

import 'widgets/question_filter.dart';
import 'widgets/question_list_item.dart';

class QuestionViewScreen extends StatefulWidget {
  const QuestionViewScreen({super.key});

  static String route = '/questionView';

  @override
  State<QuestionViewScreen> createState() => _QuestionViewScreenState();
}

class _QuestionViewScreenState extends State<QuestionViewScreen> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider(
      create: (context) =>
      getIt<QuestionManageBloc>()..add(FetchQuestionData())..add(GetAllQuestions()),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: isDark ? AppColors.darkGradient : AppColors.primaryGradient,
          ),
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                _buildHeader(context),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 24),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(32),
                      ),
                    ),
                    child: BlocBuilder<QuestionManageBloc, QuestionManageState>(
                      builder: (context, state) {
                        if (state.status == QuestionManageStatus.loading) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        if (state.status == QuestionManageStatus.error) {
                          return Center(
                            child: Text(state.errorMessage ?? 'Failed to load data'),
                          );
                        }

                        return Column(
                          children: [
                            _buildSearchBar(context),
                            QuestionFilter(), // Ensure this does not require loading state
                            Expanded(
                              child: state.questionList == null || state.questionList!.isEmpty
                                  ? _buildEmptyState()
                                  : ListView.builder(
                                padding: const EdgeInsets.all(16),
                                itemCount: state.questionList!.length,
                                itemBuilder: (context, index) {
                                  final question = state.questionList![index];
                                  return QuestionListItem(
                                    question: question.question ?? "",
                                    category: question.categoryName ?? 'Unknown',
                                    difficulty: question.dificaltyName ?? 'Unknown',
                                    type: question.questionTypeName ?? 'Unknown',
                                    options: question.options ?? [],
                                    correctAnswerAnswerId: question.correctAnswerId ?? 0,
                                    lastModified: DateTime.now(),
                                    onEdit: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) {
                                          return EditQuestionScreen(questionModel: question);
                                        },
                                      ));
                                    },
                                    onDelete: () {
                                      // Implement delete functionality
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const Expanded(
            child: Text(
              'Question Bank',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search questions...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () {},
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Theme.of(context).cardColor,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
        onChanged: (value) => setState(() {}),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.quiz_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No questions found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add your first question to get started',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
