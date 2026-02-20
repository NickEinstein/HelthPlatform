import 'package:greenzone_medical/src/utils/packages.dart';

import '../../../provider/all_providers.dart';
import '../model/appointment_model.dart';

class AppointmentCard extends ConsumerStatefulWidget {
  final String imageUrl;
  final String doctorName;
  final String treatment;
  final String date;
  final String time;
  final String buttonText1;
  final String buttonText2;
  final VoidCallback onCancel;
  final VoidCallback onReschedule;
  final bool showCancelButton;
  final bool showRating;
  final AppointmentResponse appointment;
  final bool isDischargedNote;
  final bool buttonsDisabled;

  const AppointmentCard({
    super.key,
    required this.imageUrl,
    required this.doctorName,
    required this.treatment,
    required this.date,
    required this.time,
    required this.buttonText1,
    required this.buttonText2,
    required this.onCancel,
    required this.onReschedule,
    required this.appointment,
    this.showRating = false,
    this.showCancelButton = true,
    this.isDischargedNote = true,
    this.buttonsDisabled = false,
  });

  @override
  ConsumerState<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends ConsumerState<AppointmentCard> {
  @override
  void initState() {
    super.initState();
    // ✅ Force refresh when screen opens
    Future.microtask(() {
      // ignore: unused_result
      ref.refresh(userAlDoctorsRatingProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final allDoctorRatingsAsync =
        ref.watch(userAlDoctorsRatingProvider); // ✅ Watch categories
    final appointDateTime =
        DateTime.tryParse(widget.appointment.appointDateTime ?? '');
    final now = DateTime.now();

    bool isJoinMeetingWindow = false;

    if (appointDateTime != null) {
      final joinStart = appointDateTime.subtract(const Duration(minutes: 10));
      final joinEnd = appointDateTime.add(const Duration(minutes: 30));
      isJoinMeetingWindow = now.isAfter(joinStart) && now.isBefore(joinEnd);
    }

    return Card(
      color: const Color(0xFFF2F8F3), // ✅ Add background color here
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    widget.imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.doctorName,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.treatment,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          if (widget.showCancelButton)
                            const Icon(Icons.calendar_month_sharp,
                                size: 14, color: ColorConstant.primaryColor),
                          const SizedBox(width: 4),
                          Text(widget.date,
                              style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                          tiny5HorSpace(),
                          Container(
                            height: 12,
                            width: 2,
                            color: ColorConstant.primaryColor,
                          ),
                          tiny5HorSpace(),
                          if (widget.showCancelButton)
                            const Icon(Icons.access_time_filled_rounded,
                                size: 14, color: ColorConstant.primaryColor),
                          const SizedBox(width: 4),
                          Text(widget.time,
                              style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                      const Divider()
                    ],
                  ),
                ),
              ],
            ),
            // mediumSpace(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.showCancelButton)
                  InkWell(
                    onTap: widget.buttonsDisabled ? null : widget.onReschedule,
                    child: Text(
                      widget.buttonText2,
                      style: const TextStyle(
                          color: ColorConstant.primaryColor, fontSize: 16),
                    ),
                  ),
                if (widget.showCancelButton) const SizedBox(width: 8),
                if (isJoinMeetingWindow)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: widget.buttonsDisabled
                          ? null
                          : () async {
                              final zoomUrl = widget.appointment.zoomJoinUrl;
                              if (zoomUrl != null &&
                                  await canLaunchUrl(Uri.parse(zoomUrl))) {
                                await launchUrl(Uri.parse(zoomUrl),
                                    mode: LaunchMode.externalApplication);
                              } else {
                                if (mounted) {
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Could not launch Zoom meeting")),
                                  );
                                }
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Join Meeting',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                else if (widget.buttonsDisabled)
                  Expanded(
                    child: ElevatedButton(
                      onPressed:
                          widget.buttonsDisabled ? null : widget.onReschedule,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        widget.buttonText2,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                else if (widget.isDischargedNote)
                  Row(
                    children: [
                      InkWell(
                        onTap: widget.buttonsDisabled
                            ? null
                            : () async {
                                final zoomUrl = widget.appointment.zoomJoinUrl;
                                if (zoomUrl != null &&
                                    await canLaunchUrl(Uri.parse(zoomUrl))) {
                                  await launchUrl(Uri.parse(zoomUrl),
                                      mode: LaunchMode.externalApplication);
                                } else {
                                  if (mounted) {
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Could not launch Zoom meeting")),
                                    );
                                  }
                                }
                              },
                        child: Image.asset(
                          'assets/icon/zoom.png',
                          height: 35,
                          width: 35,
                        ),
                      ),
                      tinyHorSpace(),
                      Image.asset(
                        'assets/icon/chat.png',
                        height: 35,
                        width: 35,
                      ),
                      tinyHorSpace(),
                      InkWell(
                        onTap: widget.buttonsDisabled ? null : widget.onCancel,
                        child: Image.asset(
                          'assets/icon/cancel.png',
                          height: 35,
                          width: 35,
                        ),
                      ),
                    ],
                  )
                else
                  Expanded(
                    child: ElevatedButton(
                      onPressed:
                          widget.buttonsDisabled ? null : widget.onReschedule,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        widget.buttonText2,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  )
              ],
            ),
            if (widget.showRating)
              allDoctorRatingsAsync.when(
                data: (ratings) {
                  final alreadyRated = ratings.any((rating) =>
                      rating.doctor!.id == widget.appointment.doctorId &&
                      rating.appointmentId == widget.appointment.id);

                  if (!alreadyRated) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              // ⬅ Wrap to avoid overflow
                              child: InkWell(
                                onTap: () {
                                  context.push(Routes.RATINGPAGE,
                                      extra: widget.appointment);
                                },
                                child: Center(
                                  child: Text(
                                    "Rate your experience with Dr. ${widget.doctorName}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Color(0xff8A8A8A),
                                      fontSize: 14,
                                      height: 1.5,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox(); // ✅ Already rated — show nothing
                  }
                },
                loading: () =>
                    const CircularProgressIndicator(), // or SizedBox.shrink()
                error: (err, stack) => const SizedBox(), // ignore error for now
              )
          ],
        ),
      ),
    );
  }
}
