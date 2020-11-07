class Positiondrop {
  String room;

  Positiondrop({this.room});

  Positiondrop.fromJson(Map<String, dynamic> json) {
    room = json['room'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room'] = this.room;
    return data;
  }
}
