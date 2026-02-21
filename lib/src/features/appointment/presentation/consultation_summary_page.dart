import 'package:greenzone_medical/src/features/appointment/model/appointment_model.dart';
import 'package:greenzone_medical/src/utils/packages.dart';

class ConsultationSummaryPage extends StatefulWidget {
  final AppointmentResponse appointment;
  const ConsultationSummaryPage({super.key, required this.appointment});

  @override
  State<ConsultationSummaryPage> createState() =>
      _ConsultationSummaryPageState();
}

class _ConsultationSummaryPageState extends State<ConsultationSummaryPage> {
  bool isSummaryExpanded = false;
  bool isAdmissionExpanded = false;
  bool isPrescriptionExpanded = false;
  bool isLabExpanded = false;
  bool isFollowUpExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          "Consultation Summary",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: const [
          // IconButton(
          //   icon: const Icon(Icons.chat_bubble_outline, color: Colors.white),
          //   onPressed: () {
          //     context.push(Routes., extra: widget.appointment);
          //   },
          // ),
          // const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // _buildAppointmentInfoCard(),
              const SizedBox(height: 20),
              _buildCollapsibleCard(
                title: "Consultation Summary",
                isExpanded: isSummaryExpanded,
                onToggle: () =>
                    setState(() => isSummaryExpanded = !isSummaryExpanded),
                child: _buildSummaryContent(),
              ),
              const SizedBox(height: 12),
              _buildCollapsibleCard(
                title: "View Admission Details",
                isExpanded: isAdmissionExpanded,
                onToggle: () =>
                    setState(() => isAdmissionExpanded = !isAdmissionExpanded),
                child: _buildAdmissionContent(),
              ),
              const SizedBox(height: 12),
              _buildCollapsibleCard(
                title: "View Prescriptions",
                isExpanded: isPrescriptionExpanded,
                onToggle: () => setState(
                    () => isPrescriptionExpanded = !isPrescriptionExpanded),
                child: _buildPrescriptionContent(),
              ),
              const SizedBox(height: 12),
              _buildCollapsibleCard(
                title: "View Lab Work Request",
                isExpanded: isLabExpanded,
                onToggle: () => setState(() => isLabExpanded = !isLabExpanded),
                child: _buildLabWorkContent(),
              ),
              const SizedBox(height: 12),
              _buildCollapsibleCard(
                title: "View Follow-Up Appointment",
                isExpanded: isFollowUpExpanded,
                onToggle: () =>
                    setState(() => isFollowUpExpanded = !isFollowUpExpanded),
                child: _buildFollowUpContent(),
              ),
              const SizedBox(height: 30),
              _buildRatingSection(),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildAppointmentInfoCard() {
  //   return Container(
  //     padding: const EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       color: ColorConstant.primaryColor,
  //       borderRadius: BorderRadius.circular(12),
  //     ),
  //     child: Row(
  //       children: [
  //         Container(
  //           padding: const EdgeInsets.all(10),
  //           decoration: const BoxDecoration(
  //             color: Colors.white24,
  //             shape: BoxShape.circle,
  //           ),
  //           child: const Icon(Icons.medical_services, color: Colors.white),
  //         ),
  //         const SizedBox(width: 12),
  //         Expanded(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 widget.appointment.tracking ?? "General Consultation",
  //                 style: const TextStyle(
  //                   color: Colors.white,
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 16,
  //                 ),
  //               ),
  //               const SizedBox(height: 4),
  //               Row(
  //                 children: [
  //                   const Icon(Icons.calendar_today,
  //                       color: Colors.white70, size: 14),
  //                   const SizedBox(width: 4),
  //                   Text(
  //                     widget.appointment.appointDate ?? "",
  //                     style:
  //                         const TextStyle(color: Colors.white70, fontSize: 12),
  //                   ),
  //                   const SizedBox(width: 12),
  //                   const Icon(Icons.access_time,
  //                       color: Colors.white70, size: 14),
  //                   const SizedBox(width: 4),
  //                   Text(
  //                     widget.appointment.appointTime ?? "",
  //                     style:
  //                         const TextStyle(color: Colors.white70, fontSize: 12),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildCollapsibleCard({
    required String title,
    required bool isExpanded,
    required VoidCallback onToggle,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ListTile(
            onTap: onToggle,
            title: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
            trailing: Icon(
              isExpanded
                  ? Icons.keyboard_arrow_down
                  : Icons.keyboard_arrow_right,
              color: Colors.grey,
            ),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Divider(color: Colors.grey.shade100, height: 1),
            ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: child,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSummaryContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Meeting Summary",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 12),
        ),
        const SizedBox(height: 8),
        Text(
          widget.appointment.summaryOverview ?? "No summary available.",
          style: const TextStyle(color: Colors.black87),
        ),
        const SizedBox(height: 16),
        const Text(
          "Diagnosis",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 12),
        ),
        const SizedBox(height: 8),
        Text(
          widget.appointment.summaryContent ??
              widget.appointment.description ??
              "No diagnosis available.",
          style: const TextStyle(color: Colors.black87),
        ),
      ],
    );
  }

  Widget _buildAdmissionContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow("Hospital", "Healing Stripes"),
        _buildInfoRow("Address", "10 Crescent Close, Victoria Island, Lagos."),
        _buildInfoRow("Contact Person", "Wynn Peterson"),
        _buildInfoRow("Contact Phone Number", "+234 812 345 6789"),
        _buildInfoRow("Level of Severity", "Medium"),
        _buildInfoRow("Referral Admission/Additional Note",
            "The patient is being admitted for further observation and treatment of the respiratory infection."),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.location_on, size: 18),
            label: const Text("Check on Google Map"),
            style: OutlinedButton.styleFrom(
              foregroundColor: ColorConstant.primaryColor,
              side: const BorderSide(color: ColorConstant.primaryColor),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
                fontWeight: FontWeight.w500, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildPrescriptionContent() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("No prescriptions recorded.",
            style: TextStyle(color: Colors.black54)),
      ],
    );
  }

  Widget _buildRatingSection() {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          context.push(Routes.DOCTORRATINGPAGE, extra: widget.appointment);
        },
        child: Text(
          "Rate your experience with Dr. ${widget.appointment.doctor ?? "the doctor"}",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 12,
            color: ColorConstant.secondryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildLabWorkContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Here's a list of required lab works",
          style: TextStyle(color: Colors.black54, fontSize: 13),
        ),
        const SizedBox(height: 12),
        _buildLabItem(
            "Chest X-Ray Scan", "Lifeline Medical Diagnostic Centre, Ilupeju"),
        _buildLabItem(
            "MRI Scan", "Lifeline Medical Diagnostic Centre, Ilupeju"),
        _buildLabItem("Blood Work", "In House"),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xfff0fdf4),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xffbbf7d0)),
          ),
          child: Column(
            children: [
              _buildCostRow("Lab Work Cost:", "N15,250.00"),
              const SizedBox(height: 8),
              _buildCostRow("HMO Cover:", "N15,250.00"),
              const SizedBox(height: 8),
              _buildCostRow("Your Contribution:", "N0.00"),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildAdditionalNoteSection(),
      ],
    );
  }

  Widget _buildLabItem(String title, String location) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                Text(location,
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.medical_services_outlined,
              color: Colors.green, size: 20),
        ],
      ),
    );
  }

  Widget _buildCostRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
        const SizedBox(width: 8),
        Text(value,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
      ],
    );
  }

  Widget _buildAdditionalNoteSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xff99f6b4), // Green note header bar
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text("Additional Note",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          ),
          Container(
            height: 120,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(7),
                bottomRight: Radius.circular(7),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFollowUpContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Your Next Appointment is:",
            style: TextStyle(color: Colors.black54, fontSize: 13)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xffdcfce7),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.green.shade300),
          ),
          child: const Text(
            "April 18, 2025 | 12.30pm",
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
          ),
        ),
        const SizedBox(height: 20),
        _buildInfoRow("Purpose of Visit",
            "Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model"),
        _buildInfoRow(
            "Location", "Lifeline Medical Diagnostic Centre, Ilupeju"),
        const SizedBox(height: 16),
        _buildAdditionalNoteSection(),
      ],
    );
  }
}
