class Post {
  String? location;
  int? id;
  String? yearOfRegistration;
  String? brandName;
  String? createdDate;
  double? price;
  String? motorbikeCondition;
  String? motorbikeThumbnail;
  double? motorbikeOdo;
  String? logoBrand;
  String? motorbikeName;

  Post(
      {this.location,
      this.id,
      this.yearOfRegistration,
      this.brandName,
      this.createdDate,
      this.price,
      this.motorbikeCondition,
      this.motorbikeThumbnail,
      this.motorbikeOdo,
      this.logoBrand,
      this.motorbikeName});

  Post.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    id = json['id'];
    yearOfRegistration = json['yearOfRegistration'];
    brandName = json['brandName'];
    createdDate = json['createdDate'];
    price = json['price'];
    motorbikeCondition = json['motorbikeCondition'];
    motorbikeThumbnail = json['motorbikeThumbnail'];
    motorbikeOdo = json['motorbikeOdo'];
    logoBrand = json['logoBrand'];
    motorbikeName = json['motorbikeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location'] = this.location;
    data['id'] = this.id;
    data['yearOfRegistration'] = this.yearOfRegistration;
    data['brandName'] = this.brandName;
    data['createdDate'] = this.createdDate;
    data['price'] = this.price;
    data['motorbikeCondition'] = this.motorbikeCondition;
    data['motorbikeThumbnail'] = this.motorbikeThumbnail;
    data['motorbikeOdo'] = this.motorbikeOdo;
    data['logoBrand'] = this.logoBrand;
    data['motorbikeName'] = this.motorbikeName;
    return data;
  }
}
