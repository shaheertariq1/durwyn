import '../../../../core/utils/app_exports.dart';

class SupportChatComposer extends StatelessWidget {
  const SupportChatComposer({
    super.key,
    required this.controller,
    required this.canSend,
    required this.onSend,
  });

  final TextEditingController controller;
  final bool canSend;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppInsets.only(left: 24, right: 24, top: 25, bottom: 24),
      decoration: BoxDecoration(
        color: AppColors.dashboardCardBg,
        border: Border(
          top: BorderSide(
            width: 1.085,
            color: AppColors.primaryWhite.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 52.h,
              child: TextField(
                controller: controller,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => onSend(),
                cursorColor: AppColors.primaryWhite,
                style: context.bodyMediumStyle?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryWhite,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  hintText: AppStrings.supportChatMessageHint,
                  hintStyle: context.bodyMediumStyle?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.coolGray,
                  ),
                  contentPadding: AppInsets.symmetric(
                    horizontal: 17,
                    vertical: 17,
                  ),
                  filled: true,
                  fillColor: AppColors.supportChatInputBg,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: 16.circular,
                    borderSide: BorderSide(
                      width: 1.085,
                      color: AppColors.primaryWhite.withValues(alpha: 0.1),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: 16.circular,
                    borderSide: BorderSide(
                      width: 1.085,
                      color: AppColors.primaryWhite.withValues(alpha: 0.2),
                    ),
                  ),
                ),
              ),
            ),
          ),
          12.pw,
          Semantics(
            button: true,
            enabled: canSend,
            label: AppStrings.supportChatSendMessage,
            child: GestureDetector(
              onTap: canSend ? onSend : null,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 150),
                opacity: canSend ? 1 : 0.4,
                child: Container(
                  width: 44.w,
                  height: 44.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.successGreen,
                    borderRadius: 16.circular,
                  ),
                  child: SvgPicture.asset(
                    AppAssetsSvg.supportChatSendIcn,
                    width: 20.w,
                    height: 20.h,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
