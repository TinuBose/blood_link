class Users {
  String? donorName = '';
  String? donorBloodGroup = '';
  String? donorEmail = '';
  String? donorPhone = '';
  String? address = '';
  String? status = '';
  String? donorAvatarUrl = '';

  Users(
      {this.donorName,
      this.donorBloodGroup,
      this.donorEmail,
      this.donorPhone,
      this.address,
      this.status,
      this.donorAvatarUrl});

  Users.fromJson(Map<String, dynamic> json) {
    donorName = json['donorName'];
    donorBloodGroup = json['donorBloodGroup'];
    donorEmail = json['donorEmail'];
    donorPhone = json['donorPhone'];
    address = json['address'];
    status = json['status'];
    donorAvatarUrl = json['donorAvatarUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = donorName;
    data['group'] = donorBloodGroup;
    data['email'] = donorEmail;
    data['phone'] = donorPhone;
    data['address'] = address;
    data['status'] = status;
    data['image'] = donorAvatarUrl;

    return data;
  }
}
