import 'package:diplome/features/my_event/data/model/account_model.dart';
import 'package:diplome/features/my_event/data/model/event_model.dart';
import 'package:diplome/features/my_event/data/model/organisation_model.dart';
import 'package:diplome/features/my_event/data/model/roles_model.dart';
import 'package:diplome/features/my_event/data/model/type_events_model.dart';
import 'package:diplome/features/my_event/presentation/controller/admin_screen_code.dart';
import 'package:diplome/features/my_event/presentation/widget/cards_for_admin/base_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventCard extends BaseCard<EventModel> {
  EventCard({
    super.key,
    required super.data,
    required super.onUpdated,
    required super.onDeleted,
    required super.title,
    required this.typeEvents,
    required this.organisations,
    required this.onTypeEventChanged,
    required this.onOrganisationChanged,
  })  : nameController = TextEditingController(text: data.nameEvents),
        dateTimeController = TextEditingController(text: data.dateTime),
        locationController = TextEditingController(text: data.location),
        descriptionController = TextEditingController(text: data.description),
        _localData = data;

  final TextEditingController dateTimeController;
  final TextEditingController descriptionController;
  final TextEditingController locationController;
  final TextEditingController nameController;
  final ValueChanged<OrganisationModel> onOrganisationChanged;
  final ValueChanged<TypeEventModel> onTypeEventChanged;
  final List<OrganisationModel> organisations;
  final List<TypeEventModel> typeEvents;

  late EventModel _localData;

  @override
  List<Widget> getFields(BuildContext context) {
    return [
      TextField(
        controller: nameController,
        decoration: const InputDecoration(labelText: "Название"),
      ),
      TextField(
        controller: dateTimeController,
        decoration: const InputDecoration(labelText: "Дата и время"),
      ),
      TextField(
        controller: locationController,
        decoration: const InputDecoration(labelText: "Местоположение"),
      ),
      TextField(
        controller: descriptionController,
        decoration: const InputDecoration(labelText: "Описание"),
      ),
      DropdownButtonFormField<TypeEventModel>(
        decoration: const InputDecoration(labelText: "Тип мероприятия"),
        value: findCorrespondingTypeEvent(data.typeEventModel, typeEvents),
        items: typeEvents
            .map<DropdownMenuItem<TypeEventModel>>((typeEvent) {
              return DropdownMenuItem<TypeEventModel>(
                key: UniqueKey(),
                value: typeEvent,
                child: Text(typeEvent.nameTypeEvents),
              );
            })
            .toSet() // Удаление дубликатов
            .toList(),
        onChanged: (value) {
          onTypeEventChanged(value!);
        },
      ),
      DropdownButtonFormField<OrganisationModel>(
        decoration: const InputDecoration(labelText: "Организация"),
        value: findCorrespondingOrganisation(
            data.organisationModel, organisations),
        items: organisations
            .map<DropdownMenuItem<OrganisationModel>>((organisation) {
              return DropdownMenuItem<OrganisationModel>(
                key: UniqueKey(),
                value: organisation,
                child: Text(organisation.nameOrganisation),
              );
            })
            .toSet() // Удаление дубликатов
            .toList(),
        onChanged: (value) {
          onOrganisationChanged(value!);
        },
      ),
    ];
  }

  @override
  Future<void> onUpdatePressed() async {
    DateTime dateTime =
        DateTime.tryParse(dateTimeController.text) ?? DateTime.now();
    String formattedDateTime =
        DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(dateTime);

    _localData = EventModel(
      idEvents: data.idEvents,
      nameEvents: nameController.text,
      dateTime: formattedDateTime, // Use the formatted date string here
      location: locationController.text,
      description: descriptionController.text,
      typeEventModel: data.typeEventModel,
      organisationModel: data.organisationModel,
    );

    await AdminDataSource().updateEvent(_localData);
  }

  void updateData() async {
    DateTime dateTime =
        DateTime.tryParse(dateTimeController.text) ?? DateTime.now();
    String formattedDateTime =
        DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(dateTime);

    EventModel updated = EventModel(
      idEvents: data.idEvents,
      nameEvents: nameController.text,
      dateTime: formattedDateTime, // Use the formatted date string here
      location: locationController.text,
      description: descriptionController.text,
      typeEventModel: data.typeEventModel,
      organisationModel: data.organisationModel,
    );

    await AdminDataSource().updateEvent(updated);
  }
}

final TypeEventModel defaultTypeEvent =
    TypeEventModel(idTypeEvents: -1, nameTypeEvents: '');

TypeEventModel findCorrespondingTypeEvent(
    TypeEventModel typeEvent, List<TypeEventModel> typeEvents) {
  return typeEvents.firstWhere(
    (t) => t.idTypeEvents == typeEvent.idTypeEvents,
    orElse: () => defaultTypeEvent,
  );
}

final OrganisationModel defaultOrganisation = OrganisationModel(
  idOrganisation: -1,
  nameOrganisation: '',
  rating: 0,
  account: AccountModel(
    idAccount: 0,
    login: '',
    password: '',
    address: '',
    phone: '',
    mail: '',
    roleModel: RoleModel(
      idRoles: 0,
      nameRoles: '',
    ),
  ),
);

OrganisationModel findCorrespondingOrganisation(
    OrganisationModel organisation, List<OrganisationModel> organisations) {
  return organisations.firstWhere(
    (o) => o.idOrganisation == organisation.idOrganisation,
    orElse: () => defaultOrganisation,
  );
}
