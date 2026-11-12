import '../../../../core/utils/app_exports.dart';
import '../controller/profile_controller.dart';
import '../widgets/support_chat_composer.dart';
import '../widgets/support_chat_header.dart';
import '../widgets/support_chat_messages.dart';

class SupportChatView extends ConsumerWidget {
  const SupportChatView({super.key});

  void _sendMessage(BuildContext context, ProfileController controller) {
    if (!controller.canSendSupportMessage) return;
    controller.sendSupportMessage();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(profileControllerProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.dashboardBackground,
        body: Column(
          children: [
            const SupportChatHeader(),
            const Expanded(child: SupportChatMessages()),
            SupportChatComposer(
              controller: controller.supportMessageController,
              canSend: controller.canSendSupportMessage,
              onSend: () => _sendMessage(context, controller),
            ),
          ],
        ),
      ),
    );
  }
}
