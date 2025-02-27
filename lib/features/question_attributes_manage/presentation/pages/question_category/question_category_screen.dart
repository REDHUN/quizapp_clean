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
    final isDark = Theme
        .of(context)
        .brightness == Brightness.dark;

    return Scaffold(
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
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: BlocBuilder<QuestionAttributeBloc, QuestionAttributeState>(
        buildWhen: (previous, current) =>
        // Only rebuild for initial load or when category list changes
        previous.categoryList != current.categoryList ||
            (previous.status == QuestionAttributeStatus.initial &&
                current.status == QuestionAttributeStatus.loading),
        builder: (context, state) {
          if (state.status == QuestionAttributeStatus.loading &&
              state.categoryList == null) {
            return const Center(
              child: CategoryShimmer(),
            );
          }

          final categories = state.categoryList ?? [];
          return Column(
            children: [
              CategoryHeader(
                totalCategories: categories.length,
                activeCategories: categories
                    .where((c) => c.isActive == "Y")
                    .length,
                totalQuestions: 0,
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
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
        },
      ),
    );
  }

  void _showAddDialog(BuildContext context) async {
    final bloc = context.read<QuestionAttributeBloc>();
    await showDialog(
      context: context,
      barrierColor: Colors.black45,
      builder: (dialogContext) =>
          BlocProvider.value(
            value: bloc, // Use the same bloc instance
            child: CategoryAddDialog(),
          ),
    );
  }

  void _showEditDialog(BuildContext context, CategoryModel? category) async {
    final bloc = context.read<QuestionAttributeBloc>();
    await showDialog(
      context: context,
      barrierColor: Colors.black45,
      builder: (dialogContext) =>
          BlocProvider.value(
            value: bloc, // Use the same bloc instance
            child: CategoryEditDialog(category: category),
          ),
    );
  }
  void _showDeleteDialog(BuildContext context, CategoryModel? category) async {
    if (category == null) return;

    final bloc = context.read<QuestionAttributeBloc>();
    bloc.add(IsCategoryUsed(categoryId: category.id));

    // Show loading dialog first
    await showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      barrierColor: Colors.black45,
      builder: (dialogContext) => BlocProvider.value(
        value: bloc,
        child: BlocConsumer<QuestionAttributeBloc, QuestionAttributeState>(
          listenWhen: (previous, current) =>
          previous.isCategoryUsed != current.isCategoryUsed ||
              previous.status != current.status,
          listener: (context, state) {
            debugPrint("Category usage state: ${state.isCategoryUsed}");

            if (state.isCategoryUsed == true) {
              Navigator.of(dialogContext).pop(); // Close loading dialog
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Cannot delete category as it is being used'),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state.isCategoryUsed == false) {
              Navigator.of(dialogContext).pop(); // Close loading dialog

              // Show delete confirmation dialog
              showDialog(
                context: context,
                barrierDismissible: true,
                barrierColor: Colors.black45,
                builder: (_) => BlocProvider.value(
                  value: bloc,
                  child: CategoryDeleteDialog(
                    category: category,

                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            return const Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );


  }



  void _showDeleteSuccessDialog(BuildContext context, String categoryName) {
    showDialog(
      context: context,
      barrierColor: Colors.black45,
      builder: (context) =>
          Dialog(
            backgroundColor: Theme
                .of(context)
                .brightness == Brightness.dark
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
                        style: TextStyle(
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


  void _showCategoryUsedAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text('Category in Use'),
            content: Text(
                'This category is currently being used and cannot be deleted.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
    );
  }

  void _toggleCategory(BuildContext context, CategoryModel ? category,
      bool value) {

  }
}
