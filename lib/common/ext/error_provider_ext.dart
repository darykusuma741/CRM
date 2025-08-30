import '../error_provider/error_provider.dart';

extension ErrorProviderResultExt on ErrorProviderResult? {
  ErrorProviderResult toErrorProviderResultNonNull() {
    if (this == null) {
      return ErrorProviderResult(
        title: "Something Failed",
        message: "There is something failed"
      );
    }
    return this!;
  }
}