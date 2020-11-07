class Datatimehome {
  int startdatetime;
  int enddatetime;

  Datatimehome({this.startdatetime, this.enddatetime});

  Datatimehome.fromJson(Map<String, dynamic> json) {
    startdatetime = json['startdatetime'];
    enddatetime = json['enddatetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startdatetime'] = this.startdatetime;
    data['enddatetime'] = this.enddatetime;
    return data;
  }
}
