import '../customerpagingdata/customer_paging_data_parameter.dart';

class AddCustomerResponse {
  String customerId;
  String customerName;
  CustomerType customerType;

  AddCustomerResponse({
    required this.customerId,
    required this.customerName,
    required this.customerType
  });
}