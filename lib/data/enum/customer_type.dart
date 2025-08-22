enum CustomerType { personal, broker }

extension CustomerTypeExtension on CustomerType {
  String toShortString() {
    switch (this) {
      case CustomerType.broker:
        return 'Broker';
      case CustomerType.personal:
        return 'Personal';
    }
  }

  static CustomerType fromString(String value) {
    switch (value) {
      case 'Personal':
        return CustomerType.personal;
      case 'Broker':
        return CustomerType.broker;
      default:
        throw ArgumentError('Unknown CustomerType: $value');
    }
  }

  bool get isBroker => this == CustomerType.broker;
  bool get isPersonal => this == CustomerType.personal;
}
