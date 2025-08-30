import '../data/models/lead.dart';
import '../data/models/pipeline.dart';
import '../data/models/short_activity.dart';
import '../data/models/short_customer.dart';
import '../data/models/short_lost.dart';
import '../data/models/short_product.dart';
import '../data/models/short_quotation.dart';
import 'load_data_result/load_data_result.dart';

class MemoryLocalDataStorage {
  LoadDataResult<List<ShortLeads>> shortLeadsListLoadDataResult = NoLoadDataResult<List<ShortLeads>>();
  LoadDataResult<List<ShortPipeline>> shortPipelineListLoadDataResult = NoLoadDataResult<List<ShortPipeline>>();
  LoadDataResult<List<ShortQuotation>> shortQuotationListLoadDataResult = NoLoadDataResult<List<ShortQuotation>>();
  LoadDataResult<List<ShortProduct>> shortProductListLoadDataResult = NoLoadDataResult<List<ShortProduct>>();
  LoadDataResult<List<ShortLost>> shortLostListLoadDataResult = NoLoadDataResult<List<ShortLost>>();
  LoadDataResult<List<ShortCustomer>> shortCustomerListLoadDataResult = NoLoadDataResult<List<ShortCustomer>>();
  LoadDataResult<List<ShortActivity>> shortActivityListLoadDataResult = NoLoadDataResult<List<ShortActivity>>();
}