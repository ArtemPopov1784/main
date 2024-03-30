// ignore_for_file: non_constant_identifier_names

class EventModel {
  EventModel({
    required this.name_event,
    required this.date_time,
    required this.location,
    required this.type_events_ID,
    required this.organisation_ID,
    required this.client_ID,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      name_event: json['Name_Events'],
      date_time: json['DateTime'],
      location: json['Location'],
      type_events_ID: json['Type_Events_ID'],
      organisation_ID: json['Organisation_ID'],
      client_ID: json['Client_ID'],
    );
  }

  final DateTime date_time;
  final String location;
  final String name_event;
  final int client_ID;
  final int organisation_ID;
  final int type_events_ID;
}
