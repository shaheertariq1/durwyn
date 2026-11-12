class GpsHistoryTripEntity {
  const GpsHistoryTripEntity({
    required this.date,
    required this.locations,
    required this.duration,
    required this.progress,
  });

  final String date;
  final String locations;
  final String duration;
  final double progress;
}
