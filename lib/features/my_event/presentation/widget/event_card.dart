import 'package:diplome/features/my_event/data/model/event_participants_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class EventCard extends StatefulWidget {
  const EventCard({
    super.key,
    required this.index,
    required this.eventParticipantModel,
  });

  final EventParticipantModel eventParticipantModel;
  final int index;

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('ru_RU', null); // Добавьте эту строку
    final dateFormat = DateFormat('d MMMM y, HH:mm', 'ru_RU');
    final formattedDate =
        dateFormat.format(widget.eventParticipantModel.event.dateTime);
    return Card(
      child: ExpansionTile(
        trailing: Checkbox(
          value: isCheck,
          onChanged: (value) {
            setState(() {
              isCheck = !isCheck;
            });
          },
        ),
        title: Text(
            "Мероприятие: ${widget.eventParticipantModel.event.nameEvents}"),
        subtitle: Text(
            "Дата и время - ${formattedDate.toString()} ${widget.eventParticipantModel.event.dateTime.isBefore(DateTime.now()) ? "(Просрочено)" : ""}"),
        children: [
          ListTile(
            title: const Text("Index"),
            subtitle: Text("${widget.index}"),
          ),
          ListTile(
            title: const Text("Локация"),
            subtitle: Text(widget.eventParticipantModel.event.location),
          ),
          ListTile(
            title: const Text("Тип события"),
            subtitle: Text(widget
                .eventParticipantModel.event.typeEventModel.nameTypeEvents),
          ),
          ListTile(
            title: const Text("Организация"),
            subtitle: Text(widget.eventParticipantModel.event.organisationModel
                .nameOrganisation),
          ),
          ListTile(
            title: const Text("Участники"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...widget.eventParticipantModel.clients
                    .map((client) => Text(
                        '${client.firstName} ${client.middleName} ${client.lastName}'))
                    ,
              ],
            ),
          ),
          ListTile(
            title: const Text("Описание мероприятия"),
            subtitle: Text(widget.eventParticipantModel.event.description),
          ),
        ],
      ),
    );
  }
}
