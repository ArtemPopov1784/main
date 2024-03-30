import 'package:diplome/features/my_event/data/model/event_model.dart';
import 'package:flutter/material.dart';

class EventCard extends StatefulWidget {
  const EventCard({
    super.key,
    required this.index,
    required this.event,
  });

  final EventModel event;
  final int index;

  @override
  State<EventCard> createState() => _EventCardState();
}

bool isCheck = false;

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Card(
        child: ExpansionTile(
          trailing: Checkbox(
            value: isCheck,
            onChanged: (value) {
              isCheck = !isCheck;
              setState(() {});
            },
          ),
          title: Text("Модель: ${widget.event.name_event}"),
          children: [
            const Text("data"),
            Text("Index - ${widget.index}"),
            Text("Класс - ${widget.event.date_time}"),
            Text(
                "Расход топлива и на трассе и в городе - ${widget.event.location}"),
            Text("Цилиндры - ${widget.event.type_events_ID}"),
            Text("Привод - ${widget.event.organisation_ID}"),
            Text("Тип топляка - ${widget.event.client_ID}"),
          ],
        ),
      ),
    );
  }
}
