import 'package:diplome/features/my_event/data/model/client_model.dart';
import 'package:diplome/features/my_event/data/model/event_model.dart';

class EventParticipantModel {
  EventParticipantModel({
    required this.idParticipant,
    required this.event,
    required this.clients,
  });

  factory EventParticipantModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> clientJson = json['Clients'];
    List<ClientModel> clients =
        clientJson.map((client) => ClientModel.fromJson(client)).toList();

    return EventParticipantModel(
      idParticipant: json['ID_Participant'],
      event: EventModel.fromJson(json['ID_Event']),
      clients: clients,
    );
  }

  List<ClientModel> clients;
  final EventModel event;
  final int idParticipant;
}
