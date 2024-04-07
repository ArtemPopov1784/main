import 'package:diplome/features/my_event/data/model/organisation_model.dart';
import 'package:diplome/features/my_event/data/model/type_events_model.dart';

class EventModel {
  EventModel({
    required this.idEvents,
    required this.nameEvents,
    required this.dateTime,
    required this.location,
    required this.description,
    required this.typeEventModel,
    required this.organisationModel,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      idEvents: json['ID_Events'],
      nameEvents: json['Name_Events'],
      dateTime: DateTime.parse(json['DateTime']),
      location: json['Location'],
      description: json['Description'],
      typeEventModel: TypeEventModel.fromJson(json['Type_Event']),
      organisationModel: OrganisationModel.fromJson(json['Organisation']),
    );
  }

  final DateTime dateTime;
  final String description;
  final int idEvents;
  final String location;
  final String nameEvents;
  final OrganisationModel organisationModel;
  final TypeEventModel typeEventModel;
}
