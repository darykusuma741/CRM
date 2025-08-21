enum AddressType { contact, deliveryAddress, invoiceAddress, otherAddress }

extension AddressTypeExtension on AddressType {
  String toShortString() {
    switch (this) {
      case AddressType.contact:
        return 'Contact';
      case AddressType.deliveryAddress:
        return 'Delivery Address';
      case AddressType.invoiceAddress:
        return 'Invoice Address';
      case AddressType.otherAddress:
        return 'Other Address';
    }
  }
}
