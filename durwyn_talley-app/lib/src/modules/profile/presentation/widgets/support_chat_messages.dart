import '../../../../core/utils/app_exports.dart';
import 'agent_message_bubble.dart';

class SupportChatMessages extends StatelessWidget {
  const SupportChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: AppInsets.only(left: 32, right: 32, top: 16, bottom: 32),
      children: const [AgentMessageBubble()],
    );
  }
}
