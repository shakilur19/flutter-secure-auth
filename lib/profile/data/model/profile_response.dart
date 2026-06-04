class ProfileResponse {
  String? email;
  String? firstName;
  String? lastName;
  String? gender;

  ProfileResponse({this.email, this.firstName, this.lastName, this.gender});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['gender'] = gender;
    return data;
  }
}
