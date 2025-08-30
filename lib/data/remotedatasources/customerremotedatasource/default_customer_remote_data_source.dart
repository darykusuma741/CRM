import 'package:crm/common/ext/future_ext.dart';
import 'package:crm/common/ext/load_data_result_ext.dart';
import 'package:crm/common/ext/response_wrapper_ext.dart';
import 'package:crm/common/ext/string_ext.dart';
import 'package:crm/data/mapping/customer_entity_mapping_ext.dart';

import '../../../../common/constants/graph_ql_query_constants.dart';
import '../../../../common/error/message_error.dart';
import '../../../../common/graphql/graph_ql.dart';
import '../../../../common/graphql/graph_ql_mutate_parameter.dart';
import '../../../../common/graphql/graph_ql_query_parameter.dart';
import '../../../../common/helper/login_helper.dart';
import '../../../../common/processing/dummy_future_processing.dart';
import '../../../../common/processing/future_processing.dart';
import '../../../../common/processing/graph_ql_client_future_processing.dart';
import '../../../common/load_data_result/load_data_result.dart';
import '../../models/addcustomer/add_customer_parameter.dart';
import '../../models/addcustomer/add_customer_response.dart';
import '../../models/addcustomeradditionaladdress/add_customer_additional_address_parameter.dart';
import '../../models/addcustomeradditionaladdress/add_customer_additional_address_response.dart';
import '../../models/addresstype/address_type_parameter.dart';
import '../../models/addresstype/address_type_response.dart';
import '../../models/customer_category.dart';
import '../../models/customeradditionaladdressbasedcustomer/customer_additional_address_based_customer_parameter.dart';
import '../../models/customeradditionaladdressbasedcustomer/customer_additional_address_based_customer_response.dart';
import '../../models/customeradditionaladdresscount/customer_additional_address_count_parameter.dart';
import '../../models/customeradditionaladdresscount/customer_additional_address_count_response.dart';
import '../../models/customeradditionaladdressdetail/customer_additional_address_detail_parameter.dart';
import '../../models/customeradditionaladdressdetail/customer_additional_address_detail_response.dart';
import '../../models/customercategory/customer_category_parameter.dart';
import '../../models/customercategory/customer_category_response.dart';
import '../../models/customerdetail/customer_detail_parameter.dart';
import '../../models/customerdetail/customer_detail_response.dart';
import '../../models/customerlist/customer_list_parameter.dart';
import '../../models/customerlist/customer_list_response.dart';
import '../../models/customerpagingdata/customer_paging_data_parameter.dart';
import '../../models/customerpagingdata/customer_paging_data_response.dart';
import '../../models/customerpaymenttermpagingdata/customer_payment_term_paging_data_parameter.dart';
import '../../models/customerpaymenttermpagingdata/customer_payment_term_paging_data_response.dart';
import '../../models/customerpricelistpagingdata/customer_pricelist_paging_data_parameter.dart';
import '../../models/customerpricelistpagingdata/customer_pricelist_paging_data_response.dart';
import '../../models/customertitle/customer_title_parameter.dart';
import '../../models/customertitle/customer_title_response.dart';
import '../../models/editcustomer/edit_customer_parameter.dart';
import '../../models/editcustomer/edit_customer_response.dart';
import '../../models/editcustomeradditionaladdress/edit_customer_additional_address_parameter.dart';
import '../../models/editcustomeradditionaladdress/edit_customer_additional_address_response.dart';
import '../../models/paging/paging_data.dart';
import '../../models/short_customer.dart';
import 'customer_remote_data_source.dart';

class DefaultCustomerRemoteDataSource implements CustomerRemoteDataSource {
  final GraphQL graphQL;

  DefaultCustomerRemoteDataSource({
    required this.graphQL,
  });

  @override
  FutureProcessing<CustomerPagingDataResponse> customerPagingData(CustomerPagingDataParameter customerPagingDataParameter) {
    return GraphQLFutureProcessing((_) async {
      String customerEmptyTitle = "Customer Empty";
      String customerEmptyMessage = "Customer is empty";
      var memoryLocalDataStorage = customerPagingDataParameter.memoryLocalDataStorage;
      var customerCategoryResponse = await customerCategory(CustomerCategoryParameter()).future();
      var customerCategoryList = customerCategoryResponse.customerCategoryList;
      var customerPagingDataResponse = await () async {
        var customerPagingDataType = customerPagingDataParameter.customerPagingDataType;
        if (customerPagingDataType is InitialCustomerPagingDataType) {
          var customerPagingDataResponse = await graphQL.query(
            GraphQLQueryParameter(
              queryString: GraphQLQueryConstants().mutationCustomerPaging(
                CustomerType.all,
                userId: LoginHelper.getLoginData()?.id
              ),
            )
          ).map<CustomerPagingDataResponse>(
            onMap: (value) => value.graphQLWrapResponse().mapFromResponseToCustomerPagingDataResponse(
              customerCategoryList
            )
          );
          if (customerPagingDataParameter.page == 1) {
            memoryLocalDataStorage.shortCustomerListLoadDataResult = NoLoadDataResult<List<ShortCustomer>>();
          }
          if (!memoryLocalDataStorage.shortCustomerListLoadDataResult.isSuccess) {
            memoryLocalDataStorage.shortCustomerListLoadDataResult = SuccessLoadDataResult<List<ShortCustomer>>(
              value: customerPagingDataResponse.shortCustomerPagingData.data
            );
          } else {
            memoryLocalDataStorage.shortCustomerListLoadDataResult.resultIfSuccess!.addAll(
              customerPagingDataResponse.shortCustomerPagingData.data
            );
          }
          return customerPagingDataResponse;
        } else {
          if (memoryLocalDataStorage.shortCustomerListLoadDataResult.isSuccess) {
            var shortCustomerList = memoryLocalDataStorage.shortCustomerListLoadDataResult.resultIfSuccess!;
            var filteredShortCustomerList = () {
              if (customerPagingDataType is WithCategoryCustomerPagingDataType) {
                return shortCustomerList.where((shortCustomer) {
                  var currentCustomerCategory = customerPagingDataType.customerCategory;
                  if (currentCustomerCategory.id == "-1") {
                    return true;
                  }
                  return shortCustomer.customerCategory.name.toLowerCase() == currentCustomerCategory.name.toLowerCase();
                }).toList();
              } else {
                return shortCustomerList;
              }
            }();
            if (filteredShortCustomerList.isEmpty) {
              throw MessageError(
                title: customerEmptyTitle,
                message: customerEmptyMessage
              );
            }
            return CustomerPagingDataResponse(
              shortCustomerPagingData: PagingData(
                page: 1,
                data: filteredShortCustomerList
              )
            );
          }
          throw MessageError(
            title: "All Customer Not Loaded",
            message: "All customer must be loaded"
          );
        }
      }();
      var customerPagingData = customerPagingDataResponse.shortCustomerPagingData;
      if (customerPagingData.page == 1 && customerPagingData.nextPage == null) {
        customerPagingData.data = List.of(
          customerPagingData.data.where(
            (value) => value.name.toLowerCase().contains(
              customerPagingDataParameter.search.toLowerCase()
            )
          )
        );
        if (customerPagingData.data.isEmpty) {
          throw MessageError(
            title: customerEmptyTitle,
            message: customerEmptyMessage
          );
        }
      }
      return customerPagingDataResponse;
    });
  }

  @override
  FutureProcessing<CustomerCategoryResponse> customerCategory(CustomerCategoryParameter customerCategoryParameter) {
    return DummyFutureProcessing((_) async {
      return CustomerCategoryResponse(
        customerCategoryList: <CustomerCategory>[
          CustomerCategory(
            id: "-1",
            name: "All",
            value: "",
            count: 0
          ),
          CustomerCategory(
            id: "1",
            name: "Company",
            value: "company",
            count: 0
          ),
          CustomerCategory(
            id: "2",
            name: "Individual",
            value: "person",
            count: 0
          ),
        ]
      );
    });
  }

  @override
  FutureProcessing<CustomerListResponse> customerList(CustomerListParameter customerListParameter) {
    return GraphQLFutureProcessing((_) async {
      var customerCategoryResponse = await customerCategory(CustomerCategoryParameter()).future();
      var customerCategoryList = customerCategoryResponse.customerCategoryList;
      return await graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationCustomerPaging(
            customerListParameter.customerType,
            userId: LoginHelper.getLoginData()?.id
          ),
        )
      ).map<CustomerListResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToCustomerListResponse(
          customerCategoryList
        )
      );
    });
  }

  @override
  FutureProcessing<CustomerDetailResponse> customerDetail(CustomerDetailParameter customerDetailParameter) {
    return GraphQLFutureProcessing((_) async {
      var customerCategoryResponse = await customerCategory(CustomerCategoryParameter()).future();
      var customerCategoryList = customerCategoryResponse.customerCategoryList;
      return await graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationCustomerDetail(customerDetailParameter.customerId)
        )
      ).map<CustomerDetailResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToCustomerDetailResponse(customerCategoryList)
      );
    });
  }

  @override
  FutureProcessing<CustomerPaymentTermPagingDataResponse> customerPaymentTermPagingData(CustomerPaymentTermPagingDataParameter customerPaymentTermPagingDataParameter) {
    return GraphQLFutureProcessing((_) async {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().queryCustomerPaymentTermPaging,
        )
      ).map<CustomerPaymentTermPagingDataResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToCustomerPaymentTermPagingDataResponse()
      );
    });
  }

  @override
  FutureProcessing<CustomerPricelistPagingDataResponse> customerPricelistPagingData(CustomerPricelistPagingDataParameter customerPricelistPagingDataParameter) {
    return GraphQLFutureProcessing((_) async {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationCustomerPricelistPaging,
        )
      ).map<CustomerPricelistPagingDataResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToCustomerPricelistPagingDataResponse()
      );
    });
  }

  @override
  FutureProcessing<AddCustomerResponse> addCustomer(AddCustomerParameter addCustomerParameter) {
    return GraphQLFutureProcessing((_) async {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: () {
            if (addCustomerParameter is IndividualAddCustomerParameter) {
              return GraphQLQueryConstants().mutationAddCustomer(
                name: addCustomerParameter.name,
                vat: addCustomerParameter.taxId,
                email: addCustomerParameter.email,
                phone: addCustomerParameter.phoneNumber,
                mobile: addCustomerParameter.whatsappNumber,
                street: addCustomerParameter.street,
                street2: addCustomerParameter.street2,
                city: addCustomerParameter.city,
                stateId: addCustomerParameter.stateId,
                zip: addCustomerParameter.zip,
                countryId: addCustomerParameter.countryId,
                website: addCustomerParameter.website,
                jobPosition: addCustomerParameter.jobPosition,
                customerType: CustomerType.individual,
                userId: addCustomerParameter.userId.isNotEmptyString ? addCustomerParameter.userId! : (LoginHelper.getLoginData()?.token).toEmptyStringNonNull
              );
            } else if (addCustomerParameter is CompanyAddCustomerParameter) {
              return GraphQLQueryConstants().mutationAddCustomer(
                name: addCustomerParameter.name,
                vat: addCustomerParameter.taxId,
                email: addCustomerParameter.email,
                phone: addCustomerParameter.phoneNumber,
                mobile: addCustomerParameter.whatsappNumber,
                street: addCustomerParameter.street,
                street2: addCustomerParameter.street2,
                city: addCustomerParameter.city,
                stateId: addCustomerParameter.stateId,
                zip: addCustomerParameter.zip,
                countryId: addCustomerParameter.countryId,
                website: addCustomerParameter.website,
                jobPosition: "",
                customerType: CustomerType.company,
                userId: addCustomerParameter.userId.isNotEmptyString ? addCustomerParameter.userId! : (LoginHelper.getLoginData()?.token).toEmptyStringNonNull
              );
            }
            throw MessageError(
              title: "Add Customer Parameter Not Suitable",
              message: "Add Customer Parameter is not Suitable",
            );
          }()
        )
      ).map<AddCustomerResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToAddCustomerResponse()
      );
    });
  }

  @override
  FutureProcessing<EditCustomerResponse> editCustomer(EditCustomerParameter editCustomerParameter) {
    return GraphQLFutureProcessing((_) async {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: () {
            if (editCustomerParameter is IndividualEditCustomerParameter) {
              return GraphQLQueryConstants().mutationEditCustomer(
                customerId: editCustomerParameter.customerId,
                name: editCustomerParameter.name,
                vat: editCustomerParameter.taxId,
                email: editCustomerParameter.email,
                phone: editCustomerParameter.phoneNumber,
                mobile: editCustomerParameter.whatsappNumber,
                street: editCustomerParameter.street,
                street2: editCustomerParameter.street2,
                city: editCustomerParameter.city,
                stateId: editCustomerParameter.stateId,
                zip: editCustomerParameter.zip,
                countryId: editCustomerParameter.countryId,
                website: editCustomerParameter.website,
                jobPosition: editCustomerParameter.jobPosition,
                customerType: CustomerType.individual,
                userId: editCustomerParameter.userId.toEmptyStringNonNull
              );
            } else if (editCustomerParameter is CompanyEditCustomerParameter) {
              return GraphQLQueryConstants().mutationEditCustomer(
                customerId: editCustomerParameter.customerId,
                name: editCustomerParameter.name,
                vat: editCustomerParameter.taxId,
                email: editCustomerParameter.email,
                phone: editCustomerParameter.phoneNumber,
                mobile: editCustomerParameter.whatsappNumber,
                street: editCustomerParameter.street,
                street2: editCustomerParameter.street2,
                city: editCustomerParameter.city,
                stateId: editCustomerParameter.stateId,
                zip: editCustomerParameter.zip,
                countryId: editCustomerParameter.countryId,
                website: editCustomerParameter.website,
                jobPosition: "",
                customerType: CustomerType.company,
                userId: editCustomerParameter.userId.toEmptyStringNonNull
              );
            }
            throw MessageError(
              title: "Edit Customer Parameter Not Suitable",
              message: "Edit Customer Parameter is not Suitable",
            );
          }()
        )
      ).map<EditCustomerResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToEditCustomerResponse()
      );
    });
  }

  @override
  FutureProcessing<CustomerAdditionalAddressCountResponse> customerAdditionalAddressCount(CustomerAdditionalAddressCountParameter customerAdditionalAddressCountParameter) {
    return GraphQLFutureProcessing((_) async {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationCustomerAdditionalAddressCount(customerAdditionalAddressCountParameter.customerId),
        )
      ).map<CustomerAdditionalAddressCountResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToCustomerAdditionalAddressCountResponse()
      );
    });
  }

  @override
  FutureProcessing<CustomerAdditionalAddressDetailResponse> customerAdditionalAddressDetail(CustomerAdditionalAddressDetailParameter customerAdditionalAddressDetailParameter) {
    return GraphQLFutureProcessing((_) async {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationCustomerAdditionalAddressBasedCustomerAdditionalAddressId(
            customerAdditionalAddressDetailParameter.customerAdditionalAddressId
          ),
        )
      ).map<CustomerAdditionalAddressDetailResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToCustomerAdditionalAddressDetailResponse()
      );
    });
  }

  @override
  FutureProcessing<CustomerAdditionalAddressBasedCustomerResponse> customerAdditionalAddressBasedCustomer(CustomerAdditionalAddressBasedCustomerParameter customerAdditionalAddressBasedCustomerParameter) {
    return GraphQLFutureProcessing((_) async {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationCustomerAdditionalAddressBasedCustomer(customerAdditionalAddressBasedCustomerParameter.customerId),
        )
      ).map<CustomerAdditionalAddressBasedCustomerResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToCustomerAdditionalAddressBasedCustomerResponse()
      );
    });
  }

  @override
  FutureProcessing<AddCustomerAdditionalAddressResponse> addCustomerAdditionalAddress(AddCustomerAdditionalAddressParameter addCustomerAdditionalAddressParameter) {
    return GraphQLFutureProcessing((_) async {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationAddCustomerAdditionalAddress(
            customerId: addCustomerAdditionalAddressParameter.customerId,
            type: addCustomerAdditionalAddressParameter.type,
            name: addCustomerAdditionalAddressParameter.name,
            email: addCustomerAdditionalAddressParameter.email,
            phone: addCustomerAdditionalAddressParameter.phone,
            mobile: addCustomerAdditionalAddressParameter.mobile,
            street: addCustomerAdditionalAddressParameter.street,
            street2: addCustomerAdditionalAddressParameter.street2,
            city: addCustomerAdditionalAddressParameter.city,
            stateId: addCustomerAdditionalAddressParameter.stateId,
            zip: addCustomerAdditionalAddressParameter.zip,
            countryId: addCustomerAdditionalAddressParameter.countryId,
            comment: addCustomerAdditionalAddressParameter.comment
          ),
        )
      ).map<AddCustomerAdditionalAddressResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToAddCustomerAdditionalAddressResponse()
      );
    });
  }

  @override
  FutureProcessing<EditCustomerAdditionalAddressResponse> editCustomerAdditionalAddress(EditCustomerAdditionalAddressParameter editCustomerAdditionalAddressParameter) {
    return GraphQLFutureProcessing((_) async {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationEditCustomerAdditionalAddress(
            id: editCustomerAdditionalAddressParameter.id,
            type: editCustomerAdditionalAddressParameter.type,
            name: editCustomerAdditionalAddressParameter.name,
            email: editCustomerAdditionalAddressParameter.email,
            phone: editCustomerAdditionalAddressParameter.phone,
            mobile: editCustomerAdditionalAddressParameter.mobile,
            street: editCustomerAdditionalAddressParameter.street,
            street2: editCustomerAdditionalAddressParameter.street2,
            city: editCustomerAdditionalAddressParameter.city,
            stateId: editCustomerAdditionalAddressParameter.stateId,
            zip: editCustomerAdditionalAddressParameter.zip,
            countryId: editCustomerAdditionalAddressParameter.countryId,
            comment: editCustomerAdditionalAddressParameter.comment
          ),
        )
      ).map<EditCustomerAdditionalAddressResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToEditCustomerAdditionalAddressResponse()
      );
    });
  }

  @override
  FutureProcessing<AddressTypeResponse> addressType(AddressTypeParameter addressTypeParameter) {
    return GraphQLFutureProcessing((_) async {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationAddressType,
        )
      ).map<AddressTypeResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToAddressTypeResponse()
      );
    });
  }

  @override
  FutureProcessing<CustomerTitleResponse> customerTitle(CustomerTitleParameter customerTitleParameter) {
    return GraphQLFutureProcessing((_) async {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationCustomerTitle,
        )
      ).map<CustomerTitleResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToCustomerTitleResponse()
      );
    });
  }
}