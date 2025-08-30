import 'package:logger/logger.dart';

class LoggerHelper {
  static final Logger appLogger = Logger(
    filter: DevelopmentFilter(),
    printer: PrettyPrinter(
      methodCount: 0,
      lineLength: 75,
      colors: true,
      printEmojis: false,
      dateTimeFormat: DateTimeFormat.none, // DateTimeFormat.dateAndTime
    ),
  );
}