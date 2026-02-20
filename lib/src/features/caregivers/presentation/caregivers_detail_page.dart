import '../../../utils/packages.dart';
import '../../doctors/presentation/widget/title_subtitle_section.dart';
import 'model/care_giver_response.dart';
import 'widget/map_container.dart';

class CaregiverDetailsPage extends StatefulWidget {
  final CareGiverResponse caregiver;

  const CaregiverDetailsPage({super.key, required this.caregiver});

  @override
  State<CaregiverDetailsPage> createState() => _CaregiverDetailsPageState();
}

class _CaregiverDetailsPageState extends State<CaregiverDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final name = widget.caregiver.name ?? 'Unknown';
    final location = widget.caregiver.location ?? 'No location provided';
    final email = widget.caregiver.email ?? 'No email';
    final phone = widget.caregiver.phone ?? 'No phone';
    final type =
        '${widget.caregiver.rcNumber}'; // You can dynamically update this later
    const address = '10 Crescent Close, Yaba, Lagos'; // Optional fallback

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              CustomHeader(
                title: name,
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(height: 24),
              // Center(
              //   child: CircleAvatar(
              //     radius: 32,
              //     backgroundColor: Colors.green.shade100,
              //     child: Text(
              //       name.toString().substring(0, 1).toUpperCase(),
              //       style: const TextStyle(
              //         fontSize: 28,
              //         color: Colors.green,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 15,
                        color: Color(0xff595959),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location.isNotEmpty ? location : address,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xff595959),
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines:
                              2, // Or 1 if you prefer single line with ellipsis
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xffEAFFEB),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        type,
                        style: const TextStyle(
                            color: ColorConstant.primaryColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),

              smallSpace(),
              TitleSubtitleSection(
                title: "Date Established",
                subtitle: widget.caregiver.dateEstablished!,
              ),
              tinySpace(),
              TitleSubtitleSection(
                title: "Mandate",
                subtitle: widget.caregiver.mandate ?? '',
              ),
              const SizedBox(height: 24),
              const Text(
                'Contact Details',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Color(0xFFDFF5E4),
                    radius: 20,
                    child: Icon(Icons.email, color: Colors.green),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDFF5E4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        email,
                        style: const TextStyle(color: Colors.green),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Color(0xFFDFF5E4),
                    radius: 20,
                    child: Icon(Icons.phone, color: Colors.green),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    phone,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              const Text(
                'Location',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),

              MapContainer(
                name: name,
                location: location.isNotEmpty ? location : address,
              ),

              // Container(
              //   height: 180,
              //   width: double.infinity,
              //   clipBehavior: Clip.hardEdge,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(16),
              //   ),
              //   child: Stack(
              //     alignment: Alignment.center,
              //     children: [
              //       Image.asset(
              //         'assets/images/map_app.png',
              //         fit: BoxFit.cover,
              //         width: double.infinity,
              //         height: double.infinity,
              //       ),
              //       Column(
              //         mainAxisSize: MainAxisSize.min,
              //         children: [
              //           InkWell(
              //             onTap: () {
              //               openMapWithAddress(location);
              //             },
              //             child: Container(
              //               decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(7),
              //                   color: Colors.white),
              //               child: Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: Column(
              //                   children: [
              //                     Text(
              //                       name,
              //                       style: const TextStyle(
              //                         color: Colors.black,
              //                         fontWeight: FontWeight.bold,
              //                         fontSize: 14,
              //                       ),
              //                       textAlign: TextAlign.center,
              //                     ),
              //                     Text(
              //                       location,
              //                       style: TextStyle(
              //                         color: Colors.grey,
              //                         fontWeight: FontWeight.bold,
              //                         fontSize: 12,
              //                         shadows: [
              //                           Shadow(
              //                             blurRadius: 4,
              //                             color: Colors.grey.withOpacity(0.3),
              //                             offset: Offset(0, 2),
              //                           ),
              //                         ],
              //                       ),
              //                       textAlign: TextAlign.center,
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             ),
              //           ),
              //           tiny5Space(),
              //           const Icon(
              //             Icons.location_on,
              //             color: Colors.red,
              //             size: 40,
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),

              mediumSpace(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.primaryColor,
                  foregroundColor: ColorConstant.primaryColor,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  context.push(Routes.BOOKAPPOINTMENTOTHERS, extra: widget.caregiver.brandName);
                },
                child: const Text(
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Colors.white),
                    "Book Appointment"),
              ),
              mediumSpace(),
            ],
          ),
        ),
      ),
    );
  }
}
