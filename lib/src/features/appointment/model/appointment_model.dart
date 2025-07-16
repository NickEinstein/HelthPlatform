class AppointmentResponse {
  int? id;
  String? appointDateTime; // new field - full datetime string
  String? appointDate;
  String? appointTime;
  String? description;
  bool? isDischarged; // new field
  String? dischargeNotes;
  String? rescheduleReason;
  bool? isCanceled;
  String? canceledDate;
  String? canceledTime;
  String? doctor;
  int? doctorId;
  int? nurseId;
  String? nurse;
  bool? isAdmitted;
  int? patientId;
  int? healthCareProviderId;
  String? patientName;
  String? healthCareProvider;
  String? tracking;
  int? statusValue; // new field
  String? status; // new field
  String? zoomMeetingId; // new field, nullable
  String? zoomMeetingUUID; // new field, nullable
  String? zoomJoinUrl; // new field, nullable
  String? zoomStartUrl; // new field, nullable
  String? summaryTitle; // new field, nullable
  String? summaryOverview; // new field, nullable
  String? summaryContent; // new field, nullable

  AppointmentResponse({
    this.id,
    this.appointDateTime,
    this.appointDate,
    this.appointTime,
    this.description,
    this.isDischarged,
    this.dischargeNotes,
    this.rescheduleReason,
    this.isCanceled,
    this.canceledDate,
    this.canceledTime,
    this.doctor,
    this.doctorId,
    this.nurseId,
    this.nurse,
    this.isAdmitted,
    this.patientId,
    this.healthCareProviderId,
    this.patientName,
    this.healthCareProvider,
    this.tracking,
    this.statusValue,
    this.status,
    this.zoomMeetingId,
    this.zoomMeetingUUID,
    this.zoomJoinUrl,
    this.zoomStartUrl,
    this.summaryTitle,
    this.summaryOverview,
    this.summaryContent,
  });

  factory AppointmentResponse.fromJson(Map<String, dynamic> json) {
    return AppointmentResponse(
      id: json['id'],
      appointDateTime: json['appointDateTime'],
      appointDate: json['appointDate'],
      appointTime: json['appointTime'],
      description: json['description'],
      isDischarged: json['isDischarged'],
      dischargeNotes: json['dischargeNotes'],
      rescheduleReason: json['rescheduleReason'],
      isCanceled: json['isCanceled'],
      canceledDate: json['canceledDate'],
      canceledTime: json['canceledTime'],
      doctor: json['doctor'],
      doctorId: json['doctorId'],
      nurseId: json['nurseId'],
      nurse: json['nurse'],
      isAdmitted: json['isAdmitted'],
      patientId: json['patientId'],
      healthCareProviderId: json['healthCareProviderId'],
      patientName: json['patientName'],
      healthCareProvider: json['healthCareProvider'],
      tracking: json['tracking'],
      statusValue: json['statusValue'],
      status: json['status'],
      zoomMeetingId: json['zoomMeetingId'],
      zoomMeetingUUID: json['zoomMeetingUUID'],
      zoomJoinUrl: json['zoomJoinUrl'],
      zoomStartUrl: json['zoomStartUrl'],
      summaryTitle: json['summaryTitle'],
      summaryOverview: json['summaryOverview'],
      summaryContent: json['summaryContent'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['appointDateTime'] = appointDateTime;
    data['appointDate'] = appointDate;
    data['appointTime'] = appointTime;
    data['description'] = description;
    data['isDischarged'] = isDischarged;
    data['dischargeNotes'] = dischargeNotes;
    data['rescheduleReason'] = rescheduleReason;
    data['isCanceled'] = isCanceled;
    data['canceledDate'] = canceledDate;
    data['canceledTime'] = canceledTime;
    data['doctor'] = doctor;
    data['doctorId'] = doctorId;
    data['nurseId'] = nurseId;
    data['nurse'] = nurse;
    data['isAdmitted'] = isAdmitted;
    data['patientId'] = patientId;
    data['healthCareProviderId'] = healthCareProviderId;
    data['patientName'] = patientName;
    data['healthCareProvider'] = healthCareProvider;
    data['tracking'] = tracking;
    data['statusValue'] = statusValue;
    data['status'] = status;
    data['zoomMeetingId'] = zoomMeetingId;
    data['zoomMeetingUUID'] = zoomMeetingUUID;
    data['zoomJoinUrl'] = zoomJoinUrl;
    data['zoomStartUrl'] = zoomStartUrl;
    data['summaryTitle'] = summaryTitle;
    data['summaryOverview'] = summaryOverview;
    data['summaryContent'] = summaryContent;
    return data;
  }
}
