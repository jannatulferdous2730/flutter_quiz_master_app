import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/category_model.dart';
import '../models/quiz_result_model.dart';
import '../screens/home_screen.dart';
import '../screens/quiz_screen.dart';
import '../screens/result_screen.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const HomeScreen(),
          transitionsBuilder: _fadeTransition,
        ),
      ),
      GoRoute(
        path: '/quiz',
        name: 'quiz',
        pageBuilder: (context, state) {
          final category = state.extra as CategoryModel;
          return CustomTransitionPage(
            key: state.pageKey,
            child: QuizScreen(category: category),
            transitionsBuilder: _slideTransition,
          );
        },
      ),
      GoRoute(
        path: '/result',
        name: 'result',
        pageBuilder: (context, state) {
          final result = state.extra as QuizResultModel;
          return CustomTransitionPage(
            key: state.pageKey,
            child: ResultScreen(result: result),
            transitionsBuilder: _slideTransition,
          );
        },
      ),
    ],
  );

  static Widget _fadeTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
      child: child,
    );
  }

  static Widget _slideTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
      child: child,
    );
  }
}
