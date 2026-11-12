import 'history_checkpoint_entity.dart';

class HistoryTripEntity {
  const HistoryTripEntity({
    required this.avatar,
    required this.dateLabel,
    this.checkpoints = const [],
  });

  final String avatar;
  final String dateLabel;
  final List<HistoryCheckpointEntity> checkpoints;
}
