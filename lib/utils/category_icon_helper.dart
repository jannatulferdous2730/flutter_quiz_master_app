import 'package:flutter/material.dart';

/// Maps a category name or id to a suitable [IconData].
class CategoryIconHelper {
  CategoryIconHelper._();

  static IconData getIcon({required int id, required String name}) {
    // Match by id first (most reliable).
    switch (id) {
      case 9:
        return Icons.psychology_rounded; // General Knowledge
      case 17:
        return Icons.science_rounded; // Science & Nature
      case 18:
        return Icons.computer_rounded; // Science: Computers
      case 21:
        return Icons.sports_basketball_rounded; // Sports
      case 22:
        return Icons.public_rounded; // Geography
      case 23:
        return Icons.history_edu_rounded; // History
      default:
        break;
    }

    // Fallback: match by name substring (case-insensitive).
    final lower = name.toLowerCase();
    if (lower.contains('sport')) return Icons.sports_rounded;
    if (lower.contains('science') || lower.contains('nature')) return Icons.science_rounded;
    if (lower.contains('computer') || lower.contains('tech')) return Icons.computer_rounded;
    if (lower.contains('history')) return Icons.history_edu_rounded;
    if (lower.contains('geography') || lower.contains('geo')) return Icons.public_rounded;

    return Icons.quiz_rounded; // default fallback
  }
}
