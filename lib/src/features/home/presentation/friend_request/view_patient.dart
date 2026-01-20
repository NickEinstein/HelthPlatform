import '../../../../provider/all_providers.dart';
import '../../../../utils/packages.dart';
import '../../model/friend_request_receiver.dart';

class ViewPatientPage extends ConsumerStatefulWidget {
  final FriendRequestReceiverResponse friendRequestReceiverResponse;
  const ViewPatientPage(
      {super.key, required this.friendRequestReceiverResponse});

  @override
  ConsumerState<ViewPatientPage> createState() => _ViewPatientPageState();
}

class _ViewPatientPageState extends ConsumerState<ViewPatientPage> {
  @override
  Widget build(BuildContext context) {
    final patientIdResponse = ref.watch(userPatientIdProvider(
        widget.friendRequestReceiverResponse.patientSender!.id!));
    final isLoading = ref.watch(isLoadingProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Expanded(
              child: CustomHeader(
                title: 'Patient Profile',
                onPressed: () {
                  Navigator.pop(context);
                },
                // onSearchPressed: () {},
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: patientIdResponse.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) =>
              const Center(child: Text('No available prescription')),
          data: (patientProfile) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        patientProfile.pictureUrl!,
                        width: 80,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset('assets/images/profimg.png',
                                width: 80, height: 100, fit: BoxFit.cover),
                      )),
                  const SizedBox(height: 20),
                  Text(
                    "${patientProfile.firstName} ${patientProfile.lastName} ",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "${patientProfile.email} ",
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.green
                          .shade50, // or your custom color e.g., Color(0x4D17631A)
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "${patientProfile.gender} ",
                      style: TextStyle(color: Colors.green, fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ReportTile(
                    title: "Place of Birth ",
                    date: "${patientProfile.placeOfBirth}",
                  ),
                  ReportTile(
                    title: "Local Government Area",
                    date: "${patientProfile.lga}",
                  ),
                  ReportTile(
                    title: "State of Origin",
                    date: "${patientProfile.stateOfOrigin}",
                  ),
                  ReportTile(
                    title: "Nationality",
                    date: "${patientProfile.nationality}",
                  ),
                  smallSpace(),
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                // Handle Reject
                                ref.read(isLoadingProvider.notifier).state =
                                    true;

                                final allService = ref.read(allServiceProvider);

                                final result = await allService
                                    .friendRequestResponseToRequest(
                                        id: widget
                                            .friendRequestReceiverResponse.id!,
                                        receiverPatientId: widget
                                            .friendRequestReceiverResponse
                                            .patientReceiver!
                                            .id!,
                                        isAccepted: false);
                                if (!context.mounted) {
                                  return;
                                } // Prevents using context if unmounted
                                ref.read(isLoadingProvider.notifier).state =
                                    false; // Stop loading
                                if (result == 'successful') {
                                  showInfoBottomSheet(
                                    context,
                                    'Notice',
                                    'Friend request rejected successfully.',
                                    buttonText: 'Close',
                                    isAnotherTime: false,
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      context.pushReplacement(Routes.BOTTOMNAV);
                                    },
                                  );
                                } else {
                                  CustomToast.show(context, result,
                                      type: ToastType.error);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text('Reject'),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () async {
                                // Handle Reject
                                ref.read(isLoadingProvider.notifier).state =
                                    true;

                                final allService = ref.read(allServiceProvider);

                                final result = await allService
                                    .friendRequestResponseToRequest(
                                        id: widget
                                            .friendRequestReceiverResponse.id!,
                                        receiverPatientId: widget
                                            .friendRequestReceiverResponse
                                            .patientReceiver!
                                            .id!,
                                        isAccepted: true);
                                if (!context.mounted) {
                                  return;
                                } // Prevents using context if unmounted
                                ref.read(isLoadingProvider.notifier).state =
                                    false; // Stop loading
                                if (result == 'successful') {
                                  showInfoBottomSheet(
                                    context,
                                    'Notice',
                                    'Friend request Accepted successfully.',
                                    buttonText: 'Close',
                                    isAnotherTime: false,
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      context.pushReplacement(Routes.BOTTOMNAV);
                                    },
                                  );
                                } else {
                                  CustomToast.show(context, result,
                                      type: ToastType.error);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text('Accept'),
                            ),
                          ],
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ReportTile extends StatelessWidget {
  final String title;
  final String date;

  const ReportTile({
    super.key,
    required this.title,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => context.push(Routes.DOCTORSREPORTDETAILS),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.green.shade50.withValues(alpha: 0.4),
        ),
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green.shade100,
            ),
            child: const Icon(Icons.medical_services, color: Colors.green),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: [
              // const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Text(date, style: const TextStyle(fontSize: 12)),
              const SizedBox(width: 10),
              // const Icon(Icons.access_time, size: 14, color: Colors.grey),
              // const SizedBox(width: 4),
              // Text(time, style: const TextStyle(fontSize: 12)),
            ],
          ),
          // trailing:
          //     const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ),
      ),
    );
  }
}
