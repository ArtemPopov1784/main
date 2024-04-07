import 'dart:convert';

import 'package:diplome/features/my_event/data/model/event_model.dart';

List<EventModel> parseEventsFromJsonString(String jsonString) {
  List<dynamic> jsonList = jsonDecode(jsonString);
  List<EventModel> events =
      jsonList.map((event) => EventModel.fromJson(event)).toList();
  return events;
}
