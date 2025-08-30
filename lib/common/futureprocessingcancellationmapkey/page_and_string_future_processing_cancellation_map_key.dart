import 'string_future_processing_cancellation_map_key.dart';

class PageAndStringFutureProcessingCancellationMapKey<PageKeyType> extends StringFutureProcessingCancellationMapKey {
  PageKeyType page;

  PageAndStringFutureProcessingCancellationMapKey({
    required this.page,
    required super.key,
    super.subKey
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is PageAndStringFutureProcessingCancellationMapKey &&
          runtimeType == other.runtimeType &&
          page == other.page;

  @override
  int get hashCode => super.hashCode ^ page.hashCode;

  @override
  PageAndStringFutureProcessingCancellationMapKey<PageKeyType> copy({
    PageKeyType? page,
    String? key,
    String? subKey
  }) {
    return PageAndStringFutureProcessingCancellationMapKey(
      page: page ?? this.page,
      key: key ?? this.key,
      subKey: subKey ?? this.subKey
    );
  }
}