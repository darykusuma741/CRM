import '../../../data/repositories/activity_repository.dart';
import '../../../data/repositories/customer_repository.dart';
import '../../../data/repositories/dashboard_repository.dart';
import '../../../data/repositories/leads_repository.dart';
import '../../../data/repositories/location_repository.dart';
import '../../../data/repositories/lost_repository.dart';
import '../../../data/repositories/pipeline_repository.dart';
import '../../../data/repositories/product_repository.dart';
import '../../../data/repositories/quotation_repository.dart';
import '../../../data/repositories/reason_repository.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../data/repositoriesimpl/default_activity_repository.dart';
import '../../../data/repositoriesimpl/default_customer_repository.dart';
import '../../../data/repositoriesimpl/default_dashboard_repository.dart';
import '../../../data/repositoriesimpl/default_leads_repository.dart';
import '../../../data/repositoriesimpl/default_location_repository.dart';
import '../../../data/repositoriesimpl/default_lost_repository.dart';
import '../../../data/repositoriesimpl/default_pipeline_repository.dart';
import '../../../data/repositoriesimpl/default_product_repository.dart';
import '../../../data/repositoriesimpl/default_quotation_repository.dart';
import '../../../data/repositoriesimpl/default_reason_repository.dart';
import '../../../data/repositoriesimpl/default_user_repository.dart';
import '../injections.dart';

class RepositoryDependency {
  RepositoryDependency() {
    _repositories();
  }

  void _repositories() {
    sl.registerLazySingleton<DashboardRepository>(
      () => DefaultDashboardRepository(
        dashboardRemoteDataSource: sl()
      ),
    );
    sl.registerLazySingleton<LeadsRepository>(
      () => DefaultLeadsRepository(
        leadsRemoteDataSource: sl()
      ),
    );
    sl.registerLazySingleton<PipelineRepository>(
      () => DefaultPipelineRepository(
        pipelineRemoteDataSource: sl()
      ),
    );
    sl.registerLazySingleton<ActivityRepository>(
      () => DefaultActivityRepository(
        activityRemoteDataSource: sl()
      ),
    );
    sl.registerLazySingleton<UserRepository>(
      () => DefaultUserRepository(
        userRemoteDataSource: sl(),
      ),
    );
    sl.registerLazySingleton<CustomerRepository>(
      () => DefaultCustomerRepository(
        customerRemoteDataSource: sl(),
      ),
    );
    sl.registerLazySingleton<ProductRepository>(
      () => DefaultProductRepository(
        productRemoteDataSource: sl(),
      ),
    );
    sl.registerLazySingleton<QuotationRepository>(
      () => DefaultQuotationRepository(
        quotationRemoteDataSource: sl(),
      ),
    );
    sl.registerLazySingleton<ReasonRepository>(
      () => DefaultReasonRepository(
        reasonRemoteDataSource: sl(),
      ),
    );
    sl.registerLazySingleton<LostRepository>(
      () => DefaultLostRepository(
        lostRemoteDataSource: sl(),
      ),
    );
    sl.registerLazySingleton<LocationRepository>(
      () => DefaultLocationRepository(
        locationRemoteDataSource: sl()
      )
    );
  }
}