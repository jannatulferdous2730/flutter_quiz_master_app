import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/home_provider.dart';
import '../widgets/common/loading_view.dart';
import '../widgets/home/welcome_section.dart';
import '../widgets/home/stats_section.dart';
import '../widgets/home/category_section.dart';
import '../widgets/home/history_section.dart';
import '../widgets/home/theme_toggle_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load after the first frame so context.read is safe.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().loadDashboardData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<HomeProvider>().isLoading;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Quiz Master'),
        actions: const [
          ThemeToggleButton(),
          SizedBox(width: 8),
        ],
      ),
      body: isLoading
          ? const LoadingView(message: 'Loading dashboard…')
          : const SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WelcomeSection(),
                  StatsSection(),
                  CategorySection(),
                  HistorySection(),
                ],
              ),
            ),
    );
  }
}
