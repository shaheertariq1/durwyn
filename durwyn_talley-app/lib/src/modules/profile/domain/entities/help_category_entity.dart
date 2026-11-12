import 'help_article_entity.dart';

class HelpCategoryEntity {
  const HelpCategoryEntity({
    required this.title,
    required this.icon,
    required this.articles,
  });

  final String title;
  final String icon;
  final List<HelpArticleEntity> articles;
}
