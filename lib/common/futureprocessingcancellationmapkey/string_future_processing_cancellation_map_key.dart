import 'future_processing_cancellation_map_key.dart';

class StringFutureProcessingCancellationMapKey extends FutureProcessingCancellationMapKey {
  String key;
  String? subKey;

  StringFutureProcessingCancellationMapKey({
    required this.key,
    this.subKey
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StringFutureProcessingCancellationMapKey &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          subKey == other.subKey;

  @override
  int get hashCode => key.hashCode ^ subKey.hashCode;

  StringFutureProcessingCancellationMapKey copy({
    String? key,
    String? subKey
  }) {
    return StringFutureProcessingCancellationMapKey(
      key: key ?? this.key,
      subKey: subKey ?? this.subKey
    );
  }
}