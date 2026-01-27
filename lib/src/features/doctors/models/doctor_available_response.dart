class DoctorAvailableResponse {
  final int? id;
  final int? employeeId;
  final DateTime? startTimeUtc;
  final DateTime? endTimeUtc;
  final bool? isBooked;

  DoctorAvailableResponse({
    this.id,
    this.employeeId,
    this.startTimeUtc,
    this.endTimeUtc,
    this.isBooked,
  });

  factory DoctorAvailableResponse.fromJson(Map<String, dynamic> json) {
    return DoctorAvailableResponse(
      id: json['id'],
      employeeId: json['employeeId'],
      startTimeUtc: json['startTimeUtc'] != null
          ? DateTime.parse(json['startTimeUtc']).toLocal()
          : null,
      endTimeUtc: json['endTimeUtc'] != null
          ? DateTime.parse(json['endTimeUtc']).toLocal()
          : null,
      isBooked: json['isBooked'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employeeId': employeeId,
      'startTimeUtc': startTimeUtc?.toIso8601String(),
      'endTimeUtc': endTimeUtc?.toIso8601String(),
      'isBooked': isBooked,
    };
  }
}
// [{"id":48,"employeeId":235,"startTimeUtc":"2026-01-30T07:27:00","endTimeUtc":"2026-02-07T07:27:00","isBooked":false}]
