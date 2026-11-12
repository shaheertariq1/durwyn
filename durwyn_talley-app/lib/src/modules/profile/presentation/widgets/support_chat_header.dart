import '../../../../core/utils/app_exports.dart';
import 'support_agent_status.dart';

class SupportChatHeader extends StatelessWidget {
  const SupportChatHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.dashboardCardBg,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: AppInsets.only(left: 32, right: 32, top: 12, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: AppRouterGo.back,
                behavior: HitTestBehavior.opaque,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      AppAssetsSvg.helpCenterBackIcn,
                      width: 20.w,
                      height: 20.h,
                    ),
                    8.pw,
                    Text(
                      AppStrings.back,
                      style: context.labelMediumStyle?.copyWith(
                        fontSize: 16.sp,
                        height: 24 / 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryWhite,
                      ),
                    ),
                  ],
                ),
              ),
              10.ph,
              const SupportAgentStatus(),
            ],
          ),
        ),
      ),
    );
  }
}
