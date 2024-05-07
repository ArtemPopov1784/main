import 'package:diplome/features/my_event/data/model/account_model.dart';
import 'package:diplome/features/my_event/data/model/event_model.dart';

class EventsHistoryModel {
  EventsHistoryModel({
    required this.idEventsHistory,
    required this.event,
    required this.acocunt,
    required this.visitDate,
  });

  factory EventsHistoryModel.fromJson(Map<String, dynamic> json) {
    return EventsHistoryModel(
      idEventsHistory: json['ID_Events_History'],
      event: EventModel.fromJson(json['Events']),
      acocunt: AccountModel.fromJson(json['Account']),
      visitDate: DateTime.parse(json['Visit_Date']),
    );
  }

  final AccountModel acocunt;
  final EventModel event;
  final int idEventsHistory;
  final DateTime visitDate;
}
