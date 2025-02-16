import 'package:flutter/material.dart';
import 'package:game_app/core/model/category_model/category_model.dart';
import 'package:game_app/core/theme/app_colors.dart';


class CategoryCard extends StatelessWidget {
  final CategoryModel ? category;
  final Function(BuildContext, CategoryModel?, bool) onToggle;
  final Function(BuildContext, CategoryModel?) onEdit;
  final Function(BuildContext, CategoryModel?) onDelete;

  const CategoryCard({
    super.key,
   this.category,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = true;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Material(
          color: Colors.white,
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            leading: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: (isActive ? AppColors.primary : Colors.grey)
                    .withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.category_outlined,
                color: isActive ? AppColors.primary : Colors.grey,
                size: 24,
              ),
            ),
            title: Text(
             category?.name??"",
              style:  TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                // Container(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                //   decoration: BoxDecoration(
                //     color: Colors.grey.withOpacity(0.1),
                //     borderRadius: BorderRadius.circular(6),
                //   ),
                //   child: Text(
                //     '${category['questionCount']} Questions',
                //     style:  TextStyle(
                //       fontSize: 12,
                //       color: Colors.black54,
                //     ),
                //   ),
                // ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Switch.adaptive(
                  value: isActive,
                  onChanged: (value) => onToggle(context, category, value),
                  activeColor: AppColors.primary,
                ),
                _buildIconButton(
                  icon: Icons.edit_outlined,
                  color: AppColors.primary,
                  onTap: () => onEdit(context, category),
                ),
                _buildIconButton(
                  icon: Icons.delete_outline,
                  color: AppColors.error,
                  onTap: () => onDelete(context, category),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(icon, color: color, size: 22),
        ),
      ),
    );
  }
}
