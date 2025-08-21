import 'package:crm/common/abstract/base_model.dart';
import 'package:crm/data/enum/transport_by.dart';

class MarkingModel extends BaseModel<MarkingModel> {
  int id;
  String markingName;
  TransportBy transportBy;

  MarkingModel({
    required this.id,
    required this.markingName,
    required this.transportBy,
  });

  @override
  MarkingModel copyWith({
    int? id,
    String? markingName,
    TransportBy? transportBy,
  }) {
    return MarkingModel(
      id: id ?? this.id,
      markingName: markingName ?? this.markingName,
      transportBy: transportBy ?? this.transportBy,
    );
  }
}
