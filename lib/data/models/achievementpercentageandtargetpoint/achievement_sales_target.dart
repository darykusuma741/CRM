class AchievementSalesTarget {
  String id;
  double achievementPercentage;
  String targetPoint;
  double targetAmount;
  String state;
  DateTime? startDate;
  DateTime? endDate;

  String get targetPointText {
    if (targetPoint == "so_confirm") {
      return "Sale Order Confirm";
    } else if (targetPoint == "invoice_validate") {
      return "Invoice Validate";
    } else if (targetPoint == "invoice_paid") {
      return "Invoice Paid";
    } else {
      return "";
    }
  }

  AchievementSalesTarget({
    required this.id,
    required this.achievementPercentage,
    required this.targetPoint,
    required this.targetAmount,
    required this.state,
    required this.startDate,
    required this.endDate
  });
}