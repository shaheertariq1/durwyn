import '../../../../core/utils/app_exports.dart';
import '../controller/profile_controller.dart';
import '../widgets/help_category_section.dart';
import '../widgets/help_center_header.dart';
import '../widgets/help_search_field.dart';
import '../widgets/no_help_results.dart';

class HelpCenterView extends ConsumerWidget {
  const HelpCenterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(profileControllerProvider);
    final categories = controller.visibleHelpCategories;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.dashboardBackground,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: AppInsets.only(left: 32, right: 32, top: 24, bottom: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HelpCenterHeader(),
                24.ph,
                HelpSearchField(
                  controller: controller.helpSearchController,
                  onChanged: controller.onHelpQueryChanged,
                ),
                16.ph,
                if (categories.isEmpty)
                  const NoHelpResults()
                else
                  for (var index = 0; index < categories.length; index++) ...[
                    HelpCategorySection(
                      category: categories[index],
                      expandedQuestion: controller.expandedHelpQuestion,
                      onArticleTap: controller.toggleHelpArticle,
                    ),
                    if (index != categories.length - 1) 16.ph,
                  ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
