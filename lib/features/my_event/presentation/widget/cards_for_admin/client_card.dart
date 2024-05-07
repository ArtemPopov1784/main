import 'package:diplome/features/my_event/data/model/account_model.dart';
import 'package:diplome/features/my_event/data/model/client_model.dart';
import 'package:diplome/features/my_event/data/model/roles_model.dart';
import 'package:diplome/features/my_event/presentation/controller/admin_screen_code.dart';
import 'package:diplome/features/my_event/presentation/widget/cards_for_admin/base_card.dart';
import 'package:flutter/material.dart';

class ClientCard extends BaseCard<ClientModel> {
  ClientCard({
    super.key,
    required super.data,
    required super.onUpdated,
    required super.onDeleted,
    required super.title,
    required this.accounts,
    required this.onAccountChanged,
  })  : firstNameController = TextEditingController(text: data.firstName),
        middleNameController = TextEditingController(text: data.middleName),
        lastNameController = TextEditingController(text: data.lastName),
        _localData = data;

  final TextEditingController firstNameController;
  final TextEditingController middleNameController;
  final TextEditingController lastNameController;
  final List<AccountModel> accounts;
  final ValueChanged<AccountModel> onAccountChanged;

  late ClientModel _localData;

  @override
  List<Widget> getFields(BuildContext context) {
    return [
      TextField(
        controller: firstNameController,
        decoration: const InputDecoration(labelText: "Имя"),
      ),
      TextField(
        controller: middleNameController,
        decoration: const InputDecoration(labelText: "Отчество"),
      ),
      TextField(
        controller: lastNameController,
        decoration: const InputDecoration(labelText: "Фамилия"),
      ),
      DropdownButtonFormField<AccountModel>(
        decoration: const InputDecoration(labelText: "Аккаунт"),
        value: findCorrespondingAccount(data.account, accounts),
        items: accounts
            .map<DropdownMenuItem<AccountModel>>((account) {
              return DropdownMenuItem<AccountModel>(
                key: UniqueKey(),
                value: account,
                child: Text(account.login),
              );
            })
            .toSet() // Удаление дубликатов
            .toList(),
        onChanged: (value) {
          onAccountChanged(value!);
        },
      ),
    ];
  }

  @override
  Future<void> onUpdatePressed() async {
    _localData = ClientModel(
      idClient: data.idClient,
      firstName: firstNameController.text,
      middleName: middleNameController.text,
      lastName: lastNameController.text,
      account: data.account,
    );
    await AdminDataSource().updateClient(_localData);
  }

  void updateData() async {
    ClientModel updated = ClientModel(
      idClient: data.idClient,
      firstName: firstNameController.text,
      middleName: middleNameController.text,
      lastName: lastNameController.text,
      account: data.account,
    );

    await AdminDataSource().updateClient(updated);
  }
}

final AccountModel defaultAccount = AccountModel(
  idAccount: -1,
  login: '',
  password: '',
  address: '',
  phone: '',
  mail: '',
  roleModel: RoleModel(idRoles: 0, nameRoles: ''),
);

AccountModel findCorrespondingAccount(
    AccountModel account, List<AccountModel> accounts) {
  return accounts.firstWhere(
    (a) => a.idAccount == account.idAccount,
    orElse: () => defaultAccount,
  );
}
