import 'package:crm/common/ext/response_wrapper_ext.dart';
import 'package:crm/data/mapping/paging_mapping_ext.dart';

import '../../common/error/message_error.dart';
import '../../common/helper/date_helper.dart';
import '../../common/responsewrapper/response_wrapper.dart';
import '../models/activitycountbasedpipeline/activity_count_based_pipeline_response.dart';
import '../models/addpipeline/add_pipeline_response.dart';
import '../models/converttolostpipeline/convert_to_lost_pipeline_response.dart';
import '../models/editpipeline/edit_pipeline_response.dart';
import '../models/pipeline.dart';
import '../models/pipeline_category.dart';
import '../models/pipelinecategory/pipeline_category_response.dart';
import '../models/pipelinedetail/pipeline_detail.dart';
import '../models/pipelinedetail/pipeline_detail_response.dart';
import '../models/pipelinenextstage/pipeline_next_stage_response.dart';
import '../models/pipelinepagingdata/pipeline_paging_data_response.dart';
import '../models/pipelinestages/pipeline_stage.dart';
import '../models/pipelinestages/pipeline_stages_response.dart';
import '../models/quotationcountbasedpipeline/quotation_count_based_pipeline_response.dart';
import '../models/restorepipeline/restore_pipeline_response.dart';

extension PipelineEntityMappingExt on ResponseWrapper {
  PipelineDetailResponse mapFromResponseToPipelineDetailResponse() {
    ResponseWrapper pipelineDetailResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "result");
    var shortHistoryPipelineActivityList = pipelineDetailResponseWrapper.mapFromResponseToList(
      (value) => ResponseWrapper(value).mapFromResponseToPipelineDetail()
    ).toList();
    if (shortHistoryPipelineActivityList.isEmpty) {
      throw MessageError(
        title: "Short History Pipeline Not Found",
        message: "Short History Pipeline is not found"
      );
    }
    return PipelineDetailResponse(
      pipelineDetail: shortHistoryPipelineActivityList.first
    );
  }

  PipelinePagingDataResponse mapFromResponseToPipelinePagingDataResponse() {
    return PipelinePagingDataResponse(
      pipelinePagingData: ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "result").mapFromResponseToPagingData<ShortPipeline>(
        (dataResponse) => ResponseWrapper(dataResponse).mapFromResponseToList(
          (value) => ResponseWrapper(value).mapFromResponseToShortPipeline()
        ),
      )
    );
  }

  PipelineCategoryResponse mapFromResponseToPipelineCategoryResponse() {
    return PipelineCategoryResponse(
      pipelineCategoryList: () {
        var pipelineCategoryList = ResponseWrapper(response["CrmStage"]).mapFromResponseToList(
          (pipelineCategoryResponse) => ResponseWrapper(pipelineCategoryResponse).mapFromResponseToPipelineCategory()
        );
        return <PipelineCategory>[
          PipelineCategory(
            id: "-1",
            name: "All",
            count: 0
          ),
          ...() {
            return pipelineCategoryList.map<PipelineCategory>(
              (pipelineCategory) {
                if (pipelineCategory.name.toLowerCase() == "lost") {
                  pipelineCategory.id = "-2";
                }
                return pipelineCategory;
              }
            );
          }(),
        ];
      }()
    );
  }

  AddPipelineResponse mapFromResponseToAddPipelineResponse() {
    return AddPipelineResponse();
  }

  EditPipelineResponse mapFromResponseToEditPipelineResponse() {
    return EditPipelineResponse();
  }

  ConvertToLostPipelineResponse mapFromResponseToConvertToLostPipelineResponse() {
    return ConvertToLostPipelineResponse();
  }

  PipelineStagesResponse mapFromResponseToPipelineStagesResponse() {
    return PipelineStagesResponse(
      pipelineStageList: () {
        var pipelineCategoryList = ResponseWrapper(response["CrmStage"]).mapFromResponseToList(
          (pipelineCategoryResponse) => ResponseWrapper(pipelineCategoryResponse).mapFromResponseToPipelineStage()
        );
        return pipelineCategoryList;
      }()
    );
  }

  PipelineNextStageResponse mapFromResponseToPipelineNextStageResponse() {
    return PipelineNextStageResponse();
  }

  ShortPipeline mapFromResponseToShortPipeline() {
    return ShortPipeline(
      id: ResponseWrapper(response["id"]).mapFromResponseToNonNullableString(),
      name: ResponseWrapper(response["name"]).mapFromResponseToNonNullableString(),
      isLost: !ResponseWrapper(response["active"]).mapFromResponseToNonNullableBool(),
      pipelineStatus: ResponseWrapper(response["stage_id"]).mapFromResponseToPipelineStatus(),
      contactEmail: ResponseWrapper(response["email_from"]).mapFromResponseToNonNullableString(),
      contactPhoneNumber: ResponseWrapper(response["mobile"]).mapFromResponseToNonNullableString(),
      priority: ResponseWrapper(response["priority"]).mapFromResponseToNonNullableInt(),
      expectedRevenue: ResponseWrapper(response["expected_revenue"]).mapFromResponseToDouble(),
    );
  }

  PipelineStatus mapFromResponseToPipelineStatus() {
    return PipelineStatus(
      id: ResponseWrapper(response).getArrayData(0).mapFromResponseToNonNullableString(),
      name: ResponseWrapper(response).getArrayData(1).mapFromResponseToNonNullableString(),
      backgroundColorHex: ResponseWrapper(response).getArrayData(2).mapFromResponseToNonNullableString(),
      textColorHex: ResponseWrapper(response).getArrayData(3).mapFromResponseToNonNullableString()
    );
  }

  PipelineStage mapFromResponseToPipelineStage() {
    return PipelineStage(
      id: ResponseWrapper(response["id"]).mapFromResponseToNonNullableString(),
      name: ResponseWrapper(response["name"]).mapFromResponseToNonNullableString(),
    );
  }

  PipelineCategory mapFromResponseToPipelineCategory() {
    return PipelineCategory(
      id: ResponseWrapper(response["id"]).mapFromResponseToNonNullableString(),
      name: ResponseWrapper(response["name"]).mapFromResponseToNonNullableString(),
      count: ResponseWrapper(response["count"]).mapFromResponseToNonNullableInt()
    );
  }

  PipelineDetail mapFromResponseToPipelineDetail() {
    String contactStateId = "";
    String contactState = "";
    dynamic stateResponse = response["state_id"];
    if (stateResponse is Map<String, dynamic>) {
      contactStateId = ResponseWrapper(stateResponse["id"]).mapFromResponseToNonNullableString();
      contactState = ResponseWrapper(stateResponse["name"]).mapFromResponseToNonNullableString();
    }
    String contactCountryId = "";
    String contactCountry = "";
    dynamic countryResponse = response["country_id"];
    if (countryResponse is Map<String, dynamic>) {
      contactCountryId = ResponseWrapper(countryResponse["id"]).mapFromResponseToNonNullableString();
      contactCountry = ResponseWrapper(countryResponse["name"]).mapFromResponseToNonNullableString();
    }
    return PipelineDetail(
      id: ResponseWrapper(response["id"]).mapFromResponseToNonNullableString(),
      isLost: !ResponseWrapper(response["active"]).mapFromResponseToNonNullableBool(),
      name: ResponseWrapper(response["name"]).mapFromResponseToNonNullableString(),
      pipelineStatus: ResponseWrapper(response["stage_id"]).mapFromResponseToPipelineStatus(),
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
      companyWebsite: ResponseWrapper(response["website"]).mapFromResponseToNonNullableString(),
      expectedRevenueFirst: ResponseWrapper(response["expected_revenue_first"] ?? response["expected_revenue"]).mapFromResponseToDouble(),
      expectedRevenueSecond: ResponseWrapper(response["expected_revenue_second"] ?? response["expected_revenue"]).mapFromResponseToDouble(),
      expectedClosing: ResponseWrapper(response["date_deadline"]).mapFromResponseToDateTime(convertIntoLocalTime: false),
      period: ResponseWrapper(response["period"]).mapFromResponseToNonNullableString(),
      probability: ResponseWrapper(response["probability"]).mapFromResponseToNonNullableDouble(),
    );
  }

  RestorePipelineResponse mapFromResponseToRestorePipelineResponse() {
    return RestorePipelineResponse();
  }

  ActivityCountBasedPipelineResponse mapFromResponseToActivityCountBasedPipelineResponse() {
    ResponseWrapper resultDataResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "result");
    return ActivityCountBasedPipelineResponse(
      count: resultDataResponseWrapper.mapFromResponseToNonNullableInt()
    );
  }

  QuotationCountBasedPipelineResponse mapFromResponseToQuotationCountBasedPipelineResponse() {
    ResponseWrapper resultDataResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "result");
    return QuotationCountBasedPipelineResponse(
      count: resultDataResponseWrapper.mapFromResponseToNonNullableInt()
    );
  }
}