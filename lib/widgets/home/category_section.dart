import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/home_provider.dart';
import 'category_card.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final home = context.watch<HomeProvider>();
    final categories = home.categories;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 14),
          child: Text(
            'Categories',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        if (categories.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Center(
              child: Text('No categories available.'),
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 1.0,
              ),
              itemBuilder: (context, index) {
                final category = categories[index];
                return CategoryCard(
                  category: category,
                  questionCount: home.questionCountFor(category.id),
                  onTap: () => context.push('/quiz', extra: category),
                );
              },
            ),
          ),
      ],
    );
  }
}
