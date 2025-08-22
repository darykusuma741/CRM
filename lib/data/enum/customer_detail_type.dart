enum CustomerDetailType { company, individual }

extension CustomerDetailTypeExtension on CustomerDetailType {
  String toShortString() {
    switch (this) {
      case CustomerDetailType.company:
        return 'Company';
      case CustomerDetailType.individual:
        return 'Individual';
    }
  }

  static CustomerDetailType fromString(String value) {
    switch (value) {
      case 'Company':
        return CustomerDetailType.company;
      case 'Individual':
        return CustomerDetailType.individual;
      default:
        throw ArgumentError('Unknown CustomerDetailType: $value');
    }
  }

  bool get isCompany => this == CustomerDetailType.company;
  bool get isIndividual => this == CustomerDetailType.individual;
}
