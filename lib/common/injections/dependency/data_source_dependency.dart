import '../../../data/remotedatasources/activityremotedatasource/activity_remote_data_source.dart';
import '../../../data/remotedatasources/activityremotedatasource/default_activity_remote_data_source.dart';
import '../../../data/remotedatasources/customerremotedatasource/customer_remote_data_source.dart';
import '../../../data/remotedatasources/customerremotedatasource/default_customer_remote_data_source.dart';
import '../../../data/remotedatasources/dashboardremotedatasource/dashboard_remote_data_source.dart';
import '../../../data/remotedatasources/dashboardremotedatasource/default_dashboard_remote_data_source.dart';
import '../../../data/remotedatasources/leadsremotedatasource/default_leads_remote_data_source.dart';
import '../../../data/remotedatasources/leadsremotedatasource/leads_remote_data_source.dart';
import '../../../data/remotedatasources/locationremotedatasource/default_location_remote_data_source.dart';
import '../../../data/remotedatasources/locationremotedatasource/location_remote_data_source.dart';
import '../../../data/remotedatasources/lostremotedatasource/default_lost_remote_data_source.dart';
import '../../../data/remotedatasources/lostremotedatasource/lost_remote_data_source.dart';
import '../../../data/remotedatasources/pipelineremotedatasource/default_pipeline_remote_data_source.dart';
import '../../../data/remotedatasources/pipelineremotedatasource/pipeline_remote_data_source.dart';
import '../../../data/remotedatasources/productremotedatasource/default_product_remote_data_source.dart';
import '../../../data/remotedatasources/productremotedatasource/product_remote_data_source.dart';
import '../../../data/remotedatasources/quotationremotedatasource/default_quotation_remote_data_source.dart';
import '../../../data/remotedatasources/quotationremotedatasource/quotation_remote_data_source.dart';
import '../../../data/remotedatasources/reasonremotedatasource/default_reason_remote_data_source.dart';
import '../../../data/remotedatasources/reasonremotedatasource/reason_remote_data_source.dart';
import '../../../data/remotedatasources/userremotedatasource/default_user_remote_data_source.dart';
import '../../../data/remotedatasources/userremotedatasource/user_remote_data_source.dart';
import '../injections.dart';

class DataSourceDependency {
  DataSourceDependency() {
    _dataSources();
  }

  void _dataSources() {
    sl.registerLazySingleton<UserRemoteDataSource>(
      () => DefaultUserRemoteDataSource(
        httpClient: sl(),
        graphQL: sl()
      ),
    );
    sl.registerLazySingleton<LeadsRemoteDataSource>(
      () => DefaultLeadsRemoteDataSource(
        httpClient: sl(),
        graphQL: sl()
      ),
    );
    sl.registerLazySingleton<PipelineRemoteDataSource>(
      () => DefaultPipelineRemoteDataSource(
        httpClient: sl(),
        graphQL: sl()
      ),
    );
    sl.registerLazySingleton<QuotationRemoteDataSource>(
      () => DefaultQuotationRemoteDataSource(
        graphQL: sl()
      ),
    );
    sl.registerLazySingleton<ProductRemoteDataSource>(
      () => DefaultProductRemoteDataSource(
        graphQL: sl()
      ),
    );
    sl.registerLazySingleton<CustomerRemoteDataSource>(
      () => DefaultCustomerRemoteDataSource(
        graphQL: sl()
      ),
    );
    sl.registerLazySingleton<ActivityRemoteDataSource>(
      () => DefaultActivityRemoteDataSource(
        graphQL: sl(),
        userRemoteDataSource: sl()
      ),
    );
    sl.registerLazySingleton<ReasonRemoteDataSource>(
      () => DefaultReasonRemoteDataSource(
        graphQL: sl(),
      ),
    );
    sl.registerLazySingleton<LostRemoteDataSource>(
      () => DefaultLostRemoteDataSource(
        graphQL: sl(),
      ),
    );
    sl.registerLazySingleton<LocationRemoteDataSource>(
      () => DefaultLocationRemoteDataSource(
        graphQL: sl(),
      ),
    );
    sl.registerLazySingleton<DashboardRemoteDataSource>(
      () => DefaultDashboardRemoteDataSource(
        graphQL: sl(),
        activityRemoteDataSource: sl(),
        leadsRemoteDataSource: sl(),
        pipelineRemoteDataSource: sl(),
        quotationRemoteDataSource: sl()
      ),
    );
  }
}