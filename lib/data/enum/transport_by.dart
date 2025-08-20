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
}
