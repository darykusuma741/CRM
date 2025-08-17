import 'package:crm/common/abstract/base_model.dart';

class LeadsModel extends BaseModel<LeadsModel> {
  int id;
  String title;
  String email;
  String noHp;
  int rating;
  LeadsType type;

  LeadsModel({
    required this.id,
    required this.title,
    required this.email,
    required this.noHp,
    required this.rating,
    required this.type,
  });

  @override
  LeadsModel copyWith({
    int? id,
    String? title,
    String? email,
    String? noHp,
    int? rating,
    LeadsType? type,
  }) {
    return LeadsModel(
      id: id ?? this.id,
      title: title ?? this.title,
      email: email ?? this.email,
      noHp: noHp ?? this.noHp,
      rating: rating ?? this.rating,
      type: type ?? this.type,
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
