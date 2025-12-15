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

  factory EventsModel.fromJson(Map<String,dynamic> json){
    return EventsModel(
      id: json['id'],
      title: json['title'] ?? '',
      budget: (json['budget'] as num).toDouble(),
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
    );
  }

  Map<String,dynamic> toJson(){
    return{
      'title': title,
      'budget': budget,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
    };
  }
}