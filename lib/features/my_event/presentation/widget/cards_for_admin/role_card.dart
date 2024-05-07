import 'package:diplome/features/my_event/data/model/roles_model.dart';
import 'package:diplome/features/my_event/presentation/controller/admin_screen_code.dart';
import 'package:diplome/features/my_event/presentation/widget/cards_for_admin/base_card.dart';
import 'package:flutter/material.dart';

class RoleCard extends BaseCard<RoleModel> {
  RoleCard({
    super.key,
    required super.data,
    required super.onUpdated,
    required super.onDeleted,
    required super.title,
  })  : nameController = TextEditingController(text: data.nameRoles),
        _localData = data;

  final TextEditingController nameController;

  late RoleModel _localData;

  @override
  List<Widget> getFields(BuildContext context) {
    return [
      TextField(
        controller: nameController,
        decoration: const InputDecoration(label: Text("Название роли")),
      ),
    ];
  }

  @override
  void onUpdatePressed() async {
    _localData = RoleModel(
      idRoles: data.idRoles,
      nameRoles: nameController.text,
    );
    await AdminDataSource().updateRole(_localData);
  }

  void updateData() async {
    RoleModel updated = RoleModel(
      idRoles: data.idRoles,
      nameRoles: nameController.text,
    );
    await AdminDataSource().updateRole(updated);
  }
}
