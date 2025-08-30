import 'package:crm/common/ext/response_wrapper_ext.dart';
import 'package:crm/common/ext/string_ext.dart';
import 'package:crm/data/mapping/paging_mapping_ext.dart';

import '../../common/error/message_error.dart';
import '../../common/responsewrapper/response_wrapper.dart';
import '../models/addcustomer/add_customer_response.dart';
import '../models/addcustomeradditionaladdress/add_customer_additional_address_response.dart';
import '../models/address_type.dart';
import '../models/addresstype/address_type_response.dart';
import '../models/customer_category.dart';
import '../models/customer_detail.dart';
import '../models/customer_title.dart';
import '../models/customeradditionaladdressbasedcustomer/customer_additional_address_based_customer_response.dart';
import '../models/customeradditionaladdresscount/customer_additional_address_count_response.dart';
import '../models/customeradditionaladdressdetail/customer_additional_address_detail_response.dart';
import '../models/customerdetail/customer_detail_response.dart';
import '../models/customerlist/customer_list_response.dart';
import '../models/customerpagingdata/customer_paging_data_parameter.dart';
import '../models/customerpagingdata/customer_paging_data_response.dart';
import '../models/customerpaymenttermpagingdata/customer_payment_term_paging_data_response.dart';
import '../models/customerpricelistpagingdata/customer_pricelist_paging_data_response.dart';
import '../models/customertitle/customer_title_response.dart';
import '../models/editcustomer/edit_customer_response.dart';
import '../models/editcustomeradditionaladdress/edit_customer_additional_address_response.dart';
import '../models/short_customer.dart';
import '../models/short_customer_additional_address.dart';
import '../models/short_customer_payment_term.dart';
import '../models/short_customer_pricelist.dart';

extension CustomerEntityMappingExt on ResponseWrapper {
  CustomerPagingDataResponse mapFromResponseToCustomerPagingDataResponse(List<CustomerCategory> customerCategoryList) {
    return CustomerPagingDataResponse(
      shortCustomerPagingData: ResponseWrapper(response).mapFromResponseToPagingData<ShortCustomer>(
        (dataResponse) => ResponseWrapper(dataResponse).mapFromResponseToList(
          (value) => ResponseWrapper(value).mapFromResponseToShortCustomer(customerCategoryList)
        ),
        dataFieldName: "result"
      )
    );
  }

  CustomerListResponse mapFromResponseToCustomerListResponse(List<CustomerCategory> customerCategoryList) {
    var customerListResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "result");
    return CustomerListResponse(
      shortCustomerList: customerListResponseWrapper.mapFromResponseToList(
        (value) => ResponseWrapper(value).mapFromResponseToShortCustomer(customerCategoryList)
      )
    );
  }

  String _mapFromResponseToCustomerName() {
    var name = ResponseWrapper(response["name"]).mapFromResponseToNonNullableString();
    if (name.isEmptyString) {
      var email = ResponseWrapper(response["email"]).mapFromResponseToNonNullableString();
      return email;
    }
    return name;
  }

  CustomerCategory _mapFromResponseToCustomerCategory(List<CustomerCategory> customerCategoryList) {
    var companyType = ResponseWrapper(response["company_type"]).mapFromResponseToNonNullableString().toLowerCase();
    var customerCategory = customerCategoryList.where(
      (iterableCustomerCategory) {
        return iterableCustomerCategory.value.toLowerCase() == companyType.toLowerCase();
      }
    ).firstOrNull;
    if (customerCategory == null) {
      throw MessageError(
        title: "Customer Type Not Suitable",
        message: "Customer type is not suitable"
      );
    }
    return customerCategory;
  }

  ShortCustomer mapFromResponseToShortCustomer(List<CustomerCategory> customerCategoryList) {
    var stateResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "state_id");
    var countryResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "country_id");
    return ShortCustomer(
      id: ResponseWrapper(response["id"]).mapFromResponseToNonNullableString(),
      name: _mapFromResponseToCustomerName(),
      companyName: ResponseWrapper(response["partner_name"]).mapFromResponseToNonNullableString(),
      email: ResponseWrapper(response["email"]).mapFromResponseToNonNullableString(),
      city: ResponseWrapper(response["city"]).mapFromResponseToNonNullableString(),
      zip: ResponseWrapper(response["zip"]).mapFromResponseToNonNullableString(),
      jobPosition: ResponseWrapper(response["function"]).mapFromResponseToNonNullableString(),
      customerCategory: _mapFromResponseToCustomerCategory(customerCategoryList),
      stateId: stateResponseWrapper.getArrayData(0).mapFromResponseToNonNullableString(),
      stateName: stateResponseWrapper.getArrayData(1).mapFromResponseToNonNullableString(),
      countryId: countryResponseWrapper.getArrayData(0).mapFromResponseToNonNullableString(),
      countryName: countryResponseWrapper.getArrayData(1).mapFromResponseToNonNullableString(),
      website: ResponseWrapper(response["website"]).mapFromResponseToNonNullableString(),
    );
  }

  CustomerDetailResponse mapFromResponseToCustomerDetailResponse(List<CustomerCategory> customerCategoryList) {
    ResponseWrapper resultResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "result");
    var shortHistoryPipelineActivityList = resultResponseWrapper.mapFromResponseToList(
      (value) => ResponseWrapper(value).mapFromResponseToCustomerDetail(customerCategoryList)
    ).toList();
    if (shortHistoryPipelineActivityList.isEmpty) {
      throw MessageError(
        title: "Customer Not Found",
        message: "Customer is not found"
      );
    }
    return CustomerDetailResponse(
      customerDetail: shortHistoryPipelineActivityList.first
    );
  }

  CustomerDetail mapFromResponseToCustomerDetail(List<CustomerCategory> customerCategoryList) {
    var taxResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "tax_id");
    var stateResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "state_id");
    var countryResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "country_id");
    var userResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "user_id");
    return CustomerDetail(
      id: ResponseWrapper(response["id"]).mapFromResponseToNonNullableString(),
      userId: userResponseWrapper.getArrayData(0).mapFromResponseToNonNullableString(),
      userName: userResponseWrapper.getArrayData(1).mapFromResponseToNonNullableString(),
      name: _mapFromResponseToCustomerName(),
      companyName: ResponseWrapper(response["partner_name"]).mapFromResponseToNonNullableString(),
      email: ResponseWrapper(response["email"]).mapFromResponseToNonNullableString(),
      city: ResponseWrapper(response["city"]).mapFromResponseToNonNullableString(),
      zip: ResponseWrapper(response["zip"]).mapFromResponseToNonNullableString(),
      jobPosition: ResponseWrapper(response["function"]).mapFromResponseToNonNullableString(),
      street: ResponseWrapper(response["street"]).mapFromResponseToNonNullableString(),
      street2: ResponseWrapper(response["street2"]).mapFromResponseToNonNullableString(),
      phoneNumber: ResponseWrapper(response["phone"]).mapFromResponseToNonNullableString(),
      whatsappNumber: ResponseWrapper(response["mobile"]).mapFromResponseToNonNullableString(),
      customerCategory: _mapFromResponseToCustomerCategory(customerCategoryList),
      taxNo: ResponseWrapper(response["vat"]).mapFromResponseToNonNullableString(),
      taxId: taxResponseWrapper.getArrayData(0).mapFromResponseToNonNullableString(),
      taxName: taxResponseWrapper.getArrayData(1).mapFromResponseToNonNullableString(),
      stateId: stateResponseWrapper.getArrayData(0).mapFromResponseToNonNullableString(),
      stateName: stateResponseWrapper.getArrayData(1).mapFromResponseToNonNullableString(),
      countryId: countryResponseWrapper.getArrayData(0).mapFromResponseToNonNullableString(),
      countryName: countryResponseWrapper.getArrayData(1).mapFromResponseToNonNullableString(),
      website: ResponseWrapper(response["website"]).mapFromResponseToNonNullableString(),
    );
  }

  CustomerPricelistPagingDataResponse mapFromResponseToCustomerPricelistPagingDataResponse() {
    return CustomerPricelistPagingDataResponse(
      shortCustomerPricelistPagingData: ResponseWrapper(response).mapFromResponseToPagingData<ShortCustomerPricelist>(
        (dataResponse) => ResponseWrapper(dataResponse).mapFromResponseToList(
          (value) => ResponseWrapper(value).mapFromResponseToShortCustomerPricelist()
        ),
        dataFieldName: "result"
      )
    );
  }

  ShortCustomerPricelist mapFromResponseToShortCustomerPricelist() {
    return ShortCustomerPricelist(
      id: ResponseWrapper(response["id"]).mapFromResponseToNonNullableString(),
      name: ResponseWrapper(response["name"]).mapFromResponseToNonNullableString()
    );
  }

  CustomerPaymentTermPagingDataResponse mapFromResponseToCustomerPaymentTermPagingDataResponse() {
    return CustomerPaymentTermPagingDataResponse(
      shortCustomerPaymentTermPagingData: ResponseWrapper(response).mapFromResponseToPagingData<ShortCustomerPaymentTerm>(
        (dataResponse) => ResponseWrapper(dataResponse).mapFromResponseToList(
          (value) => ResponseWrapper(value).mapFromResponseToShortCustomerPaymentTerm()
        ),
        dataFieldName: "AccountPaymentTerm"
      )
    );
  }

  ShortCustomerPaymentTerm mapFromResponseToShortCustomerPaymentTerm() {
    return ShortCustomerPaymentTerm(
      id: ResponseWrapper(response["id"]).mapFromResponseToNonNullableString(),
      name: ResponseWrapper(response["name"]).mapFromResponseToNonNullableString()
    );
  }

  AddCustomerResponse mapFromResponseToAddCustomerResponse() {
    ResponseWrapper resultDataResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "createResPartner");
    List<Map<String, dynamic>> resultMapList = resultDataResponseWrapper.mapFromResponseToList((responseData) => responseData);
    if (resultMapList.isEmpty) {
      throw MessageError(
        title: "Error Parsing Add Customer Response",
        message: "Error parsing when add customer response"
      );
    }
    Map<String, dynamic> currentResultMap = resultMapList.first;
    return AddCustomerResponse(
      customerId: ResponseWrapper(currentResultMap["id"]).mapFromResponseToNonNullableString(),
      customerName: ResponseWrapper(currentResultMap["name"]).mapFromResponseToNonNullableString(),
      customerType: () {
        var customerTypeResult = ResponseWrapper(currentResultMap["id"]).mapFromResponseToNonNullableString();
        if (customerTypeResult.toLowerCase() == "company") {
          return CustomerType.company;
        } else {
          return CustomerType.individual;
        }
      }()
    );
  }

  EditCustomerResponse mapFromResponseToEditCustomerResponse() {
    return EditCustomerResponse();
  }

  CustomerAdditionalAddressCountResponse mapFromResponseToCustomerAdditionalAddressCountResponse() {
    ResponseWrapper dataResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper();
    ResponseWrapper resultDataResponseWrapper = dataResponseWrapper.mapFromResponseToDataResponseWrapper(dataFieldName: "result");
    return CustomerAdditionalAddressCountResponse(
      count: resultDataResponseWrapper.mapFromResponseToNonNullableInt()
    );
  }

  CustomerAdditionalAddressBasedCustomerResponse mapFromResponseToCustomerAdditionalAddressBasedCustomerResponse() {
    var shortCustomerAdditionalAddressResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "result");
    var resultList = shortCustomerAdditionalAddressResponseWrapper.mapFromResponseToList(
      (value) => ResponseWrapper(value).mapFromResponseToShortCustomerAdditionalAddress()
    );
    if (resultList.isEmpty) {
      throw MessageError(
        title: "No Additional Address",
        message: "Add a new address to support your business needs."
      );
    }
    return CustomerAdditionalAddressBasedCustomerResponse(
      shortCustomerAdditionalAddressList: resultList
    );
  }

  CustomerAdditionalAddressDetailResponse mapFromResponseToCustomerAdditionalAddressDetailResponse() {
    var shortCustomerAdditionalAddressResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "result");
    var resultList = shortCustomerAdditionalAddressResponseWrapper.mapFromResponseToList(
      (value) => ResponseWrapper(value).mapFromResponseToShortCustomerAdditionalAddress()
    );
    if (resultList.isEmpty) {
      throw MessageError(
        title: "Additional Address Not Found",
        message: "Additional address is not found"
      );
    }
    return CustomerAdditionalAddressDetailResponse(
      shortCustomerAdditionalAddress: resultList.first
    );
  }

  ShortCustomerAdditionalAddress mapFromResponseToShortCustomerAdditionalAddress() {
    var countryResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "country_id");
    var stateResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "state_id");
    return ShortCustomerAdditionalAddress(
      id: ResponseWrapper(response["id"]).mapFromResponseToNonNullableString(),
      contactName: ResponseWrapper(response["name"]).mapFromResponseToNonNullableString(),
      street: ResponseWrapper(response["street"]).mapFromResponseToNonNullableString(),
      street2: ResponseWrapper(response["street2"]).mapFromResponseToNonNullableString(),
      city: ResponseWrapper(response["city"]).mapFromResponseToNonNullableString(),
      state: stateResponseWrapper.getArrayData(1).mapFromResponseToNonNullableString(),
      stateId: stateResponseWrapper.getArrayData(0).mapFromResponseToNonNullableString(),
      zip: ResponseWrapper(response["zip"]).mapFromResponseToNonNullableString(),
      country: countryResponseWrapper.getArrayData(1).mapFromResponseToNonNullableString(),
      countryId: countryResponseWrapper.getArrayData(0).mapFromResponseToNonNullableString(),
      email: ResponseWrapper(response["email"]).mapFromResponseToNonNullableString(),
      phoneNumber: ResponseWrapper(response["phone"]).mapFromResponseToNonNullableString(),
      notes: ResponseWrapper(response["comment"]).mapFromResponseToNonNullableString(),
      type: ResponseWrapper(response["type"]).mapFromResponseToNonNullableString(),
      whatsappNumber: ResponseWrapper(response["mobile"]).mapFromResponseToNonNullableString(),
    );
  }

  AddCustomerAdditionalAddressResponse mapFromResponseToAddCustomerAdditionalAddressResponse() {
    return AddCustomerAdditionalAddressResponse();
  }

  EditCustomerAdditionalAddressResponse mapFromResponseToEditCustomerAdditionalAddressResponse() {
    return EditCustomerAdditionalAddressResponse();
  }

  AddressTypeResponse mapFromResponseToAddressTypeResponse() {
    var countryResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(
      dataFieldName: "result"
    );
    final Map<String, String> result = {};
    final RegExp tupleRegExp = RegExp(r"\('([^']+)'\s*,\s*'([^']+)'\)");
    final matches = tupleRegExp.allMatches(
      countryResponseWrapper.getArrayData(0).mapFromResponseToDataResponseWrapper(
        dataFieldName: "selection"
      ).mapFromResponseToNonNullableString()
    );
    for (final match in matches) {
      final key = match.group(1);
      final value = match.group(2);
      if (key != null && value != null) {
        result[key] = value;
      }
    }
    return AddressTypeResponse(
      addressTypeList: result.entries.map<AddressType>(
        (addressTypeMapEntry) => AddressType(
          name: addressTypeMapEntry.value,
          value: addressTypeMapEntry.key
        )
      ).toList()
    );
  }

  CustomerTitleResponse mapFromResponseToCustomerTitleResponse() {
    var shortCustomerAdditionalAddressResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "ResPartnerTitle");
    var resultList = shortCustomerAdditionalAddressResponseWrapper.mapFromResponseToList(
      (value) => ResponseWrapper(value).mapFromResponseToCustomerTitle()
    );
    if (resultList.isEmpty) {
      throw MessageError(
        title: "Customer Title Empty",
        message: "Customer title is empty"
      );
    }
    return CustomerTitleResponse(
      customerTitleList: resultList
    );
  }

  CustomerTitle mapFromResponseToCustomerTitle() {
    return CustomerTitle(
      id: ResponseWrapper(response["id"]).mapFromResponseToNonNullableString(),
      name: ResponseWrapper(response["name"]).mapFromResponseToNonNullableString(),
    );
  }
}