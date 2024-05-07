// import 'package:mssql_connection/mssql_connection.dart';

// abstract class SomeCommand {
//   Future<void> execute();
// }

// class AddRoleCommand extends SomeCommand {
//   AddRoleCommand(this.name);

//   final String name;

//   @override
//   Future<void> execute() async {
//     await MssqlConnection.getInstance()
//         .writeData("INSERT INTO Roles (Name_Roles) VALUES ('$name');");
//   }
// }

// class UpdateRoleCommand extends SomeCommand {
//   UpdateRoleCommand(this.id, this.newName);

//   final int id;
//   final String newName;

//   @override
//   Future<void> execute() async {
//     await MssqlConnection.getInstance().writeData(
//         "UPDATE Roles SET Name_Roles = ('$newName') WHERE ID_Roles = $id;");
//   }
// }

// class DeleteRoleCommand extends SomeCommand {
//   DeleteRoleCommand(this.id);

//   final int id;

//   @override
//   Future<void> execute() async {
//     await MssqlConnection.getInstance()
//         .writeData("DELETE FROM Roles WHERE ID_Roles = $id;");
//   }
// }

// class AddAccountCommand extends SomeCommand {
//   AddAccountCommand(this.login, this.password, this.address, this.phone,
//       this.mail, this.rolesId);

//   final String address;
//   final String login;
//   final String mail;
//   final String password;
//   final String phone;
//   final int rolesId;

//   @override
//   Future<void> execute() async {
//     await MssqlConnection.getInstance().writeData(
//         "INSERT INTO Account (Login, Password, Address, Phone, Mail, Roles_ID) VALUES ('$login', '$password', '$address', '$phone', '$mail', $rolesId);");
//   }
// }

// class UpdateAccountCommand extends SomeCommand {
//   UpdateAccountCommand(this.id, this.login, this.password, this.address,
//       this.phone, this.mail, this.rolesId);

//   final String address;
//   final int id;
//   final String login;
//   final String mail;
//   final String password;
//   final String phone;
//   final int rolesId;

//   @override
//   Future<void> execute() async {
//     await MssqlConnection.getInstance().writeData(
//         "UPDATE Account SET Login = '$login', Password = '$password', Address = '$address', Phone = '$phone', Mail = '$mail', Roles_ID = $rolesId WHERE ID_Account = $id;");
//   }
// }

// class DeleteAccountCommand extends SomeCommand {
//   DeleteAccountCommand(this.id);

//   final int id;

//   @override
//   Future<void> execute() async {
//     await MssqlConnection.getInstance()
//         .writeData("DELETE FROM Account WHERE ID_Account = $id;");
//   }
// }

// class AddOrganisationCommand extends SomeCommand {
//   AddOrganisationCommand(this.name, this.rating, this.accountId);

//   final int accountId;
//   final String name;
//   final int rating;

//   @override
//   Future<void> execute() async {
//     await MssqlConnection.getInstance().writeData(
//         "INSERT INTO Organisation (Name_Organisation, Rating, Account_ID) VALUES ('$name', $rating, $accountId);");
//   }
// }

// class UpdateOrganisationCommand extends SomeCommand {
//   UpdateOrganisationCommand(this.id, this.name, this.rating, this.accountId);

//   final int accountId;
//   final int id;
//   final String name;
//   final int rating;

//   @override
//   Future<void> execute() async {
//     await MssqlConnection.getInstance().writeData(
//         "UPDATE Organisation SET Name_Organisation = '$name', Rating = $rating, Account_ID = $accountId WHERE ID_Organisation = $id;");
//   }
// }

// class DeleteOrganisationCommand extends SomeCommand {
//   DeleteOrganisationCommand(this.id);

//   final int id;

//   @override
//   Future<void> execute() async {
//     await MssqlConnection.getInstance()
//         .writeData("DELETE FROM Organisation WHERE ID_Organisation = $id;");
//   }
// }

// class AddTypeEventCommand extends SomeCommand {
//   AddTypeEventCommand(this.name);

//   final String name;

//   @override
//   Future<void> execute() async {
//     await MssqlConnection.getInstance().writeData(
//         "INSERT INTO Type_Events (Name_Type_Events) VALUES ('$name');");
//   }
// }

// class UpdateTypeEventCommand extends SomeCommand {
//   UpdateTypeEventCommand(this.id, this.name);

//   final int id;
//   final String name;

//   @override
//   Future<void> execute() async {
//     await MssqlConnection.getInstance().writeData(
//         "UPDATE Type_Events SET Name_Type_Events = '$name' WHERE ID_Type_Events = $id;");
//   }
// }

// class DeleteTypeEventCommand extends SomeCommand {
//   DeleteTypeEventCommand(this.id);

//   final int id;

//   @override
//   Future<void> execute() async {
//     await MssqlConnection.getInstance()
//         .writeData("DELETE FROM Type_Events WHERE ID_Type_Events = $id;");
//   }
// }

// class AddClientCommand extends SomeCommand {
//   AddClientCommand(
//       this.firstName, this.middleName, this.lastName, this.accountId);

//   final int accountId;
//   final String firstName;
//   final String lastName;
//   final String middleName;

//   @override
//   Future<void> execute() async {
//     await MssqlConnection.getInstance().writeData(
//         "INSERT INTO Client (First_Name, Middle_Name, Last_Name, Account_ID) VALUES ('$firstName', '$middleName', '$lastName', $accountId);");
//   }
// }

// class UpdateClientCommand extends SomeCommand {
//   UpdateClientCommand(
//       this.id, this.firstName, this.middleName, this.lastName, this.accountId);

//   final int accountId;
//   final String firstName;
//   final int id;
//   final String lastName;
//   final String middleName;

//   @override
//   Future<void> execute() async {
//     await MssqlConnection.getInstance().writeData(
//         "UPDATE Client SET First_Name = '$firstName', Middle_Name = '$middleName', Last_Name = '$lastName', Account_ID = $accountId WHERE ID_Client = $id;");
//   }
// }

// class DeleteClientCommand extends SomeCommand {
//   DeleteClientCommand(this.id);

//   final int id;

//   @override
//   Future<void> execute() async {
//     await MssqlConnection.getInstance()
//         .writeData("DELETE FROM Client WHERE ID_Client = $id;");
//   }
// }

// class AddEventCommand extends SomeCommand {
//   AddEventCommand(this.name, this.dateTime, this.location, this.description,
//       this.typeEventId, this.organisationId);

//   final DateTime dateTime;
//   final String description;
//   final String location;
//   final String name;
//   final int organisationId;
//   final int typeEventId;

//   @override
//   Future<void> execute() async {
//     await MssqlConnection.getInstance().writeData(
//         "INSERT INTO Events (Name_Events, DateTime, Location, Description, Type_Events_ID, Organisation_ID) VALUES ('$name', '${dateTime.toIso8601String()}', '$location', '$description', $typeEventId, $organisationId);");
//   }
// }

// class UpdateEventCommand extends SomeCommand {
//   UpdateEventCommand(this.id, this.name, this.dateTime, this.location,
//       this.description, this.typeEventId, this.organisationId);

//   final DateTime dateTime;
//   final String description;
//   final int id;
//   final String location;
//   final String name;
//   final int organisationId;
//   final int typeEventId;

//   @override
//   Future<void> execute() async {
//     await MssqlConnection.getInstance().writeData(
//         "UPDATE Events SET Name_Events = '$name', DateTime = '${dateTime.toIso8601String()}', Location = '$location', Description = '$description', Type_Events_ID = $typeEventId, Organisation_ID = $organisationId WHERE ID_Events = $id;");
//   }
// }

// class DeleteEventCommand extends SomeCommand {
//   DeleteEventCommand(this.id);

//   final int id;

//   @override
//   Future<void> execute() async {
//     await MssqlConnection.getInstance()
//         .writeData("DELETE FROM Events WHERE ID_Events = $id;");
//   }
// }
