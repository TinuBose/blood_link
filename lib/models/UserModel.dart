class UserModel {
  String? uid;
  String? name;
  String? email;
  String? phone;
  String? location;
  String? group;
  String? photo;

  UserModel(
      {this.uid, this.name, this.email, this.phone, this.location, this.group});

  UserModel.formMap(Map<String, dynamic> map) {
    uid = map["donorUID"];
    name = map["donorName"];
    email = map["donorEmail"];
    phone = map["donorPhone"];
    location = map["address"];
    group = map["donorBloodGroup"];
    photo = map["donorAvatarUrl"];
  }
  Map<String, dynamic> toMap() {
    return {
      "donorUID": uid,
      "donorName": name,
      "donorEmail": email,
      "donorPhone": phone,
      "address": location,
      "donorBloodGroup": group,
      "donorAvatarUrl": photo
    };
  }
}
