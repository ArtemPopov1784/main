import 'package:diplome/features/my_event/data/model/type_events_model.dart';
import 'package:diplome/features/my_event/presentation/controller/admin_screen_code.dart';
import 'package:diplome/features/my_event/presentation/widget/cards_for_admin/base_card.dart';
import 'package:flutter/material.dart';

class TypeEventCard extends BaseCard<TypeEventModel> {
  TypeEventCard({
    super.key,
    required super.data,
    required super.onUpdated,
    required super.onDeleted,
    required super.title,
  })  : nameController = TextEditingController(text: data.nameTypeEvents),
        _localData = data;

  final TextEditingController nameController;

  late TypeEventModel _localData;

  @override
  List<Widget> getFields(BuildContext context) {
    return [
      TextField(
        controller: nameController,
        decoration: const InputDecoration(labelText: "Название"),
      ),
    ];
  }

  @override
  Future<void> onUpdatePressed() async {
    _localData = TypeEventModel(
      idTypeEvents: data.idTypeEvents,
      nameTypeEvents: nameController.text,
    );
    await AdminDataSource().updateTypeEvent(_localData);
  }

  void updateData() async {
    TypeEventModel updated = TypeEventModel(
      idTypeEvents: data.idTypeEvents,
      nameTypeEvents: nameController.text,
    );

    await AdminDataSource().updateTypeEvent(updated);
  }
}
