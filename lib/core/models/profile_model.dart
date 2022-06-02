class ProfileModel {
  String? username;
  String? email;
  bool? isPatient;
  String? phone;
  int? age;

  ProfileModel(
      {this.username,
        this.email,
        this.isPatient,
        this.phone,
        this.age,});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    isPatient = json['is_patient'];
    phone = json['phone'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    data['is_patient'] = isPatient;
    data['phone'] = phone;
    data['age'] = age;
    return data;
  }
}