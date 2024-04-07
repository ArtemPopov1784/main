import 'package:diplome/features/my_event/data/model/account_model.dart';

class ClientModel {
  ClientModel({
    required this.idClient,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.account,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      idClient: json['ID_Client'],
      firstName: json['First_Name'],
      middleName: json['Middle_Name'],
      lastName: json['Last_Name'],
      account: AccountModel.fromJson(json['Account']),
    );
  }

  final AccountModel account;
  final String firstName;
  final int idClient;
  final String lastName;
  final String middleName;
}
