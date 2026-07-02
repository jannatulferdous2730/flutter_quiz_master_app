import 'package:flutter/material.dart';
import '../../models/category_model.dart';
import '../../theme/app_colors.dart';
import '../../utils/category_icon_helper.dart';

class CategoryCard extends StatefulWidget {
  final CategoryModel category;
  final int questionCount;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.category,
    required this.questionCount,
    required this.onTap,
  });

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  // Predefined color palettes per category id for visual variety.
  static const _colorMap = {
    9: (Color(0xFF6C63FF), Color(0xFF9D97FF)),   // General: indigo
    17: (Color(0xFF10B981), Color(0xFF6EE7B7)),   // Science & Nature: green
    18: (Color(0xFF3B82F6), Color(0xFF93C5FD)),   // Computers: blue
    21: (Color(0xFFFF6584), Color(0xFFFFA0B5)),   // Sports: coral
    22: (Color(0xFFF59E0B), Color(0xFFFCD34D)),   // Geography: amber
    23: (Color(0xFF8B5CF6), Color(0xFFC4B5FD)),   // History: purple
  };

  (Color, Color) get _colors {
    final pair = _colorMap[widget.category.id];
    return pair ?? (AppColors.primary, AppColors.primaryLight);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.95,
      upperBound: 1.0,
    )..value = 1.0;
    _scaleAnimation = _controller;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final (base, light) = _colors;
    final icon = CategoryIconHelper.getIcon(
      id: widget.category.id,
      name: widget.category.name,
    );

    return GestureDetector(
      onTapDown: (_) => _controller.reverse(),
      onTapUp: (_) {
        _controller.forward();
        widget.onTap();
      },
      onTapCancel: () => _controller.forward(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [base, light],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: base.withOpacity(0.35),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: Colors.white, size: 26),
              ),
              const Spacer(),
              Text(
                widget.category.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${widget.questionCount} Questions',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
