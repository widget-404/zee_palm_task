class UserLoginModel {
  final String userID;
  final String name;
  final String email;
  final String phone;
  final String image;

  UserLoginModel(
      {this.userID = '',
      this.name = '',
      this.email = '',
      this.phone = '',
      this.image = ''});
}
