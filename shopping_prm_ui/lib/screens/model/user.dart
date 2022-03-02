class User {
  String? uid;
  String? name;
  String? email;
  String? joinedAt;
  int? phoneNumber;
  String? userImageUrl;
  String? password;

  User(
      {this.uid,
      this.name,
      this.email,
      this.joinedAt,
      this.phoneNumber,
      this.userImageUrl,
      this.password});

  User.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    joinedAt = json['joinedAt'];
    phoneNumber = json['phoneNumber'];
    userImageUrl = json['userImageUrl'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['email'] = this.email;
    data['joinedAt'] = this.joinedAt;
    data['phoneNumber'] = this.phoneNumber;
    data['userImageUrl'] = this.userImageUrl;
    data['password'] = this.password;
    return data;
  }
}
