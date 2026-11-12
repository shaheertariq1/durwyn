import '../core/utils/app_exports.dart';

class UserAvatar extends ConsumerWidget {
  const UserAvatar({
    super.key,
    required this.size,
    this.fullName,
    this.avatarUrl,
    this.borderWidth,
    this.borderColor,
  });

  final double size;
  final String? fullName;
  final String? avatarUrl;
  final double? borderWidth;
  final Color? borderColor;

  String _getInitials(String? name) {
    if (name == null || name.trim().isEmpty) return 'U';
    final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    } else if (parts.isNotEmpty && parts[0].isNotEmpty) {
      return parts[0].substring(0, parts[0].length >= 2 ? 2 : 1).toUpperCase();
    }
    return 'U';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localAvatar = ref.watch(
      profileAvatarControllerProvider.select((c) => c.avatar),
    );

    final resolvedBorderColor =
        borderColor ?? AppColors.successGreen.withValues(alpha: 0.5);
    final resolvedBorderWidth = borderWidth ?? (size > 60 ? 2.0 : 1.5);

    Widget imageContent;

    if (localAvatar != null && localAvatar.existsSync()) {
      imageContent = Image.file(
        localAvatar,
        width: size,
        height: size,
        fit: BoxFit.cover,
      );
    } else if (avatarUrl != null &&
        avatarUrl!.trim().isNotEmpty &&
        avatarUrl!.startsWith('http')) {
      imageContent = Image.network(
        avatarUrl!.trim(),
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _buildInitialsFallback(),
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return _buildInitialsFallback();
        },
      );
    } else {
      imageContent = _buildInitialsFallback();
    }

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: resolvedBorderColor,
          width: resolvedBorderWidth,
        ),
      ),
      child: ClipOval(child: imageContent),
    );
  }

  Widget _buildInitialsFallback() {
    final initials = _getInitials(fullName);
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF263342),
            Color(0xFF131922),
          ],
        ),
      ),
      child: Text(
        initials,
        style: TextStyle(
          color: AppColors.primaryWhite,
          fontSize: (size * 0.38).sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
