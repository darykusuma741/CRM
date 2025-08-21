enum TitleType { ms, mr }

extension TitleTypeExtension on TitleType {
  String toShortString() {
    switch (this) {
      case TitleType.ms:
        return 'Ms.';
      case TitleType.mr:
        return 'Mr.';
    }
  }

  static TitleType fromString(String value) {
    switch (value) {
      case 'Ms.':
        return TitleType.ms;
      case 'Mr.':
        return TitleType.mr;
      default:
        throw ArgumentError('Unknown TitleType: $value');
    }
  }
}
