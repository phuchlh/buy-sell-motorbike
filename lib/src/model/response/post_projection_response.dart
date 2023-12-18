class PostProjection {
  String? location;
  int? id;
  double? price;
  String? yearOfRegistration;
  String? brandName;
  String? createdDate;
  String? motorbikeCondition;
  String? motorbikeThumbnail;
  String? motorbikeName;
  double? motorbikeOdo;
  String? logoBrand;

  PostProjection(
      {this.location,
      this.id,
      this.price,
      this.yearOfRegistration,
      this.brandName,
      this.createdDate,
      this.motorbikeCondition,
      this.motorbikeThumbnail,
      this.motorbikeName,
      this.motorbikeOdo,
      this.logoBrand});

  PostProjection.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    id = json['id'];
    price = json['price'];
    yearOfRegistration = json['yearOfRegistration'];
    brandName = json['brandName'];
    createdDate = json['createdDate'];
    motorbikeCondition = json['motorbikeCondition'];
    motorbikeThumbnail = json['motorbikeThumbnail'];
    motorbikeName = json['motorbikeName'];
    motorbikeOdo = json['motorbikeOdo'];
    logoBrand = json['logoBrand'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location'] = this.location;
    data['id'] = this.id;
    data['price'] = this.price;
    data['yearOfRegistration'] = this.yearOfRegistration;
    data['brandName'] = this.brandName;
    data['createdDate'] = this.createdDate;
    data['motorbikeCondition'] = this.motorbikeCondition;
    data['motorbikeThumbnail'] = this.motorbikeThumbnail;
    data['motorbikeName'] = this.motorbikeName;
    data['motorbikeOdo'] = this.motorbikeOdo;
    data['logoBrand'] = this.logoBrand;
    return data;
  }
}
