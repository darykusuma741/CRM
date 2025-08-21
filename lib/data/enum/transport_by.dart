enum TransportBy { air, ocean, all }

extension TransportByExtension on TransportBy {
  String toShortString() {
    switch (this) {
      case TransportBy.air:
        return 'Air';
      case TransportBy.ocean:
        return 'Ocean';
      case TransportBy.all:
        return 'Air and Ocean';
    }
  }

  static TransportBy fromString(String value) {
    switch (value) {
      case 'Air':
        return TransportBy.air;
      case 'Ocean':
        return TransportBy.ocean;
      case 'Air and Ocean':
        return TransportBy.all;
      default:
        throw ArgumentError('Unknown TitleType: $value');
    }
  }

  bool get isAir => this == TransportBy.air;
  bool get isOcean => this == TransportBy.ocean;
  bool get isAll => this == TransportBy.all;
}
