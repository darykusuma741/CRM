import 'sales_milestone_count_item.dart';

class SalesMilestoneResponse {
  double percentage;
  String salesTargetName;
  double salesTargetValue;
  List<SalesMilestoneCountItem> salesMilestoneCountItemList;

  SalesMilestoneResponse({
    required this.percentage,
    required this.salesTargetName,
    required this.salesTargetValue,
    required this.salesMilestoneCountItemList
  });
}