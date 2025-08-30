class GetUserIdResponse {
  String userId;
  String name;
  String email;
  String base64Image;
  String currencySymbol;

  GetUserIdResponse({
    required this.userId,
    required this.name,
    required this.email,
    required this.base64Image,
    required this.currencySymbol
  });
}