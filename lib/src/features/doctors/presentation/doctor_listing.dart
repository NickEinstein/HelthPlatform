import 'package:greenzone_medical/src/model/doctord_list_response.dart'
    // ignore: library_prefixes
    as DoctorResponse;

import '../../../constants/route_map_widget.dart';
import '../../../utils/packages.dart';
import 'widget/doctor_card.dart';
import 'widget/title_subtitle_section.dart';

class DoctorListing extends ConsumerStatefulWidget {
  final DoctorResponse.DoctorListResponse doctor; // Accept doctor data

  const DoctorListing({super.key, required this.doctor});

  @override
  ConsumerState<DoctorListing> createState() => _DoctorListingState();
}

class _DoctorListingState extends ConsumerState<DoctorListing> {
  @override
  Widget build(BuildContext context) {
    final doctor = widget.doctor; // Get doctor data

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: Image.network(
                    doctor.profilePicture!.startsWith('http')
                        ? doctor.profilePicture!
                        : '${AppConstants.noSlashImageURL}${doctor.profilePicture!}',
                    width: width(context),
                    height: 350,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Handle name split and initials
                      final fullName =
                          '${doctor.title}. ${doctor.firstName ?? ''} ${doctor.lastName ?? ''}';

                      final nameParts = fullName.trim().split(RegExp(r'\s+'));
                      String initials = '';
                      final nonTitleParts =
                          nameParts.where((p) => !p.endsWith('.')).toList();
                      if (nonTitleParts.isNotEmpty) {
                        initials += nonTitleParts.first[0];
                        if (nonTitleParts.length > 1) {
                          initials += nonTitleParts.last[0];
                        }
                      }

                      return Container(
                        width: width(context),
                        height: 350,
                        decoration: BoxDecoration(
                          color: getAvatarColor(fullName),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          initials.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 56,
                  left: 26,
                  child: CustomHeader(
                    title: '',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            Column(
              children: [
                DoctorCard(
                  imageUrl: doctor.profilePicture!,
                  name:
                      '${doctor.title}. ${doctor.firstName} ${doctor.lastName}',
                  type: doctor.userRoles!.last.roleSpecialist!.specialistName ??
                      '',
                  profession: doctor.userRoles!.last.role!.name ?? '',
                  hospital: doctor.healthCareProvider!.name ?? '',
                  isShowImg: false,
                  isShowVerified: true,
                  rating: double.tryParse(doctor.rating?.toString() ?? '0.0') ??
                      0.0,
                  reviews: doctor.reviews ?? 0,
                  isShowLove: false,
                  isLiked: true,
                  onPress: () {},
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleSubtitleSection(
                        title: "About Dr. ${doctor.firstName}",
                        subtitle: doctor.aboutCareGiver ?? "No bio available.",
                      ),
                      // tinySpace(),
                      // TitleSubtitleSection(
                      //   title: "Working Hours",
                      //   subtitle: doctor.workingHours ?? "Not available",
                      // ),
                      tinySpace(),
                      const TitleSubtitleSection(
                        title: "Preferred Language(s)",
                        subtitle: "English, French, Ibo, and Yoruba",
                      ),
                      tinySpace(),
                      TitleSubtitleSection(
                        title: "Resumption Date",
                        subtitle: doctor.resumptionDate ?? "Not available",
                      ),
                      tinySpace(),
                      const TitleSubtitleSection(
                        title: "Contact Details",
                        subtitle: "",
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(
                                color: ColorConstant.primaryLightColor
                                    .withOpacity(0.3)),
                            color: ColorConstant.primaryLightColor
                                .withOpacity(0.3)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                          color: ColorConstant.primaryColor),
                                      color: ColorConstant.primaryColor),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Image.asset(
                                      'assets/icon/message.png',
                                      height: 27,
                                      width: 27,
                                    ),
                                  )),
                              tiny5HorSpace(),
                              Text(
                                doctor.email ?? 'No email available',
                                style: const TextStyle(
                                  color: Color(0xff595959),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      smallSpace(),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(
                                color: ColorConstant.primaryLightColor
                                    .withOpacity(0.3)),
                            color: ColorConstant.primaryLightColor
                                .withOpacity(0.3)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                          color: ColorConstant.primaryColor),
                                      color: ColorConstant.primaryColor),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Image.asset(
                                      'assets/icon/call.png',
                                      height: 27,
                                      width: 27,
                                    ),
                                  )),
                              tiny5HorSpace(),
                              Text(
                                doctor.phoneNumber ?? 'No phone available',
                                style: const TextStyle(
                                  color: Color(0xff595959),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      verticalSpace(context, 0.04),
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
                          context.push(Routes.BOOKAPPOINTMENT, extra: doctor);
                        },
                        child: const Text(
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Colors.white),
                            "Book Appointment"),
                      ),
                      smallSpace(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: ColorConstant.primaryColor,
                          minimumSize: const Size(double.infinity, 55),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: ColorConstant.primaryColor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          // context.push(Routes.BOOKAPPOINTMENT, extra: doctor);
                          context.push(Routes.COMMUNITYLIST);
                        },
                        child: Text(
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: ColorConstant.primaryColor),
                            "View Dr. ${doctor.firstName}'s Community"),
                      ),
                      smallSpace(),
                      // RouteMapWidget(
                      //   from:
                      //       'current', // special keyword to use current device location
                      //   to: doctor.healthCareProvider!.location ?? '',
                      //   travelMode:
                      //       'driving', // or 'walking', 'bicycling', 'transit'
                      // ),
                      verticalSpace(context, 0.08),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
