class RegisterRequestModel {
  String email;
  String password;
  String nohp;
  String role;

  RegisterRequestModel({this.email, this.password, this.nohp, this.role});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email,
      'password': password,
      'no_hp': nohp,
      'role': role,
      'nama_depan': null,
      'nama_belakang': null,
      'alamat': null,
      'token': null,
    };

    return map;
  }
}

class LoginRequestModel {
  String email;
  String password;

  LoginRequestModel({this.email, this.password});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email,
      'password': password,
    };

    return map;
  }
}
