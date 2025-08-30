import '../../common/load_data_result/load_data_result.dart';
import '../../common/processing/future_processing.dart';
import '../models/addcustomer/add_customer_parameter.dart';
import '../models/addcustomer/add_customer_response.dart';
import '../models/addcustomeradditionaladdress/add_customer_additional_address_parameter.dart';
import '../models/addcustomeradditionaladdress/add_customer_additional_address_response.dart';
import '../models/addresstype/address_type_parameter.dart';
import '../models/addresstype/address_type_response.dart';
import '../models/customeradditionaladdressbasedcustomer/customer_additional_address_based_customer_parameter.dart';
import '../models/customeradditionaladdressbasedcustomer/customer_additional_address_based_customer_response.dart';
import '../models/customeradditionaladdresscount/customer_additional_address_count_parameter.dart';
import '../models/customeradditionaladdresscount/customer_additional_address_count_response.dart';
import '../models/customeradditionaladdressdetail/customer_additional_address_detail_parameter.dart';
import '../models/customeradditionaladdressdetail/customer_additional_address_detail_response.dart';
import '../models/customercategory/customer_category_parameter.dart';
import '../models/customercategory/customer_category_response.dart';
import '../models/customerdetail/customer_detail_parameter.dart';
import '../models/customerdetail/customer_detail_response.dart';
import '../models/customerlist/customer_list_parameter.dart';
import '../models/customerlist/customer_list_response.dart';
import '../models/customerpagingdata/customer_paging_data_parameter.dart';
import '../models/customerpagingdata/customer_paging_data_response.dart';
import '../models/customerpaymenttermpagingdata/customer_payment_term_paging_data_parameter.dart';
import '../models/customerpaymenttermpagingdata/customer_payment_term_paging_data_response.dart';
import '../models/customerpricelistpagingdata/customer_pricelist_paging_data_parameter.dart';
import '../models/customerpricelistpagingdata/customer_pricelist_paging_data_response.dart';
import '../models/customertitle/customer_title_parameter.dart';
import '../models/customertitle/customer_title_response.dart';
import '../models/editcustomer/edit_customer_parameter.dart';
import '../models/editcustomer/edit_customer_response.dart';
import '../models/editcustomeradditionaladdress/edit_customer_additional_address_parameter.dart';
import '../models/editcustomeradditionaladdress/edit_customer_additional_address_response.dart';
import '../remotedatasources/customerremotedatasource/customer_remote_data_source.dart';
import '../repositories/customer_repository.dart';

class DefaultCustomerRepository implements CustomerRepository {
  final CustomerRemoteDataSource customerRemoteDataSource;

  DefaultCustomerRepository({
    required this.customerRemoteDataSource
  });

  @override
  FutureProcessing<LoadDataResult<CustomerPagingDataResponse>> customerPagingData(CustomerPagingDataParameter customerPagingDataParameter) {
    return customerRemoteDataSource.customerPagingData(customerPagingDataParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<CustomerCategoryResponse>> customerCategory(CustomerCategoryParameter customerCategoryParameter) {
    return customerRemoteDataSource.customerCategory(customerCategoryParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<CustomerListResponse>> customerList(CustomerListParameter customerListParameter) {
    return customerRemoteDataSource.customerList(customerListParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<CustomerDetailResponse>> customerDetail(CustomerDetailParameter customerDetailParameter) {
    return customerRemoteDataSource.customerDetail(customerDetailParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<CustomerPaymentTermPagingDataResponse>> customerPaymentTermPagingData(CustomerPaymentTermPagingDataParameter customerPaymentTermPagingDataParameter) {
    return customerRemoteDataSource.customerPaymentTermPagingData(customerPaymentTermPagingDataParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<CustomerPricelistPagingDataResponse>> customerPricelistPagingData(CustomerPricelistPagingDataParameter customerPricelistPagingDataParameter) {
    return customerRemoteDataSource.customerPricelistPagingData(customerPricelistPagingDataParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<AddCustomerResponse>> addCustomer(AddCustomerParameter addCustomerParameter) {
    return customerRemoteDataSource.addCustomer(addCustomerParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<EditCustomerResponse>> editCustomer(EditCustomerParameter editCustomerParameter) {
    return customerRemoteDataSource.editCustomer(editCustomerParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<CustomerAdditionalAddressCountResponse>> customerAdditionalAddressCount(CustomerAdditionalAddressCountParameter customerAdditionalAddressCountParameter) {
    return customerRemoteDataSource.customerAdditionalAddressCount(customerAdditionalAddressCountParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<CustomerAdditionalAddressDetailResponse>> customerAdditionalAddressDetail(CustomerAdditionalAddressDetailParameter customerAdditionalAddressDetailParameter) {
    return customerRemoteDataSource.customerAdditionalAddressDetail(customerAdditionalAddressDetailParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<CustomerAdditionalAddressBasedCustomerResponse>> customerAdditionalAddressBasedCustomer(CustomerAdditionalAddressBasedCustomerParameter customerAdditionalAddressBasedCustomerParameter) {
    return customerRemoteDataSource.customerAdditionalAddressBasedCustomer(customerAdditionalAddressBasedCustomerParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<AddCustomerAdditionalAddressResponse>> addCustomerAdditionalAddress(AddCustomerAdditionalAddressParameter addCustomerAdditionalAddressParameter) {
    return customerRemoteDataSource.addCustomerAdditionalAddress(addCustomerAdditionalAddressParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<EditCustomerAdditionalAddressResponse>> editCustomerAdditionalAddress(EditCustomerAdditionalAddressParameter editCustomerAdditionalAddressParameter) {
    return customerRemoteDataSource.editCustomerAdditionalAddress(editCustomerAdditionalAddressParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<AddressTypeResponse>> addressType(AddressTypeParameter addressTypeParameter) {
    return customerRemoteDataSource.addressType(addressTypeParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<CustomerTitleResponse>> customerTitle(CustomerTitleParameter customerTitleParameter) {
    return customerRemoteDataSource.customerTitle(customerTitleParameter).mapToLoadDataResult();
  }
}