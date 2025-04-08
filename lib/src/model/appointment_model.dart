class Appointment {
  final int id;
  final String doctor;
  final String description;
  final String appointDate;
  final String appointTime;
  final bool isCanceled;
  final String tracking;

  Appointment({
    required this.id,
    required this.doctor,
    required this.description,
    required this.appointDate,
    required this.appointTime,
    required this.isCanceled,
    required this.tracking,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'] ?? 0,
      doctor: json['doctor'] ?? 'Unknown Doctor',
      description: json['description'] ?? 'No Description',
      appointDate: json['appointDate'] ?? '',
      appointTime: json['appointTime'] ?? '',
      isCanceled: json['isCanceled'] ?? false,
      tracking: json['tracking'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctor': doctor,
      'description': description,
      'appointDate': appointDate,
      'appointTime': appointTime,
      'isCanceled': isCanceled,
      'tracking': tracking,
    };
  }
}
