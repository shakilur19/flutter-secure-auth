class User {
  String? email;
  int? id;

  User({this.email, this.id});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['id'] = id;
    return data;
  }
}