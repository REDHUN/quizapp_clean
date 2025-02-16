import 'package:flutter/material.dart';
import 'package:game_app/core/model/category_model/category_model.dart';
import 'package:game_app/core/theme/app_colors.dart';


class CategoryEditDialog extends StatelessWidget {
  final CategoryModel ? category;

  const CategoryEditDialog({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      backgroundColor: isDark ? Colors.grey[850] : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.edit_outlined,
                  color: AppColors.primary,
                  size: 28,
                ),
                const SizedBox(width: 16),
                Text(
                  'Edit Category',
                  style:  TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            TextField(
              controller: TextEditingController(text: category?.name??""),
              autofocus: true,
              style:  TextStyle(
                fontSize: 16,
                color: isDark ? Colors.white : Colors.black87,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: isDark ? Colors.grey[800] : Colors.white,
                hintText: 'Enter category name',
                hintStyle:  TextStyle(
                  color: isDark ? Colors.grey[400] : Colors.grey[500],
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: isDark ? Colors.grey[700]! : Colors.grey[200]!,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: isDark ? Colors.grey[700]! : Colors.grey[200]!,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AppColors.primary,
                    width: 2,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.category_outlined,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildStatusToggle(context, isDark),
            const SizedBox(height: 24),
            _buildActionButtons(context, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusToggle(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.grey[700]! : Colors.grey[200]!,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.toggle_on_outlined,
            color: AppColors.primary,
            size: 24,
          ),
          const SizedBox(width: 12),
          Text(
            'Active Status',
            style:  TextStyle(
              fontSize: 16,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const Spacer(),
          Switch.adaptive(
            value: true,
            onChanged: (value) {},
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Text(
              'Cancel',
              style:  TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.grey[300] : Colors.black54,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: Text(
            'Save Changes',
            style:  TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
