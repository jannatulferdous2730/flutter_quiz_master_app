import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../../theme/app_colors.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return IconButton(
      tooltip: themeProvider.isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
      onPressed: themeProvider.toggleTheme,
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) => RotationTransition(
          turns: animation,
          child: FadeTransition(opacity: animation, child: child),
        ),
        child: Icon(
          themeProvider.isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
          key: ValueKey(themeProvider.isDark),
          color: AppColors.primary,
        ),
      ),
    );
  }
}
