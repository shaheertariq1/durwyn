import 'dart:math' as math;
import 'package:intl/intl.dart';
import '../../../../core/utils/app_exports.dart';
import '../../../emergency/data/models/incident_model.dart';

class IncidentCard extends StatefulWidget {
  const IncidentCard({
    super.key,
    required this.incident,
    required this.isExpanded,
    required this.onTap,
  });

  final IncidentModel incident;
  final bool isExpanded;
  final VoidCallback onTap;

  @override
  State<IncidentCard> createState() => _IncidentCardState();
}

class _IncidentCardState extends State<IncidentCard> {
  String _formatDate(String isoString) {
    if (isoString.isEmpty) return 'Recent';
    try {
      final dt = DateTime.parse(isoString).toLocal();
      return DateFormat('MMM d, yyyy · h:mm a').format(dt);
    } catch (_) {
      return isoString;
    }
  }

  @override
  Widget build(BuildContext context) {
    final incident = widget.incident;
    final isActive = incident.status == 'active';
    final isSos = incident.emergencyType == 'sos';

    final badgeColor = isActive ? AppColors.dashboardSosRed : AppColors.successGreen;
    final typeLabel = isSos ? 'Manual SOS Alert' : 'Timer Expired SOS';

    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.dashboardCardBg,
        borderRadius: 16.circular,
        border: Border.all(
          color: isActive
              ? AppColors.dashboardSosRed.withValues(alpha: 0.3)
              : AppColors.primaryWhite.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: widget.onTap,
            child: Container(
              padding: AppInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                border: widget.isExpanded
                    ? Border(
                        bottom: BorderSide(
                          color: AppColors.primaryWhite.withValues(alpha: 0.1),
                        ),
                      )
                    : null,
              ),
              child: Row(
                children: [
                  Container(
                    width: 44.w,
                    height: 44.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: badgeColor.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isSos ? Icons.warning_rounded : Icons.timer_off_rounded,
                      color: badgeColor,
                      size: 22.sp,
                    ),
                  ),
                  12.pw,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              typeLabel,
                              style: context.bodyMediumStyle?.copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryWhite,
                              ),
                            ),
                            8.pw,
                            Container(
                              padding: AppInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: badgeColor.withValues(alpha: 0.15),
                                borderRadius: 6.circular,
                              ),
                              child: Text(
                                incident.status.toUpperCase(),
                                style: context.labelSmallStyle?.copyWith(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w700,
                                  color: badgeColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        4.ph,
                        Text(
                          _formatDate(incident.createdAt),
                          style: context.bodySmallStyle?.copyWith(
                            fontSize: 13.sp,
                            color: AppColors.coolGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Transform.rotate(
                    angle: widget.isExpanded ? -math.pi / 2 : math.pi / 2,
                    child: SvgPicture.asset(
                      AppAssetsSvg.dashboardHistoryExpandIcn,
                      width: 20.sp,
                      height: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (widget.isExpanded)
            Padding(
              padding: AppInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16.sp,
                        color: AppColors.coolGray,
                      ),
                      6.pw,
                      Expanded(
                        child: Text(
                          '${incident.address} (${incident.latitude.toStringAsFixed(4)}, ${incident.longitude.toStringAsFixed(4)})',
                          style: context.bodySmallStyle?.copyWith(
                            fontSize: 13.sp,
                            color: AppColors.primaryWhite.withValues(alpha: 0.9),
                          ),
                        ),
                      ),
                    ],
                  ),
                  10.ph,
                  Row(
                    children: [
                      Icon(
                        Icons.contacts_outlined,
                        size: 16.sp,
                        color: AppColors.coolGray,
                      ),
                      6.pw,
                      Text(
                        'Contacts Alerted: ${incident.contactsAlerted.length}',
                        style: context.bodySmallStyle?.copyWith(
                          fontSize: 13.sp,
                          color: AppColors.coolGray,
                        ),
                      ),
                    ],
                  ),
                  if (incident.emergencyMessage.isNotEmpty) ...[
                    10.ph,
                    Container(
                      width: double.infinity,
                      padding: AppInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.dashboardBackground,
                        borderRadius: 8.circular,
                      ),
                      child: Text(
                        '"${incident.emergencyMessage}"',
                        style: context.bodySmallStyle?.copyWith(
                          fontSize: 13.sp,
                          fontStyle: FontStyle.italic,
                          color: AppColors.primaryWhite.withValues(alpha: 0.8),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }
}
