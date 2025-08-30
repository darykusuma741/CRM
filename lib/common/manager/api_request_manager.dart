import '../futureprocessingcancellationmapkey/future_processing_cancellation_map_key.dart';
import '../futureprocessingcancellationmapkey/page_and_string_future_processing_cancellation_map_key.dart';
import '../futureprocessingcancellationmapkey/string_future_processing_cancellation_map_key.dart';
import '../processing/future_processing_cancellation/future_processing_cancellation.dart';
import '../processing/future_processing_cancellation_creator/future_processing_cancellation_creator.dart';

class ApiRequestManager {
  late Map<FutureProcessingCancellationMapKey, FutureProcessingCancellation> _cancelTokenMap;
  Map<FutureProcessingCancellationMapKey, FutureProcessingCancellation> get cancelTokenMap => _cancelTokenMap;

  ApiRequestManager() {
    _cancelTokenMap = <FutureProcessingCancellationMapKey, FutureProcessingCancellation>{};
  }

  MapEntry<FutureProcessingCancellationMapKey, FutureProcessingCancellation> addRequestToCancellationPartWithStringKey(StringFutureProcessingCancellationMapKey key, FutureProcessingCancellationCreator futureProcessingCancellationCreator, {bool duplicate = false}) {
    StringFutureProcessingCancellationMapKey oldKey = key.copy();
    StringFutureProcessingCancellationMapKey newKey = key.copy();
    if (_cancelTokenMap.containsKey(oldKey)) {
      if (!duplicate) {
        _cancelTokenMap[oldKey]?.cancel("Cancelled");
      } else {
        int i = 1;
        while (true) {
          newKey.key = "${oldKey.key}-$i";
          if (!_cancelTokenMap.containsKey(newKey)) {
            break;
          }
        }
        i++;
      }
    }
    FutureProcessingCancellation futureProcessingCancellation = futureProcessingCancellationCreator.createFutureProcessingCancellation();
    _cancelTokenMap[newKey] = futureProcessingCancellation;
    return MapEntry<FutureProcessingCancellationMapKey, FutureProcessingCancellation>(newKey, futureProcessingCancellation);
  }

  MapEntry<FutureProcessingCancellationMapKey, FutureProcessingCancellation> addRequestToCancellationPart(String key, FutureProcessingCancellationCreator futureProcessingCancellationCreator, {bool duplicate = false}) {
    return addRequestToCancellationPartWithStringKey(StringFutureProcessingCancellationMapKey(key: key), futureProcessingCancellationCreator, duplicate: duplicate);
  }

  void cancelAllDesiredPageKeyedRequest(dynamic desiredPageKey, {String? subKey}) {
    _cancelRequestBasedDesiredPageKeyedRequest(desiredPageKey, subKey);
    _removeCancelRequestBasedDesiredPageKeyedRequest(desiredPageKey, subKey);
  }

  void _cancelRequestBasedDesiredPageKeyedRequest(dynamic desiredPageKey, String? subKey) {
    _cancelTokenMap.forEach((key, value) {
      _iterateCancelRequestBasedDesiredPageKeyedRequest(key, value, subKey, desiredPageKey, (key, value) => value.cancel(), (key, value) {});
    });
  }

  void _removeCancelRequestBasedDesiredPageKeyedRequest(dynamic desiredPageKey, String? subKey) {
    _cancelTokenMap.removeWhere((key, value) {
      return _iterateCancelRequestBasedDesiredPageKeyedRequest(key, value, subKey, desiredPageKey, (key, value) => true, (key, value) => false);
    });
  }

  T _iterateCancelRequestBasedDesiredPageKeyedRequest<T>(
    FutureProcessingCancellationMapKey key,
    FutureProcessingCancellation value,
    String? subKey,
    dynamic desiredPageKey,
    T Function(FutureProcessingCancellationMapKey key, FutureProcessingCancellation value) onIterateCancelRequest,
    T Function(FutureProcessingCancellationMapKey key, FutureProcessingCancellation value) onElseIterateCancelRequest
  ) {
    if (key is StringFutureProcessingCancellationMapKey) {
      bool checkingSubKey = true;
      if (key is PageAndStringFutureProcessingCancellationMapKey) {
        if (key.page is int && desiredPageKey is int) {
          if (key.page >= desiredPageKey) {
            // Marked to begin checking sub key
          } else {
            checkingSubKey = false;
          }
        } else {
          checkingSubKey = false;
        }
      }
      if (checkingSubKey) {
        if (subKey != null) {
          if (key.subKey == subKey) {
            return onIterateCancelRequest(key, value);
          }
        } else {
          return onIterateCancelRequest(key, value);
        }
      }
    }
    return onElseIterateCancelRequest(key, value);
  }

  void cancelAllRequest() {
    _cancelTokenMap.forEach((key, value) {
      value.cancel("Cancelled");
    });
    _cancelTokenMap.clear();
  }
}