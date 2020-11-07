class Userdata {
  String idUser;
  String username;
  String password;
  String name;
  String status;

  Userdata({this.idUser, this.username, this.password, this.name, this.status});

  Userdata.fromJson(Map<String, dynamic> json) {
    idUser = json['id_user'];
    username = json['username'];
    password = json['password'];
    name = json['Name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_user'] = this.idUser;
    data['username'] = this.username;
    data['password'] = this.password;
    data['name'] = this.name;
    data['status'] = this.status;
    return data;
  }
}
