import 'package:diplome/features/my_event/data/model/roles_model.dart';

class AccountModel {
  AccountModel({
    required this.idAccount,
    required this.login,
    required this.password,
    required this.address,
    required this.phone,
    required this.mail,
    required this.roleModel,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      idAccount: json['ID_Account'],
      login: json['Login'],
      password: json['Password'],
      address: json['Address'],
      phone: json['Phone'],
      mail: json['Mail'],
      roleModel: RoleModel.fromJson(json['Roles']),
    );
  }

  final String address;
  final int idAccount;
  final String login;
  final String mail;
  final String password;
  final String phone;
  final RoleModel roleModel;
}
