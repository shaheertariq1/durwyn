import '../../../../core/utils/app_exports.dart';
import '../../domain/entities/help_category_entity.dart';
import 'help_article_row.dart';

class HelpCategorySection extends StatelessWidget {
  const HelpCategorySection({
    super.key,
    required this.category,
    required this.expandedQuestion,
    required this.onArticleTap,
  });

  final HelpCategoryEntity category;
  final String? expandedQuestion;
  final ValueChanged<String> onArticleTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(category.icon, width: 16.w, height: 16.h),
            8.pw,
            Text(
              category.title,
              style: context.labelMediumStyle?.copyWith(
                fontSize: 14.sp,
                height: 20 / 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.7,
                color: AppColors.coolGray,
              ),
            ),
          ],
        ),
        10.ph,
        Container(
          width: double.infinity,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: AppColors.dashboardCardBg,
            borderRadius: 16.circular,
            border: Border.all(
              width: 1.085,
              color: AppColors.primaryWhite.withValues(alpha: 0.1),
            ),
          ),
          child: Column(
            children: [
              for (var index = 0; index < category.articles.length; index++)
                HelpArticleRow(
                  article: category.articles[index],
                  isExpanded:
                      expandedQuestion == category.articles[index].question,
                  showDivider: index != category.articles.length - 1,
                  onTap: () => onArticleTap(category.articles[index].question),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
