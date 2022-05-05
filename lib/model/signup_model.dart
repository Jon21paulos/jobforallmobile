class SignUpBody{
  String username;
  String email;
  String password;
  String password2;
  SignUpBody({
    required this.username,
    required this.email,
    required this.password,
    required this.password2,
  });

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data["username"] = username;
    data["email"] = email;
    data['password'] = password;
    data['password2'] = password2;
    return data;
  }
}