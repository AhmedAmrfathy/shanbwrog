class Basic {
  int? id;
  String? name;
  String? active;

  Basic({this.id, this.name, this.active});

  Basic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['active'] = this.active;
    return data;
  }
}
