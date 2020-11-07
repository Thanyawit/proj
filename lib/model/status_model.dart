class Statusdurable {// เป็นการสร้างโมเดลเพื่อเก็บค่าที่มาจาก database 
  String statusId;
  String nameStatus;

  Statusdurable({this.statusId, this.nameStatus});

  Statusdurable.fromJson(Map<String, dynamic> json) {
    statusId = json['status_id'];
    nameStatus = json['name_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_id'] = this.statusId;
    data['name_status'] = this.nameStatus;
    return data;
  }
}