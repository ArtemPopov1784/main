class RoleModel {
  RoleModel({
    required this.idRoles,
    required this.nameRoles,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      idRoles: json['ID_Roles'],
      nameRoles: json['Name_Roles'],
    );
  }

  late final int idRoles;
  final String nameRoles;
}
