class LoginModel {
  String? token;
  int? userId;
  bool? isPatient;
  String? message;
  String? userName;
  int? age;

  LoginModel({this.token, this.userId, this.isPatient, this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userId = json['user_id'];
    isPatient = json['is_patient'];
    message = json['message'];
    userName = json['username'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['user_id'] = this.userId;
    data['is_patient'] = this.isPatient;
    data['message'] = this.message;
    data['username'] = this.userName;
    data['age'] = this.age;
    return data;
  }
}
