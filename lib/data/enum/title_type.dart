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
}
