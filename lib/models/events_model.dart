class EventsModel {
  final int id;
  final String title;
  final double budget;
  final DateTime startDate;
  final DateTime endDate;

  EventsModel({
    required this.id,
    required this.title,
    required this.budget,
    required this.startDate,
    required this.endDate,
  });
}