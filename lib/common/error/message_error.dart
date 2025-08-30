import 'package:crm/common/ext/string_ext.dart';

class MessageError extends Error {
  final String title;
  final String message;
  final dynamic data;

  MessageError({
    this.title = "",
    this.message = "",
    this.data
  });

  @override
  String toString() {
    String messageResult = "";
    void addMessageResult(String value) {
      messageResult += "${messageResult.isEmptyString ? "" : ": "}$value";
    }
    if (!title.isEmptyString) {
      addMessageResult(title);
    }
    if (!message.isEmptyString) {
      addMessageResult(message);
    }
    return messageResult;
  }
}