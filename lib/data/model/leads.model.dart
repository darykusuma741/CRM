import 'package:crm/common/abstract/base_model.dart';

class LeadsModel extends BaseModel<LeadsModel> {
  int id;
  String title;
  String name;
  String email;
  String noHp;
  String jobPosition;
  String address;
  int rating;
  LeadsType type;

  LeadsModel({
    required this.id,
    required this.title,
    required this.name,
    required this.email,
    required this.noHp,
    required this.jobPosition,
    required this.address,
    required this.rating,
    required this.type,
  });

  @override
  LeadsModel copyWith({
    int? id,
    String? title,
    String? name,
    String? email,
    String? noHp,
    String? jobPosition,
    String? address,
    int? rating,
    LeadsType? type,
  }) {
    return LeadsModel(
      id: id ?? this.id,
      title: title ?? this.title,
      name: name ?? this.name,
      email: email ?? this.email,
      noHp: noHp ?? this.noHp,
      jobPosition: jobPosition ?? this.jobPosition,
      rating: rating ?? this.rating,
      type: type ?? this.type,
      address: address ?? this.address,
    );
  }
}

enum LeadsType {
  prospects,
  lost,
}

extension LeadsTypeExtension on LeadsType {
  String toShortString() {
    switch (this) {
      case LeadsType.lost:
        return 'Lost';
      case LeadsType.prospects:
        return 'Prospects';
    }
  }
}
