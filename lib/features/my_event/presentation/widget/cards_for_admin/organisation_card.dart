import 'package:diplome/features/my_event/data/model/account_model.dart';
import 'package:diplome/features/my_event/data/model/organisation_model.dart';
import 'package:diplome/features/my_event/data/model/roles_model.dart';
import 'package:diplome/features/my_event/presentation/controller/admin_screen_code.dart';
import 'package:diplome/features/my_event/presentation/widget/cards_for_admin/base_card.dart';
import 'package:flutter/material.dart';

class OrganisationCard extends BaseCard<OrganisationModel> {
  OrganisationCard({
    super.key,
    required super.data,
    required super.onUpdated,
    required super.onDeleted,
    required super.title,
    required this.accounts,
    required this.onAccountChanged,
  })  : nameController = TextEditingController(text: data.nameOrganisation),
        ratingController = TextEditingController(text: data.rating.toString()),
        _localData = data;

  final List<AccountModel> accounts;
  final TextEditingController nameController;
  final ValueChanged<AccountModel> onAccountChanged;
  final TextEditingController ratingController;

  late OrganisationModel _localData;

  @override
  List<Widget> getFields(BuildContext context) {
    return [
      TextField(
        controller: nameController,
        decoration: const InputDecoration(labelText: "Название"),
      ),
      TextField(
        controller: ratingController,
        decoration: const InputDecoration(labelText: "Рейтинг"),
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
    _localData = OrganisationModel(
      idOrganisation: data.idOrganisation,
      nameOrganisation: nameController.text,
      rating: int.parse(ratingController.text),
      account: data.account,
    );
    await AdminDataSource().updateOrganisation(_localData);
  }

  void updateData() async {
    OrganisationModel updated = OrganisationModel(
      idOrganisation: data.idOrganisation,
      nameOrganisation: nameController.text,
      rating: int.parse(ratingController.text),
      account: data.account,
    );

    await AdminDataSource().updateOrganisation(updated);
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
