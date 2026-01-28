// {"id":19,"vendorName":"STERLING HEALTH MANAGED CARE SERVICES LIMITED","phoneNumber":"+234-204-562354 ","contactPerson":"","rcNumber":"","taxIdentityNumber":"","altPhoneNumber":"","packages":[],"userId":407,"createdBy":407,"modifiedBy":0,"createdOn":"2025-10-30T12:35:41.8689185","modifiedOn":"0001-01-01T00:00:00","actionTaken":"Record Creation"}
class HmoModel {
  final int id;
  final String vendorName;
  final String phoneNumber;
  final String contactPerson;
  final String rcNumber;
  final String taxIdentityNumber;
  final String altPhoneNumber;
  final List<dynamic> packages;
  final int userId;
  final int createdBy;
  final int modifiedBy;
  final DateTime createdOn;
  final DateTime modifiedOn;
  final String actionTaken;

  const HmoModel({
    required this.id,
    required this.vendorName,
    required this.phoneNumber,
    required this.contactPerson,
    required this.rcNumber,
    required this.taxIdentityNumber,
    required this.altPhoneNumber,
    required this.packages,
    required this.userId,
    required this.createdBy,
    required this.modifiedBy,
    required this.createdOn,
    required this.modifiedOn,
    required this.actionTaken,
  });

  factory HmoModel.fromJson(Map<String, dynamic> json) => HmoModel(
        id: json["id"],
        vendorName: json["vendorName"],
        phoneNumber: json["phoneNumber"],
        contactPerson: json["contactPerson"],
        rcNumber: json["rcNumber"],
        taxIdentityNumber: json["taxIdentityNumber"],
        altPhoneNumber: json["altPhoneNumber"],
        packages: json["packages"],
        userId: json["userId"],
        createdBy: json["createdBy"],
        modifiedBy: json["modifiedBy"],
        createdOn: DateTime.parse(json["createdOn"]),
        modifiedOn: DateTime.parse(json["modifiedOn"]),
        actionTaken: json["actionTaken"],
      );
}