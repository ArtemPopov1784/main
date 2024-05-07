import 'package:diplome/features/my_event/presentation/controller/admin_screen_code.dart';
import 'package:flutter/material.dart';

import 'package:diplome/features/my_event/data/model/account_model.dart';
import 'package:diplome/features/my_event/data/model/roles_model.dart';
import 'package:diplome/features/my_event/presentation/widget/cards_for_admin/base_card.dart';

class AccountCard extends BaseCard<AccountModel> {
  AccountCard({
    super.key,
    required super.data,
    required super.onUpdated,
    required super.onDeleted,
    required super.title,
    required this.roles,
    required this.onRoleChanged,
  })  : addressController = TextEditingController(text: data.address),
        loginController = TextEditingController(text: data.login),
        mailController = TextEditingController(text: data.mail),
        passwordController = TextEditingController(text: data.password),
        phoneController = TextEditingController(text: data.phone),
        _localData = data;

  final TextEditingController addressController;
  final TextEditingController loginController;
  final TextEditingController mailController;
  final ValueChanged<RoleModel> onRoleChanged;
  final TextEditingController passwordController;
  final TextEditingController phoneController;
  final List<RoleModel> roles;

  late AccountModel _localData;

  @override
  List<Widget> getFields(BuildContext context) {
    return [
      TextField(
        controller: loginController,
        decoration: const InputDecoration(labelText: "Логин"),
      ),
      TextField(
        controller: passwordController,
        decoration: const InputDecoration(labelText: "Пароль"),
      ),
      TextField(
        controller: addressController,
        decoration: const InputDecoration(labelText: "Адрес"),
      ),
      TextField(
        controller: phoneController,
        decoration: const InputDecoration(labelText: "Телефон"),
      ),
      TextField(
        controller: mailController,
        decoration: const InputDecoration(labelText: "Почта"),
      ),
      DropdownButtonFormField<RoleModel>(
        decoration: const InputDecoration(labelText: "Роль"),
        value: findCorrespondingRole(data.roleModel, roles),
        items: roles
            .map<DropdownMenuItem<RoleModel>>((role) {
              return DropdownMenuItem<RoleModel>(
                key: UniqueKey(),
                value: role,
                child: Text(role.nameRoles),
              );
            })
            .toSet() // Удаление дубликатов
            .toList(),
        onChanged: (value) {
          onRoleChanged(value!);
        },
      ),
    ];
  }

  @override
  Future<void> onUpdatePressed() async {
    _localData = AccountModel(
      idAccount: data.idAccount,
      login: loginController.text,
      password: passwordController.text,
      address: addressController.text,
      phone: phoneController.text,
      mail: mailController.text,
      roleModel: data.roleModel,
    );
    await AdminDataSource().updateAccount(_localData);
  }

  void updateData() async {
    AccountModel updated = AccountModel(
      idAccount: data.idAccount,
      login: loginController.text,
      password: passwordController.text,
      address: addressController.text,
      phone: phoneController.text,
      mail: mailController.text,
      roleModel: data.roleModel,
    );

    await AdminDataSource().updateAccount(updated);
  }
}

final RoleModel defaultRole = RoleModel(idRoles: -1, nameRoles: '');

RoleModel findCorrespondingRole(RoleModel role, List<RoleModel> roles) {
  return roles.firstWhere(
    (r) => r.idRoles == role.idRoles,
    orElse: () => defaultRole,
  );
}
