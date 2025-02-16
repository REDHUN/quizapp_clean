import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/core/di/get_it.dart';
import 'package:game_app/core/model/category_model/category_model.dart';
import 'package:game_app/core/theme/app_colors.dart';
import 'package:game_app/features/question_attributes_manage/presentation/bloc/question_attribute_bloc.dart';
import 'package:game_app/features/question_attributes_manage/presentation/bloc/question_attribute_event.dart';
import 'package:game_app/features/question_attributes_manage/presentation/bloc/question_attribute_state.dart';
import 'package:game_app/features/question_attributes_manage/presentation/pages/question_category/widgets/category_shimmer.dart';
import 'widgets/category_add_dialog.dart';
import 'widgets/category_card.dart';
import 'widgets/category_delete_dialog.dart';
import 'widgets/category_edit_dialog.dart';
import 'widgets/category_header.dart';

class QuizCategoryScreen extends StatelessWidget {
  QuizCategoryScreen({super.key});
  static String route = '/questionCategory';
  final List<Map<String, dynamic>> _dummyCategories = [

  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider(

      create: (context) => getIt<QuestionAttributeBloc>()..add(GetQuestionCategory()),
  child: Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.grey[900] : Colors.white,
        title: Text(
          'Categories',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black87),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, size: 28),
            onPressed: () {},
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddDialog(context),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add_circle_outline),
        label: Text(
          'New Category',
          style:  TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: BlocSelector<QuestionAttributeBloc,QuestionAttributeState,( QuestionAttributeStatus, List<CategoryModel>?, )>(
  selector: (state)=> (
    state.status,
    state.categoryList,
  ),
  builder: (context, state) {
    final (status, categories,) = state;
    if (status == QuestionAttributeStatus.loading) {
      return const Center(
        child: CategoryShimmer(),
      );
    }
    else if(status == QuestionAttributeStatus.success){
      return Column(
        children: [
          CategoryHeader(
            totalCategories: _dummyCategories.length,
            activeCategories:
            _dummyCategories.where((c) => c['isActive']).length,
            totalQuestions: _dummyCategories.fold(
                0, (sum, item) => sum + (item['questionCount'] as int)),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount:categories?.length??0,
              itemBuilder: (context, index) {
                final category =categories?[index];
                return CategoryCard(
                  category: category,
                  onToggle: _toggleCategory,
                  onEdit: _showEditDialog,
                  onDelete: _showDeleteDialog,
                );
              },
            ),
          ),
        ],
      );
    }
   else{
      return const Center(
        child: CategoryShimmer(),
      );
    }
  },
),
    ),
);
  }

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black45,
      builder: (context) => const CategoryAddDialog(),
    );
  }

  void _showEditDialog(BuildContext context,CategoryModel ? category) {
    showDialog(
      context: context,
      barrierColor: Colors.black45,
      builder: (context) => CategoryEditDialog(category: category),
    );
  }

  void _showDeleteDialog(BuildContext context, CategoryModel ? category) {
    showDialog(
      context: context,
      barrierColor: Colors.black45,
      builder: (context) => CategoryDeleteDialog(
        category: category,
        onDelete: (name) => _showDeleteSuccessDialog(context, name),
      ),
    );
  }

  void _showDeleteSuccessDialog(BuildContext context, String categoryName) {
    showDialog(
      context: context,
      barrierColor: Colors.black45,
      builder: (context) => Dialog(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey[850]
            : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle_outline,
                  color: AppColors.success,
                  size: 48,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Category Deleted',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '"$categoryName" has been successfully deleted',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.success,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Done',
                    style:  TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleCategory(
      BuildContext context, CategoryModel ? category, bool value) {
    // Toggle category active status logic here
  }
}
