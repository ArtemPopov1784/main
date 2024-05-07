import 'dart:convert';

import 'package:mssql_connection/mssql_connection.dart';

import 'package:diplome/features/my_event/data/model/account_model.dart';
import 'package:diplome/features/my_event/data/model/client_model.dart';
import 'package:diplome/features/my_event/data/model/event_model.dart';
import 'package:diplome/features/my_event/data/model/organisation_model.dart';
import 'package:diplome/features/my_event/data/model/roles_model.dart';
import 'package:diplome/features/my_event/data/model/type_events_model.dart';

MssqlConnection mssqlConnection = MssqlConnection.getInstance();
class AdminDataSource {
  Future<List<RoleModel>> getRoles() async {
    final rolesData = jsonDecode(await mssqlConnection.getData("""
SELECT ID_Roles, Name_Roles
FROM Roles
ORDER BY ID_Roles ASC;
""")) as List<dynamic>;

    return rolesData
        .map((data) => RoleModel(
              idRoles: data['ID_Roles'] ?? 0,
              nameRoles: data['Name_Roles'] ?? '',
            ))
        .toList();
  }

  Future<List<AccountModel>> getAccounts() async {
    final accountsData = jsonDecode(await mssqlConnection.getData("""
SELECT A.ID_Account, A.Login, A.Password, A.Address, A.Phone, A.Mail, R.ID_Roles, R.Name_Roles
FROM Account AS A
JOIN Roles AS R ON A.Roles_ID = R.ID_Roles;
""")) as List<dynamic>;

    return accountsData
        .map((data) => AccountModel(
              idAccount: data['ID_Account'] ?? 0,
              login: data['Login'] ?? '',
              password: data['Password'] ?? '',
              address: data['Address'] ?? '',
              phone: data['Phone'] ?? '',
              mail: data['Mail'] ?? '',
              roleModel: RoleModel(
                idRoles: data['ID_Roles'] ?? 0,
                nameRoles: data['Name_Roles'] ?? '',
              ),
            ))
        .toList();
  }

  Future<List<OrganisationModel>> getOrganisations() async {
    final organisationsData = jsonDecode(await mssqlConnection.getData("""
SELECT O.ID_Organisation, O.Name_Organisation, O.Rating, A.ID_Account, A.Login, A.Password, A.Address, A.Phone, A.Mail
FROM Organisation AS O
JOIN Account AS A ON O.Account_ID = A.ID_Account;
""")) as List<dynamic>;

    return organisationsData
        .map((data) => OrganisationModel(
              idOrganisation: data['ID_Organisation'] ?? 0,
              nameOrganisation: data['Name_Organisation'] ?? '',
              rating: data['Rating'] ?? 0,
              account: AccountModel(
                idAccount: data['ID_Account'] ?? 0,
                login: data['Login'] ?? '',
                password: data['Password'] ?? '',
                address: data['Address'] ?? '',
                phone: data['Phone'] ?? '',
                mail: data['Mail'] ?? '',
                roleModel: RoleModel(
                  idRoles: data['ID_Roles'] ?? 0,
                  nameRoles: data['Name_Roles'] ?? '',
                ),
              ),
            ))
        .toList();
  }

  Future<List<TypeEventModel>> getTypeEvents() async {
    final typeEventsData = jsonDecode(await mssqlConnection.getData("""
SELECT ID_Type_Events, Name_Type_Events
FROM Type_Events;
""")) as List<dynamic>;

    return typeEventsData
        .map((data) => TypeEventModel(
              idTypeEvents: data['ID_Type_Events'] ?? 0,
              nameTypeEvents: data['Name_Type_Events'] ?? '',
            ))
        .toList();
  }

  Future<List<ClientModel>> getClients() async {
    final clientsData = jsonDecode(await mssqlConnection.getData("""
SELECT C.ID_Client, C.First_Name, C.Middle_Name, C.Last_Name, A.ID_Account, A.Login, A.Password, A.Address, A.Phone, A.Mail
FROM Client AS C
JOIN Account AS A ON C.Account_ID = A.ID_Account;
""")) as List<dynamic>;

    return clientsData
        .map((data) => ClientModel(
              idClient: data['ID_Client'] ?? 0,
              firstName: data['First_Name'] ?? '',
              middleName: data['Middle_Name'] ?? '',
              lastName: data['Last_Name'] ?? '',
              account: AccountModel(
                idAccount: data['ID_Account'] ?? 0,
                login: data['Login'] ?? '',
                password: data['Password'] ?? '',
                address: data['Address'] ?? '',
                phone: data['Phone'] ?? '',
                mail: data['Mail'] ?? '',
                roleModel: RoleModel(
                  idRoles: data['ID_Roles'] ?? 0,
                  nameRoles: data['Name_Roles'] ?? '',
                ),
              ),
            ))
        .toList();
  }

  Future<List<EventModel>> getEvents() async {
    final eventsData = jsonDecode(await mssqlConnection.getData("""
SELECT E.ID_Events, E.Name_Events, E.DateTime, E.Location, E.Description, T.ID_Type_Events, T.Name_Type_Events, O.ID_Organisation, O.Name_Organisation
FROM Events AS E
JOIN Type_Events AS T ON E.Type_Events_ID = T.ID_Type_Events
JOIN Organisation AS O ON E.Organisation_ID = O.ID_Organisation;
""")) as List<dynamic>;

    return eventsData
        .map((data) => EventModel(
              idEvents: data['ID_Events'] ?? 0,
              nameEvents: data['Name_Events'] ?? '',
              dateTime: data['DateTime'] ?? '',
              location: data['Location'] ?? '',
              description: data['Description'] ?? '',
              typeEventModel: TypeEventModel(
                idTypeEvents: data['ID_Type_Events'] ?? 0,
                nameTypeEvents: data['Name_Type_Events'] ?? '',
              ),
              organisationModel: OrganisationModel(
                idOrganisation: data['ID_Organisation'] ?? 0,
                nameOrganisation: data['Name_Organisation'] ?? '',
                rating: data['Rating'] ?? 0,
                account: AccountModel(
                  idAccount: data['ID_Account'] ?? 0,
                  login: data['Login'] ?? '',
                  password: data['Password'] ?? '',
                  address: data['Address'] ?? '',
                  phone: data['Phone'] ?? '',
                  mail: data['Mail'] ?? '',
                  roleModel: RoleModel(
                    idRoles: data['ID_Roles'] ?? 0,
                    nameRoles: data['Name_Roles'] ?? '',
                  ),
                ),
              ),
            ))
        .toList();
  }

//   Future<List<EventParticipantModel>> getEventParticipants() async {
//     final eventParticipantsData = jsonDecode(await mssqlConnection.getData("""
// SELECT EP.ID_Event_Participants, EP.ID_Event, EP.ID_Client, E.ID_Events, E.Name_Events, C.ID_Client, C.First_Name, C.Middle_Name, C.Last_Name
// FROM Event_Participants AS EP
// JOIN Events AS E ON EP.ID_Event = E.ID_Events
// JOIN Client AS C ON EP.ID_Client = C.ID_Client;
// """)) as List<dynamic>;

//     // Implement mapping for EventParticipantModel
//     return [];
//   }

  Future<void> addRole(RoleModel role) async {
    await mssqlConnection.writeData("""
      INSERT INTO Roles (Name_Roles)
      VALUES ('${role.nameRoles}');
    """);
  }

  Future<void> updateRole(RoleModel role) async {
    await mssqlConnection.writeData("""
      UPDATE Roles
      SET Name_Roles = '${role.nameRoles}'
      WHERE ID_Roles = ${role.idRoles};
    """);
  }

  Future<void> deleteRole(int id) async {
    await mssqlConnection.writeData("""
      DELETE FROM Roles
      WHERE ID_Roles = $id;
    """);
  }

  Future<void> addAccount(AccountModel account) async {
    await mssqlConnection.writeData("""
      INSERT INTO Account (Login, Password, Address, Phone, Mail, Roles_ID)
      VALUES ('${account.login}', '${account.password}', '${account.address}', '${account.phone}', '${account.mail}', ${account.roleModel.idRoles});
    """);
  }

  Future<void> updateAccount(AccountModel account) async {
    await mssqlConnection.writeData("""
      UPDATE Account
      SET Login = '${account.login}', Password = '${account.password}', Address = '${account.address}', Phone = '${account.phone}', Mail = '${account.mail}', Roles_ID = ${account.roleModel.idRoles}
      WHERE ID_Account = ${account.idAccount};
    """);
  }

  Future<void> deleteAccount(int id) async {
    await mssqlConnection.writeData("""
      DELETE FROM Account
      WHERE ID_Account = $id;
    """);
  }

  Future<void> addOrganisation(OrganisationModel organisation) async {
    await mssqlConnection.writeData("""
      INSERT INTO Organisation (Name_Organisation, Rating, Account_ID)
      VALUES ('${organisation.nameOrganisation}', ${organisation.rating}, ${organisation.account.idAccount});
    """);
  }

  Future<void> updateOrganisation(OrganisationModel organisation) async {
    await mssqlConnection.writeData("""
      UPDATE Organisation
      SET Name_Organisation = '${organisation.nameOrganisation}', Rating = ${organisation.rating}, Account_ID = ${organisation.account.idAccount}
      WHERE ID_Organisation = ${organisation.idOrganisation};
    """);
  }

  Future<void> deleteOrganisation(int id) async {
    await mssqlConnection.writeData("""
      DELETE FROM Organisation
      WHERE ID_Organisation = $id;
    """);
  }

  Future<void> addTypeEvent(TypeEventModel typeEvent) async {
    await mssqlConnection.writeData("""
      INSERT INTO Type_Events (Name_Type_Events)
      VALUES ('${typeEvent.nameTypeEvents}');
    """);
  }

  Future<void> updateTypeEvent(TypeEventModel typeEvent) async {
    await mssqlConnection.writeData("""
      UPDATE Type_Events
      SET Name_Type_Events = '${typeEvent.nameTypeEvents}'
      WHERE ID_Type_Events = ${typeEvent.idTypeEvents};
    """);
  }

  Future<void> deleteTypeEvent(int id) async {
    await mssqlConnection.writeData("""
      DELETE FROM Type_Events
      WHERE ID_Type_Events = $id;
    """);
  }

  Future<void> addClient(ClientModel client) async {
    await mssqlConnection.writeData("""
      INSERT INTO Client (First_Name, Middle_Name, Last_Name, Account_ID)
      VALUES ('${client.firstName}', '${client.middleName}', '${client.lastName}', ${client.account.idAccount});
    """);
  }

  Future<void> updateClient(ClientModel client) async {
    await mssqlConnection.writeData("""
      UPDATE Client
      SET First_Name = '${client.firstName}', Middle_Name = '${client.middleName}', Last_Name = '${client.lastName}', Account_ID = ${client.account.idAccount}
      WHERE ID_Client = ${client.idClient};
    """);
  }

  Future<void> deleteClient(int id) async {
    await mssqlConnection.writeData("""
      DELETE FROM Client
      WHERE ID_Client = $id;
    """);
  }

  Future<void> addEvent(EventModel event) async {
    await mssqlConnection.writeData("""
      INSERT INTO Events (Name_Events, DateTime, Location, Description, Type_Events_ID, Organisation_ID)
      VALUES ('${event.nameEvents}', '${event.dateTime}', '${event.location}', '${event.description}', ${event.typeEventModel.idTypeEvents}, ${event.organisationModel.idOrganisation});
    """);
  }

  Future<void> updateEvent(EventModel event) async {
    await mssqlConnection.writeData("""
      UPDATE Events
      SET Name_Events = '${event.nameEvents}', DateTime = '${event.dateTime}', Location = '${event.location}', Description = '${event.description}', Type_Events_ID = ${event.typeEventModel.idTypeEvents}, Organisation_ID = ${event.organisationModel.idOrganisation}
      WHERE ID_Events = ${event.idEvents};
    """);
  }

  Future<void> deleteEvent(int id) async {
    await mssqlConnection.writeData("""
      DELETE FROM Events
      WHERE ID_Events = $id;
    """);
  }
}
