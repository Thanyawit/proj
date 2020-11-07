class Datadurable {
  String id;
  String assetnumber;
  String name;
  String quantity;
  String cost;
  String brand;
  String model;
  String machinenumber;
  String owner;
  String room;
  String roomnew;
  String state;
  String urlPicture;

  Datadurable(
      {this.id,
      this.assetnumber,
      this.name,
      this.quantity,
      this.cost,
      this.brand,
      this.model,
      this.machinenumber,
      this.owner,
      this.room,
      this.roomnew,
      this.state,
      this.urlPicture});

  Datadurable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    assetnumber = json['assetnumber'];
    name = json['name'];
    quantity = json['quantity'];
    cost = json['cost'];
    brand = json['brand'];
    model = json['model'];
    machinenumber = json['machinenumber'];
    owner = json['owner'];
    room = json['room'];
    roomnew = json['roomnew'];
    state = json['state'];
    urlPicture = json['urlPicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['assetnumber'] = this.assetnumber;
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['cost'] = this.cost;
    data['brand'] = this.brand;
    data['model'] = this.model;
    data['machinenumber'] = this.machinenumber;
    data['owner'] = this.owner;
    data['room'] = this.room;
    data['roomnew'] = this.roomnew;
    data['state'] = this.state;
    data['urlPicture'] = this.urlPicture;
    return data;
  }
}
