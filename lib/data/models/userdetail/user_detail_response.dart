class UserDetailResponse {
  String id;
  String name;
  String login;
  String email;
  String imageUrl;
  String base64Image;

  UserDetailResponse({
    required this.id,
    required this.name,
    required this.login,
    required this.email,
    required this.imageUrl,
    required this.base64Image
  });
}