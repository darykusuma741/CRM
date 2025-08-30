// ignore_for_file: public_member_api_docs, sort_constructors_first
class ActivityType {
  int id;
  String label;
  bool isChecked;

  ActivityType({
    required this.id,
    required this.label,
    this.isChecked = false,
  });

  @override
  String toString() =>
      'ActivityType(id: $id, label: $label, isChecked: $isChecked)';
}
