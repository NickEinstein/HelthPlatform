class TrackFeedbackResponse {
  final bool isSuccess;
  final int statusCode;
  final Data? data;
  final dynamic error;

  TrackFeedbackResponse({
    required this.isSuccess,
    required this.statusCode,
    required this.data,
    required this.error,
  });

  factory TrackFeedbackResponse.fromJson(Map<String, dynamic> json) {
    return TrackFeedbackResponse(
      isSuccess: json['isSuccess'],
      statusCode: json['statusCode'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      error: json['error'],
    );
  }
}

class Data {
  final int id;
  final String trackingId;
  final String type;
  final String message;
  final String location;
  final String contactEmail;
  final String status;
  final String resolutionNotes;
  final String createdAt;
  final String updatedAt;
  final dynamic deletedAt;
  final bool isDeleted;
  final int citizenUserId;
  final int agencyUserId;
  final int assignedByAgencyUserId;
  final String actionTaken;

  Data({
    required this.id,
    required this.trackingId,
    required this.type,
    required this.message,
    required this.location,
    required this.contactEmail,
    required this.status,
    required this.resolutionNotes,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.isDeleted,
    required this.citizenUserId,
    required this.agencyUserId,
    required this.assignedByAgencyUserId,
    required this.actionTaken,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      trackingId: json['trackingId'],
      type: json['type'],
      message: json['message'],
      location: json['location'],
      contactEmail: json['contactEmail'],
      status: json['status'],
      resolutionNotes: json['resolutionNotes'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
      isDeleted: json['isDeleted'],
      citizenUserId: json['citizenUserId'],
      agencyUserId: json['agencyUserId'],
      assignedByAgencyUserId: json['assignedByAgencyUserId'],
      actionTaken: json['actionTaken'],
    );
  }
}