import 'dart:convert';

import 'package:diplome/features/my_event/data/model/account_model.dart';
import 'package:diplome/features/my_event/data/model/client_model.dart';
import 'package:diplome/features/my_event/data/model/event_model.dart';
import 'package:diplome/features/my_event/data/model/event_participants_model.dart';
import 'package:diplome/features/my_event/data/model/organisation_model.dart';
import 'package:diplome/features/my_event/data/model/roles_model.dart';
import 'package:diplome/features/my_event/data/model/type_events_model.dart';
import 'package:diplome/features/my_event/presentation/ui/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:mssql_connection/mssql_connection.dart';

///
///Инициализация мероприятий (может вывести как все, так и только те, которые нужны)
///
Future<List<EventParticipantModel>> eventInit() async {
  MssqlConnection mssqlConnection = MssqlConnection.getInstance();

  try {
    final data = jsonDecode(
      await mssqlConnection.getData("""
SELECT
    E.ID_Events,
    E.Name_Events,
    E.DateTime,
    E.Location,
    E.Description,
    T.Name_Type_Events,
    O.Name_Organisation,
    C.ID_Client,
    C.First_Name,
    C.Middle_Name,
    C.Last_Name
FROM
    Events AS E
JOIN
    Type_Events AS T ON E.Type_Events_ID = T.ID_Type_Events
JOIN
    Organisation AS O ON E.Organisation_ID = O.ID_Organisation
LEFT JOIN
    Event_Participants AS EP ON E.ID_Events = EP.ID_Event
LEFT JOIN
    Client AS C ON EP.ID_Client = C.ID_Client
WHERE
    (${showOnlyMyEvents ? 'C.ID_Client = $clientID AND ' : ''}
     ${searchController.text.isNotEmpty ? 'E.Name_Events LIKE \'%${searchController.text}%\' AND ' : ''}
     1 = 1)
ORDER BY
    E.ID_Events,
    C.ID_Client;    
"""),
    ) as List<dynamic>;
    List<EventParticipantModel> events = [];
    Map<int, List<ClientModel>> eventClients = {};

    for (var json in data) {
      int eventId = json['ID_Events'];

      // Создаем объект EventModel
      EventModel event = EventModel(
        idEvents: eventId,
        nameEvents: json['Name_Events'] ?? "",
        dateTime: json['DateTime'] ?? "",
        location: json['Location'] ?? "",
        description: json['Description'] ?? "",
        typeEventModel: TypeEventModel(
            idTypeEvents: json['ID_Type_Events'] ?? 0,
            nameTypeEvents: json['Name_Type_Events'] ?? ""),
        organisationModel: OrganisationModel(
          idOrganisation: json['ID_Organisation'] ?? 0,
          nameOrganisation: json['Name_Organisation'] ?? "",
          rating: json['Rating'] ?? 0,
          account: AccountModel(
            idAccount: json['ID_Account'] ?? 0,
            login: json['Login'] ?? "",
            password: json['Password'] ?? "",
            address: json['Address'] ?? "",
            phone: json['Phone'] ?? "",
            mail: json['Mail'] ?? "",
            roleModel: RoleModel(
                idRoles: json['ID_Roles'] ?? 0,
                nameRoles: json['Name_Roles'] ?? ""),
          ),
        ),
      );

      // Добавляем объект EventModel в список events, если он еще не добавлен
      if (!events.any((e) => e.event.idEvents == eventId)) {
        events.add(
          EventParticipantModel(
            idParticipant: eventId,
            event: event,
            clients: [],
          ),
        );
      }

      // Создаем объект ClientModel
      if (json['ID_Client'] != null) {
        ClientModel client = ClientModel(
          idClient: json['ID_Client'],
          firstName: json['First_Name'] ?? "",
          middleName: json['Middle_Name'] ?? "",
          lastName: json['Last_Name'] ?? "",
          account: AccountModel(
            idAccount: json['ID_Account'] ?? 0,
            login: json['Login'] ?? "",
            password: json['Password'] ?? "",
            address: json['Address'] ?? "",
            phone: json['Phone'] ?? "",
            mail: json['Mail'] ?? "",
            roleModel: RoleModel(
              idRoles: json['ID_Roles'] ?? 0,
              nameRoles: json['Name_Roles'] ?? "",
            ),
          ),
        );

        // Добавляем объект ClientModel в список участников соответствующего мероприятия
        events
            .firstWhere((e) => e.event.idEvents == eventId)
            .clients
            .add(client);
      }
    }

// Добавляем список участников к соответствующим мероприятиям
    for (var event in events) {
      event.clients = eventClients[event.event.idEvents] ?? [];
    }

    return events;
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return [];
  }
}
