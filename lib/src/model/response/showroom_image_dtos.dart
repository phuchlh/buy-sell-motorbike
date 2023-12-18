class ShowroomImageDtos {
  int? id;
  String? url;
  String? name;
  String? type;
  int? showroomId;

  ShowroomImageDtos({this.id, this.url, this.name, this.type, this.showroomId});

  ShowroomImageDtos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    name = json['name'];
    type = json['type'];
    showroomId = json['showroomId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['name'] = this.name;
    data['type'] = this.type;
    data['showroomId'] = this.showroomId;
    return data;
  }
}
