import 'package:diplome/features/my_event/data/model/account_model.dart';

class OrganisationModel {
  OrganisationModel({
    required this.idOrganisation,
    required this.nameOrganisation,
    required this.rating,
    required this.account,
  });

  factory OrganisationModel.fromJson(Map<String, dynamic> json) {
    return OrganisationModel(
      idOrganisation: json['ID_Organisation'],
      nameOrganisation: json['Name_Organisation'],
      rating: json['Rating'],
      account: AccountModel.fromJson(json['Account']),
    );
  }

  final AccountModel account;
  final int idOrganisation;
  final String nameOrganisation;
  final double rating;
}
