import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:crm/common/ext/future_ext.dart';
import 'package:crm/common/ext/response_wrapper_ext.dart';
import 'package:crm/common/ext/string_ext.dart';
import 'package:crm/data/mapping/sales_target_entity_mapping_ext.dart';

import '../../../../common/constants/graph_ql_query_constants.dart';
import '../../../../common/graphql/graph_ql.dart';
import '../../../../common/graphql/graph_ql_query_parameter.dart';
import '../../../../common/helper/date_helper.dart';
import '../../../../common/helper/login_helper.dart';
import '../../../../common/processing/future_processing.dart';
import '../../../../common/processing/graph_ql_client_future_processing.dart';
import '../../../common/memory_local_data_storage.dart';
import '../../models/achievementpercentageandtargetpoint/achievement_percentage_and_target_point_parameter.dart';
import '../../models/achievementpercentageandtargetpoint/achievement_percentage_and_target_point_response.dart';
import '../../models/achievementpercentageandtargetpoint/achievement_sales_target.dart';
import '../../models/activity_pipeline_category.dart';
import '../../models/activitypipelinecategory/activity_pipeline_category_parameter.dart';
import '../../models/activitypipelinepagingdata/activity_pipeline_paging_data_parameter.dart';
import '../../models/activitypipelinepagingdata/activity_pipeline_paging_data_response.dart';
import '../../models/latestleads/latest_leads_parameter.dart';
import '../../models/latestleads/latest_leads_response.dart';
import '../../models/lead.dart';
import '../../models/leadspagingdata/leads_paging_data_parameter.dart';
import '../../models/pipeline.dart';
import '../../models/pipeline_category.dart';
import '../../models/pipelineactivityoverview/pipeline_activity_overview.dart';
import '../../models/pipelineactivityoverview/pipeline_activity_overview_parameter.dart';
import '../../models/pipelineactivityoverview/pipeline_activity_overview_response.dart';
import '../../models/pipelinecategory/pipeline_category_parameter.dart';
import '../../models/pipelinepagingdata/pipeline_paging_data_parameter.dart';
import '../../models/pipelinepagingdata/pipeline_paging_data_response.dart';
import '../../models/quotationpagingdata/quotation_paging_data_parameter.dart';
import '../../models/salesmilestone/sales_milestone_count_item.dart';
import '../../models/salesmilestone/sales_milestone_parameter.dart';
import '../../models/salesmilestone/sales_milestone_response.dart';
import '../../models/salesprogressoverview/sales_progress_overview_parameter.dart';
import '../../models/salesprogressoverview/sales_progress_overview_response.dart';
import '../../models/short_activity.dart';
import '../../models/short_quotation.dart';
import '../activityremotedatasource/activity_remote_data_source.dart';
import '../leadsremotedatasource/leads_remote_data_source.dart';
import '../pipelineremotedatasource/pipeline_remote_data_source.dart';
import '../quotationremotedatasource/quotation_remote_data_source.dart';
import 'dashboard_remote_data_source.dart';

class DefaultDashboardRemoteDataSource implements DashboardRemoteDataSource {
  final GraphQL graphQL;
  final LeadsRemoteDataSource leadsRemoteDataSource;
  final PipelineRemoteDataSource pipelineRemoteDataSource;
  final ActivityRemoteDataSource activityRemoteDataSource;
  final QuotationRemoteDataSource quotationRemoteDataSource;

  DefaultDashboardRemoteDataSource({
    required this.graphQL,
    required this.leadsRemoteDataSource,
    required this.pipelineRemoteDataSource,
    required this.activityRemoteDataSource,
    required this.quotationRemoteDataSource
  });

  @override
  FutureProcessing<SalesProgressOverviewResponse> salesProgressOverview(SalesProgressOverviewParameter salesProgressOverviewParameter) {
    return GraphQLFutureProcessing((parameter) async {
      List<ShortQuotation> salesOrderQuotationList = [];
      try {
        salesOrderQuotationList = await quotationRemoteDataSource.quotationPagingData(
          QuotationPagingDataParameter(
            page: 1,
            quotationPagingDataType: InitialQuotationPagingDataType(),
            quotationPagingDataInputType: AllQuotationPagingDataInputType(),
            memoryLocalDataStorage: MemoryLocalDataStorage()
          )
        ).future(
          parameter: parameter
        ).map<List<ShortQuotation>>(
          onMap: (value) => value.shortQuotationPagingData.data.where(
            (shortQuotation) {
              return shortQuotation.status.toLowerCase() == "sale";
            }
          ).toList()
        );
      } catch (e) {
        // Nope
      }
      double totalSalesOrder = () {
        double result = 0.0;
        for (var salesOrderQuotation in salesOrderQuotationList) {
          result += salesOrderQuotation.pricelistValue;
        }
        return result;
      }();
      Map<String, double> shortQuotationMap = () {
        var result = <String, double>{};
        for (var salesOrderQuotation in salesOrderQuotationList) {
          var dateOrderDate = salesOrderQuotation.dateOrderDate;
          if (dateOrderDate != null) {
            var dateOrderString = DateHelper.standardDateFormat21.format(dateOrderDate);
            if (result.containsKey(dateOrderString)) {
              var shortQuotationDouble = result[dateOrderString] ?? 0.0;
              shortQuotationDouble += salesOrderQuotation.pricelistValue;
              result[dateOrderString] = shortQuotationDouble;
            } else {
              result[dateOrderString] = salesOrderQuotation.pricelistValue;
            }
          }
        }
        return result;
      }();
      shortQuotationMap = Map.fromEntries(
        shortQuotationMap.entries.toList()..sort((a, b) => b.key.compareTo(a.key)),
      );
      DateTime nowDateTime = DateTime.now();
      double? nowValue;
      double? lastValue;
      double differentTotalSale = 0;
      var resultString = shortQuotationMap.keys.where(
        (value) => DateHelper.standardDateFormat21.format(nowDateTime) == value
      ).firstOrNull;
      if (resultString.isNotEmptyString) {
        nowValue = shortQuotationMap[resultString];
        var keysList = shortQuotationMap.keys.toList();
        var indexNow = keysList.indexWhere(
          (value) => resultString == value
        );
        if (indexNow > -1) {
          var newIndex = indexNow + 1;
          if (newIndex <= shortQuotationMap.keys.length - 1) {
            lastValue = shortQuotationMap[keysList[newIndex]];
          }
        }
      }
      double percentage = 0;
      differentTotalSale = 0;
      if (nowValue != null && lastValue != null) {
        differentTotalSale = nowValue - lastValue;
        percentage = lastValue == 0 ? 0 : (100.0 * differentTotalSale / lastValue);
      }
      return SalesProgressOverviewResponse(
        currentSalesValue: totalSalesOrder,
        percentage: percentage,
        increasedValue: differentTotalSale,
        status: () {
          if (differentTotalSale > 0) {
            return 1;
          } else if (differentTotalSale < 0) {
            return -1;
          } else {
            return 0;
          }
        }()
      );
    });
  }

  @override
  FutureProcessing<SalesMilestoneResponse> salesMilestone(SalesMilestoneParameter salesMilestoneParameter) {
    return GraphQLFutureProcessing((parameter) async {
      var achievementPercentageAndTargetPointResponse = await achievementPercentageAndTargetPoint(
        AchievementPercentageAndTargetPointParameter()
      ).future(
        parameter: parameter
      );
      var achievementSalesTarget = achievementPercentageAndTargetPointResponse.achievementSalesTargetList;
      var pipelineCategoryList = await pipelineRemoteDataSource.pipelineCategory(
        PipelineCategoryParameter()
      ).future(
        parameter: parameter
      ).map<List<PipelineCategory>>(
        onMap: (response) => response.pipelineCategoryList
      );
      PipelinePagingDataResponse? pipelinePagingDataResponse;
      try {
        pipelinePagingDataResponse = await pipelineRemoteDataSource.pipelinePagingData(
          PipelinePagingDataParameter(
            page: 1,
            pipelinePagingDataType: InitialPipelinePagingDataType(),
            search: "",
            memoryLocalDataStorage: MemoryLocalDataStorage()
          )
        ).future(
          parameter: parameter
        );
      } catch (e) {
        int i = 0;
        while (i < pipelineCategoryList.length) {
          PipelineCategory pipelineCategory = pipelineCategoryList[i];
          pipelineCategory.count = 0;
          i++;
        }
      }
      if (pipelinePagingDataResponse != null) {
        var pipelinePagingData = pipelinePagingDataResponse.pipelinePagingData;
        var shortPipelineList = pipelinePagingData.data;
        int i = 0;
        var totalAllCount = 0;
        while (i < pipelineCategoryList.length) {
          PipelineCategory pipelineCategory = pipelineCategoryList[i];
          pipelineCategory.count = 0;
          int j = 0;
          while (j < shortPipelineList.length) {
            ShortPipeline shortPipeline = shortPipelineList[j];
            void count() {
              pipelineCategory.count += 1;
              totalAllCount += 1;
            }
            if ((pipelineCategory.name.toLowerCase() == shortPipeline.pipelineStatus.name.toLowerCase()) && !shortPipeline.isLost) {
              count();
            } else if (pipelineCategory.id == "-2" && shortPipeline.isLost) {
              count();
            }
            j++;
          }
          i++;
        }
        pipelineCategoryList.where((pipelineCategory) => pipelineCategory.id == "-1").firstOrNull?.count = totalAllCount;
      }
      bool isSalesTargetEmpty = achievementSalesTarget.isEmpty;
      AchievementSalesTarget? showingAchievementSalesTarget = achievementSalesTarget.firstOrNull;
      return SalesMilestoneResponse(
        percentage: isSalesTargetEmpty ? 0 : showingAchievementSalesTarget!.achievementPercentage,
        salesTargetName: isSalesTargetEmpty ? "(Sales Target Is Empty)" : showingAchievementSalesTarget!.targetPointText,
        salesTargetValue: isSalesTargetEmpty ? 0 : showingAchievementSalesTarget!.targetAmount,
        salesMilestoneCountItemList: pipelineCategoryList.where(
          (pipelineCategory) => !(pipelineCategory.id == "-1" || pipelineCategory.id == "-2")
        ).map<SalesMilestoneCountItem>(
          (value) => SalesMilestoneCountItem(
            name: value.name,
            count: value.count
          )
        ).toList()
      );
    });
  }

  @override
  FutureProcessing<AchievementPercentageAndTargetPointResponse> achievementPercentageAndTargetPoint(AchievementPercentageAndTargetPointParameter achievementPercentageAndTargetPointParameter) {
    return GraphQLFutureProcessing((parameter) async {
      return graphQL.query(
        GraphQLQueryParameter(
          queryString: GraphQLQueryConstants().queryAchievementPercentageAndTargetPoint(
            (LoginHelper.getLoginData()?.id).toEmptyStringNonNull,
          ),
        )
      ).map<AchievementPercentageAndTargetPointResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToAchievementPercentageAndTargetPointResponse()
      );
    });
  }

  @override
  FutureProcessing<PipelineActivityOverviewResponse> pipelineActivityOverview(PipelineActivityOverviewParameter pipelineActivityOverviewParameter) {
    return GraphQLFutureProcessing((parameter) async {
      var activityPipelineCategoryList = await activityRemoteDataSource.activityPipelineCategory(
        ActivityPipelineCategoryParameter()
      ).future(
        parameter: parameter
      ).map<List<ActivityPipelineCategory>>(
        onMap: (response) => response.activityPipelineCategoryList.where(
          (value) => value.id != "-1"
        ).toList()
      );
      ActivityPipelinePagingDataResponse? activityPipelinePagingDataResponse;
      try {
        activityPipelinePagingDataResponse = await activityRemoteDataSource.activityPipelinePagingData(
          ActivityPipelinePagingDataParameter(
            page: 1,
            activityPipelinePagingDataType: InitialActivityPipelinePagingDataType(),
            activityPipelinePagingDataInputType: AllActivityPipelinePagingDataInputType(),
            search: "",
            memoryLocalDataStorage: MemoryLocalDataStorage()
          )
        ).future(
          parameter: parameter
        );
      } catch (e) {
        int i = 0;
        while (i < activityPipelineCategoryList.length) {
          ActivityPipelineCategory activityPipelineCategory = activityPipelineCategoryList[i];
          activityPipelineCategory.count = 0;
          i++;
        }
      }
      var totalAllCount = 0;
      if (activityPipelinePagingDataResponse != null) {
        var activityPagingData = activityPipelinePagingDataResponse.activityPagingData;
        var dateTimeRange = DateHelper.startAndEndOfMonth(DateTime.now());
        var shortActivityList = activityPagingData.data.where(
          (value) {
            if (value.createDate == null) {
              return false;
            }
            return DateHelper.isInRangeInclusiveIgnoringTime(
              value.createDate!, dateTimeRange.start, dateTimeRange.end
            );
          }
        ).toList();
        int i = 0;
        while (i < activityPipelineCategoryList.length) {
          ActivityPipelineCategory activityPipelineCategory = activityPipelineCategoryList[i];
          activityPipelineCategory.count = 0;
          int j = 0;
          while (j < shortActivityList.length) {
            ShortActivity shortActivity = shortActivityList[j];
            void count() {
              activityPipelineCategory.count += 1;
              totalAllCount += 1;
            }
            if (activityPipelineCategory.name.toLowerCase() == shortActivity.type.toLowerCase()) {
              count();
            }
            j++;
          }
          i++;
        }
        activityPipelineCategoryList.where((activityPipelineCategory) => activityPipelineCategory.id == "-1").firstOrNull?.count = totalAllCount;
      }
      List<PipelineActivityOverviewGroup> pipelineActivityOverviewGroupList = [];
      var pipelineActivityOverviewList = activityPipelineCategoryList.mapIndexed((index, activityPipelineCategory) {
        return PipelineActivityOverview(
          category: activityPipelineCategory.category,
          action: activityPipelineCategory.action,
          name: activityPipelineCategory.name,
          count: activityPipelineCategory.count,
          index: index
        );
      }).toList();
      int i = 0;
      int targetI = 0;
      while (i < pipelineActivityOverviewList.length) {
        var pipelineActivityOverview = pipelineActivityOverviewList[i];
        if (i == targetI) {
          targetI += 4;
          pipelineActivityOverviewGroupList.add(
            PipelineActivityOverviewGroup(
              pipelineActivityOverviewList: [pipelineActivityOverview]
            )
          );
        } else {
          pipelineActivityOverviewGroupList.last.pipelineActivityOverviewList.add(
            pipelineActivityOverview
          );
        }
        i++;
      }
      return PipelineActivityOverviewResponse(
        pipelineActivityGetReadyCount: totalAllCount,
        pipelineActivityOverviewGroupList: pipelineActivityOverviewGroupList,
        pipelineActivityOverviewList: pipelineActivityOverviewList
      );
    });
  }

  @override
  FutureProcessing<LatestLeadsResponse> latestLeads(LatestLeadsParameter latestLeadsParameter) {
    return GraphQLFutureProcessing((parameter) async {
      var shortLeadsList = await leadsRemoteDataSource.leadsPagingData(
        LeadsPagingDataParameter(
          page: 1,
          leadsPagingDataType: InitialLeadsPagingDataType(),
          search: "",
          memoryLocalDataStorage: MemoryLocalDataStorage()
        )
      ).future(
        parameter: parameter
      ).map<List<ShortLeads>>(
        onMap: (response) => response.leadsPagingData.data.take(10).toList()
      );
      return LatestLeadsResponse(
        leadsList: shortLeadsList
      );
    });
  }
}