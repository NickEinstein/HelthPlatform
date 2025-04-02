class AllAlergyResponse {
  int? id;
  String? allergyOrIntolleranceSource;
  String? description;

  AllAlergyResponse(
      {this.id, this.allergyOrIntolleranceSource, this.description});

  AllAlergyResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    allergyOrIntolleranceSource = json['allergyOrIntolleranceSource'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['allergyOrIntolleranceSource'] = this.allergyOrIntolleranceSource;
    data['description'] = this.description;
    return data;
  }
}
