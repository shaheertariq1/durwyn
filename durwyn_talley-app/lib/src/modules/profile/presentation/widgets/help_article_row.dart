import '../../../../core/utils/app_exports.dart';
import '../../domain/entities/help_article_entity.dart';

class HelpArticleRow extends StatelessWidget {
  const HelpArticleRow({
    super.key,
    required this.article,
    required this.isExpanded,
    required this.showDivider,
    required this.onTap,
  });

  final HelpArticleEntity article;
  final bool isExpanded;
  final bool showDivider;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: showDivider
            ? Border(
                bottom: BorderSide(
                  width: 1.085,
                  color: AppColors.primaryWhite.withValues(alpha: 0.1),
                ),
              )
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onTap,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: AppInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      article.question,
                      style: context.labelMediumStyle?.copyWith(
                        fontSize: 14.sp,
                        height: 20 / 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryWhite,
                      ),
                    ),
                  ),
                  12.pw,
                  SvgPicture.asset(
                    isExpanded
                        ? AppAssetsSvg.helpCenterChevronUpIcn
                        : AppAssetsSvg.helpCenterChevronDownIcn,
                    width: 16.w,
                    height: 16.h,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Padding(
              padding: AppInsets.only(left: 16, right: 16, bottom: 16),
              child: Text(
                article.answer,
                style: context.bodyMediumStyle?.copyWith(
                  fontSize: 14.sp,
                  height: 20 / 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.coolGray,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
