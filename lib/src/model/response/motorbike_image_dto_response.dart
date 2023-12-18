class MotorbikeDTOsResponse {
  int? id;
  String? url;
  bool? isThumbnail;
  int? motorbikeId;

  MotorbikeDTOsResponse({this.id, this.url, this.isThumbnail, this.motorbikeId});

  MotorbikeDTOsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    isThumbnail = json['isThumbnail'];
    motorbikeId = json['motorbikeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['isThumbnail'] = this.isThumbnail;
    data['motorbikeId'] = this.motorbikeId;
    return data;
  }
}
