class ApplyPost {
  int? EmployerId;
  int? ApplierId;
  int? PostId;

  ApplyPost({required this.EmployerId, required this.ApplierId,required this.PostId});

  ApplyPost.fromJson(Map<String, dynamic> json) {
    EmployerId = json['EmployerId'];
    ApplierId = json['ApplierId'];
    PostId = json['PostId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmployerId'] = this.EmployerId;
    data['ApplierId'] = this.ApplierId;
    data['PostId'] = this.PostId;
    return data;
  }
}
