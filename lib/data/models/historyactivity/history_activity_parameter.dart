enum HistoryActivityParameterType {
  pipeline, calendar
}

class HistoryActivityParameter {
  HistoryActivityParameterType type;

  HistoryActivityParameter({
    required this.type
  });
}