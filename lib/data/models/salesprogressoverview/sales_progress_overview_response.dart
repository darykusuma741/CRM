class SalesProgressOverviewResponse {
  double currentSalesValue;
  double percentage;
  int status;
  double increasedValue;

  SalesProgressOverviewResponse({
    required this.currentSalesValue,
    required this.percentage,
    required this.status,
    required this.increasedValue
  });
}