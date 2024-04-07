class TypeEventModel {
  TypeEventModel({
    required this.idTypeEvents,
    required this.nameTypeEvents,
  });

  factory TypeEventModel.fromJson(Map<String, dynamic> json) {
    return TypeEventModel(
      idTypeEvents: json['ID_Type_Events'],
      nameTypeEvents: json['Name_Type_Events'],
    );
  }

  final int idTypeEvents;
  final String nameTypeEvents;
}
