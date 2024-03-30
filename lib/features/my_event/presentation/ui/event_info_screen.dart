import 'package:diplome/features/my_event/data/model/event_model.dart';
import 'package:diplome/features/my_event/presentation/widget/custom_bot_nav_bar.dart';
import 'package:flutter/material.dart';

class EventInfoScreen extends StatelessWidget {
  const EventInfoScreen({super.key, required this.car, required this.index});

  final EventModel car;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBotNavBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Index - $index"),
            Text("Макисмальный расход топлива в городе - ${car.name_event}"),
            Text("Класс - ${car.date_time}"),
            Text(
                "Расход топлива и на трассе и в городе - ${car.location}"),
            Text("Цилиндры - ${car.type_events_ID}"),
            Text("Привод - ${car.organisation_ID}"),
            Text("Тип топляка - ${car.client_ID}"),
          ],
        ),
      ),
    );
  }
}
