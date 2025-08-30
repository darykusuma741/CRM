import 'package:crm/common/ext/response_wrapper_ext.dart';
import 'package:crm/data/mapping/paging_mapping_ext.dart';

import '../../common/error/message_error.dart';
import '../../common/responsewrapper/response_wrapper.dart';
import '../models/addleads/add_leads_response.dart';
import '../models/converttolostleads/convert_to_lost_leads_response.dart';
import '../models/converttopipeline/convert_to_pipeline_response.dart';
import '../models/converttopipeline/convert_to_pipeline_step_1_response.dart';
import '../models/converttopipeline/convert_to_pipeline_step_2_response.dart';
import '../models/editleads/edit_leads_response.dart';
import '../models/lead.dart';
import '../models/lead_category.dart';
import '../models/leadscategory/leads_category_response.dart';
import '../models/leadsdetail/leads_detail.dart';
import '../models/leadsdetail/leads_detail_response.dart';
import '../models/leadspagingdata/leads_paging_data_response.dart';
import '../models/lostpagingdata/lost_paging_data_response.dart';
import '../models/restoreleads/restore_leads_response.dart';

extension LeadsEntityMappingExt on ResponseWrapper {
  LeadsDetailResponse mapFromResponseToLeadsDetailResponse() {
    ResponseWrapper leadsDetailResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "result");
    var leadsDetailList = leadsDetailResponseWrapper.mapFromResponseToList(
      (value) => ResponseWrapper(value).mapFromResponseToLeadsDetail()
    ).toList();
    if (leadsDetailList.isEmpty) {
      throw MessageError(
        title: "Leads Not Found",
        message: "Leads is not found"
      );
    }
    return LeadsDetailResponse(
      leadsDetail: leadsDetailList.first
    );
  }

  LeadsPagingDataResponse mapFromResponseToLeadsPagingDataResponse() {
    return LeadsPagingDataResponse(
      leadsPagingData: ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "result").mapFromResponseToPagingData<ShortLeads>(
        (dataResponse) => ResponseWrapper(dataResponse).mapFromResponseToList(
          (value) => ResponseWrapper(value).mapFromResponseToShortLeads()
        ),
      )
    );
  }

  LeadsCategoryResponse mapFromResponseToLeadsCategoryResponse() {
    return LeadsCategoryResponse(
      leadCategoryList: () {
        var resultLeadCategoryList = ResponseWrapper(response["CrmStage"]).mapFromResponseToList(
          (leadsCategoryResponse) => ResponseWrapper(leadsCategoryResponse).mapFromResponseToLeadsCategory()
        );
        return <LeadsCategory>[
          LeadsCategory(
            id: "-1",
            name: "All",
            count: 0
          ),
          ...resultLeadCategoryList,
          LeadsCategory(
            id: "-2",
            name: "Lost",
            count: 0
          ),
        ];
      }()
    );
  }

  AddLeadsResponse mapFromResponseToAddLeadsResponse() {
    return AddLeadsResponse();
  }

  EditLeadsResponse mapFromResponseToEditLeadsResponse() {
    return EditLeadsResponse();
  }

  ConvertToLostLeadsResponse mapFromResponseToConvertToLostLeadsResponse() {
    return ConvertToLostLeadsResponse();
  }

  ConvertToPipelineResponse mapFromResponseToConvertToPipelineResponse() {
    return ConvertToPipelineResponse();
  }

  ConvertToPipelineStep1Response mapFromResponseToConvertToPipelineStep1Response() {
    var step1ResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(
      dataFieldName: "createCrmLead2opportunityPartner"
    );
    var responseList = step1ResponseWrapper.mapFromResponseToList(
      (responseValue) => responseValue
    );
    if (responseList.isEmpty) {
      throw MessageError(
        title: "Result Empty",
        message: "Result is empty"
      );
    }
    return ConvertToPipelineStep1Response(
      createCrmLead2OpportunityPartnerId: ResponseWrapper(responseList.first).mapFromResponseToDataResponseWrapper(
        dataFieldName: "id"
      ).mapFromResponseToNonNullableString()
    );
  }

  ConvertToPipelineStep2Response mapFromResponseToConvertToPipelineStep2Response() {
    return ConvertToPipelineStep2Response();
  }

  RestoreLeadsResponse mapFromResponseToRestoreLeadsResponse() {
    return RestoreLeadsResponse();
  }

  ShortLeads mapFromResponseToShortLeads() {
    return ShortLeads(
      id: ResponseWrapper(response["id"]).mapFromResponseToNonNullableString(),
      name: ResponseWrapper(response["name"]).mapFromResponseToNonNullableString(),
      leadStatus: () {
        bool isLost = ResponseWrapper(response["active"]).mapFromResponseToNonNullableBool();
        if (!isLost) {
          return LeadsStatus(
            id: "-2",
            name: "Lost",
            backgroundColorHex: "",
            textColorHex: ""
          );
        }
        var leadsStatus = ResponseWrapper(response["stage_id"]).mapFromResponseToLeadsStatus();
        return leadsStatus;
      }(),
      contactEmail: ResponseWrapper(response["email_from"]).mapFromResponseToNonNullableString(),
      contactPhoneNumber: ResponseWrapper(response["mobile"]).mapFromResponseToNonNullableString(),
      priority: ResponseWrapper(response["priority"]).mapFromResponseToNonNullableInt()
    );
  }

  LeadsStatus mapFromResponseToLeadsStatus() {
    LeadsStatus? leadsStatus;
    if (response is List) {
      leadsStatus = LeadsStatus(
        id: ResponseWrapper(response).getArrayData(0).mapFromResponseToNonNullableString(),
        name: ResponseWrapper(response).getArrayData(1).mapFromResponseToNonNullableString(),
        backgroundColorHex: ResponseWrapper(response).getArrayData(2).mapFromResponseToNonNullableString(),
        textColorHex: ResponseWrapper(response).getArrayData(3).mapFromResponseToNonNullableString()
      );
    } else if (response is Map<String, dynamic>) {
      leadsStatus = LeadsStatus(
        id: ResponseWrapper(response["id"]).mapFromResponseToNonNullableString(),
        name: ResponseWrapper(response["name"]).mapFromResponseToNonNullableString(),
        backgroundColorHex: ResponseWrapper(response["background_color"]).mapFromResponseToNonNullableString(),
        textColorHex: ResponseWrapper(response["text_color"]).mapFromResponseToNonNullableString()
      );
    }
    if (leadsStatus != null) {
      if (leadsStatus.name.toLowerCase() == "new") {
        leadsStatus.name = "Prospects";
      }
      return leadsStatus;
    }
    throw MessageError(
      title: "Error Parsing Leads Status",
      message: "Error when parsing leads status."
    );
  }

  LeadsCategory mapFromResponseToLeadsCategory() {
    return LeadsCategory(
      id: ResponseWrapper(response["id"]).mapFromResponseToNonNullableString(),
      name: ResponseWrapper(response["name"]).mapFromResponseToNonNullableString(),
      count: ResponseWrapper(response["count"]).mapFromResponseToNonNullableInt()
    );
  }

  LeadsDetail mapFromResponseToLeadsDetail() {
    String contactStateId = "";
    String contactState = "";
    dynamic stateResponse = response["state_id"];
    if (stateResponse is Map<String, dynamic>) {
      contactStateId = ResponseWrapper(stateResponse["id"]).mapFromResponseToNonNullableString();
      contactState = ResponseWrapper(stateResponse["name"]).mapFromResponseToNonNullableString();
    } else if (stateResponse is List) {
      contactStateId = ResponseWrapper(stateResponse).getArrayData(0).mapFromResponseToNonNullableString();
      contactState = ResponseWrapper(stateResponse).getArrayData(1).mapFromResponseToNonNullableString();
    }
    String contactCountryId = "";
    String contactCountry = "";
    dynamic countryResponse = response["country_id"];
    if (countryResponse is Map<String, dynamic>) {
      contactCountryId = ResponseWrapper(countryResponse["id"]).mapFromResponseToNonNullableString();
      contactCountry = ResponseWrapper(countryResponse["name"]).mapFromResponseToNonNullableString();
    } else if (countryResponse is List) {
      contactCountryId = ResponseWrapper(countryResponse).getArrayData(0).mapFromResponseToNonNullableString();
      contactCountry = ResponseWrapper(countryResponse).getArrayData(1).mapFromResponseToNonNullableString();
    }
    String titleId = "";
    String title = "";
    dynamic titleResponse = response["title"];
    if (titleResponse is Map<String, dynamic>) {
      titleId = ResponseWrapper(titleResponse["id"]).mapFromResponseToNonNullableString();
      title = ResponseWrapper(titleResponse["name"]).mapFromResponseToNonNullableString();
    } else if (titleResponse is List) {
      titleId = ResponseWrapper(titleResponse).getArrayData(0).mapFromResponseToNonNullableString();
      title = ResponseWrapper(titleResponse).getArrayData(1).mapFromResponseToNonNullableString();
    }

    return LeadsDetail(
      id: ResponseWrapper(response["id"]).mapFromResponseToNonNullableString(),
      titleId: titleId,
      titleName: title,
      name: ResponseWrapper(response["name"]).mapFromResponseToNonNullableString(),
      leadsStatus: () {
        bool isLost = ResponseWrapper(response["active"]).mapFromResponseToNonNullableBool();
        if (!isLost) {
          return LeadsStatus(
            id: "-2",
            name: "Lost",
            backgroundColorHex: "",
            textColorHex: ""
          );
        }
        var leadsStatus = ResponseWrapper(response["stage_id"]).mapFromResponseToLeadsStatus();
        return leadsStatus;
      }(),
      contactName: ResponseWrapper(response["contact_name"]).mapFromResponseToNonNullableString(),
      contactJobPosition: ResponseWrapper(response["function"]).mapFromResponseToNonNullableString(),
      contactEmail: ResponseWrapper(response["email_from"]).mapFromResponseToNonNullableString(),
      contactPhoneNumber: ResponseWrapper(response["mobile"]).mapFromResponseToNonNullableString(),
      contactStateId: contactStateId,
      contactState: contactState,
      contactCountryId: contactCountryId,
      contactCountry: contactCountry,
      contactZip: ResponseWrapper(response["zip"]).mapFromResponseToNonNullableString(),
      contactStreet: ResponseWrapper(response["street"]).mapFromResponseToNonNullableString(),
      contactStreet2: ResponseWrapper(response["street2"]).mapFromResponseToNonNullableString(),
      contactCity: ResponseWrapper(response["city"]).mapFromResponseToNonNullableString(),
      priority: ResponseWrapper(response["priority"]).mapFromResponseToNonNullableInt(),
      companyName: ResponseWrapper(response["partner_name"]).mapFromResponseToNonNullableString(),
      companyWebsite: ResponseWrapper(response["website"]).mapFromResponseToNonNullableString()
    );
  }
}