class User {
  late int id;
  late String username;
  late String password;
  late String email;
  late String token;

  User(this.id, this.username, this.email, this.password, this.token);

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    token = json['token'];
  }
}
