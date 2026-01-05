import 'package:intl/intl.dart';

import '../../../../utils/packages.dart';

class ReasoncancelledAppointments extends StatefulWidget {
  final String appointmentId;
  final VoidCallback? onRefresh;
  final bool? isCanceled;

  const ReasoncancelledAppointments(
      {super.key,
      required this.appointmentId,
      this.onRefresh,
      this.isCanceled});

  @override
  State<ReasoncancelledAppointments> createState() =>
      _ReasoncancelledAppointmentsState();
}

class _ReasoncancelledAppointmentsState
    extends State<ReasoncancelledAppointments> {
  final List<Map<String, dynamic>> options = [
    {
      'label': 'I just want to cancel',
      'value': 'I just want to cancel',
      'selected': false
    },
    {
      'label': 'I have an activity that can’t be left behind',
      'value': 'I have an activity that can’t be left behind',
      'selected': false
    },
    {
      'label': 'I’m having a schedule clash',
      'value': 'I’m having a schedule clash',
      'selected': false
    },
    {
      'label': 'The Symptons for the visit is no more',
      'value': 'The Symptons for the visit is no more',
      'selected': false
    },
    {
      'label': 'I don’t want to tell',
      'value': 'I don’t want to tell',
      'selected': false
    },
    {'label': 'Others', 'value': 'Others', 'selected': false},
  ];

  final List<Map<String, dynamic>> optionsReschedule = [
    {
      'label': 'I’m not available on schedule',
      'value': 'I’m not available on schedule',
      'selected': false
    },
    {
      'label': 'I have an activity that can’t be left behind',
      'value': 'I have an activity that can’t be left behind',
      'selected': false
    },
    {
      'label': 'I’m having a schedule clash',
      'value': 'I’m having a schedule clash',
      'selected': false
    },
    {
      'label': 'I’m not available on schedule',
      'value': 'I’m not available on schedule',
      'selected': false
    },
    {'label': 'Others', 'value': 'Others', 'selected': false},
  ];

  String? getSelectedValue() {
    final selectedOption = options
        .firstWhere((option) => option['selected'] == true, orElse: () => {});
    return selectedOption.isNotEmpty ? selectedOption['value'] as String : null;
  }

  String? getSelectedRescheduleValue() {
    final selectedOption = optionsReschedule
        .firstWhere((option) => option['selected'] == true, orElse: () => {});
    return selectedOption.isNotEmpty ? selectedOption['value'] as String : null;
  }

  bool isAnyOptionSelected() {
    return options.any((option) => option['selected'] == true);
  }

  bool isLoading = false;

  void showSuccessModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cancel, color: Colors.red, size: 60),
            const SizedBox(height: 10),
            const Text(
              'Successfully Cancelled',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            const SizedBox(height: 10),
            const Text(
              'We are sad that you have to cancel your appointment',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red.shade50,
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () => context.pushReplacement(Routes.BOTTOMNAV),
              child:
                  const Text('Thank you', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                title: widget.isCanceled!
                    ? 'Cancel Appointment'
                    : 'Reschedule Appointment',
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
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: SingleChildScrollView(
          child: widget.isCanceled!
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      "Reason for Cancellation",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff3C3B3B),
                      ),
                    ),
                    smallSpace(),
                    ...options.map((option) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            bottom: 16.0), // Add space between checkboxes
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  // Unselect all other options and select the current one
                                  for (var e in options) {
                                    e['selected'] = false;
                                  }
                                  option['selected'] = true;
                                });
                              },
                              child: Container(
                                width: 32,
                                height: 32, // Height of the checkbox
                                decoration: BoxDecoration(
                                  color: Colors.white, // White background
                                  borderRadius: BorderRadius.circular(
                                      16), // Circular shape
                                  border: Border.all(
                                    color: Colors.green, // Green border
                                    width: 2, // Border width
                                  ),
                                ),
                                child: option['selected']
                                    ? Padding(
                                        padding: const EdgeInsets.all(
                                            4.0), // Small padding for inner circle
                                        child: Container(
                                          width: 16, // Size of the inner circle
                                          height:
                                              16, // Size of the inner circle
                                          decoration: const BoxDecoration(
                                            color: Colors
                                                .green, // Inner green circle
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      )
                                    : null, // No inner circle when not selected
                              ),
                            ),
                            const SizedBox(
                                width: 10), // Space between checkbox and text
                            Text(option['label']),
                          ],
                        ),
                      );
                    }).toList(),
                    smallSpace(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.green
                            .shade50, // or your custom color e.g., Color(0x4D17631A)
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "We understand that plans can change. If you need any help rescheduling or have any concerns, feel free to reach out to us. We're here to assist you!",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              color: Color(0xff3C3B3B),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    verticalSpace(context, 0.08),
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: isAnyOptionSelected() && !isLoading
                                  ? () async {
                                      setState(() {
                                        isLoading = true;
                                      });

                                      String? selectedValue =
                                          getSelectedValue();
                                      debugPrint(
                                          'Selected Value: $selectedValue');

                                      try {
                                        final apiService = ApiService();
                                        final now = DateTime.now();
                                        final formattedDate =
                                            DateFormat('yyyy/MM/dd')
                                                .format(now);
                                        final formattedTime =
                                            DateFormat('HH:mm').format(now);

                                        final response = await apiService.put(
                                          ApiUrl.cancelAppointment,
                                          data: {
                                            "id": widget.appointmentId,
                                            "isCanceled": true,
                                            "healthCareProviderId": 0,
                                            "canceledDate": formattedDate,
                                            "canceledTime": formattedTime,
                                            "cancelReason": selectedValue,
                                          },
                                        );

                                        if (response.statusCode == 200) {
                                          if (context.mounted) {
                                            showSuccessModal(context);
                                          }
                                          // widget.onRefresh?.call();
                                        } else {
                                          if (context.mounted) {
                                            CustomToast.show(
                                              context,
                                              "Failed to cancel appointment",
                                              type: ToastType.error,
                                            );
                                          }
                                        }
                                      } catch (e) {
                                        if (context.mounted) {
                                          CustomToast.show(
                                            context,
                                            "An error occurred while cancelling",
                                            type: ToastType.error,
                                          );
                                        }
                                      } finally {
                                        setState(() {
                                          isLoading = false;
                                        });
                                      }
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isAnyOptionSelected()
                                    ? ColorConstant.primaryColor
                                    : Colors.grey
                                        .shade400, // Optional: dim color if disabled
                                padding:
                                    const EdgeInsets.symmetric(vertical: 22),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Next',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      "Reason for Schedule Change",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff3C3B3B),
                      ),
                    ),
                    smallSpace(),
                    ...optionsReschedule.map((option) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            bottom: 16.0), // Add space between checkboxes
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  // Unselect all other options and select the current one
                                  for (var e in optionsReschedule) {
                                    e['selected'] = false;
                                  }
                                  option['selected'] = true;
                                });
                              },
                              child: Container(
                                width: 32,
                                height: 32, // Height of the checkbox
                                decoration: BoxDecoration(
                                  color: Colors.white, // White background
                                  borderRadius: BorderRadius.circular(
                                      16), // Circular shape
                                  border: Border.all(
                                    color: Colors.green, // Green border
                                    width: 2, // Border width
                                  ),
                                ),
                                child: option['selected']
                                    ? Padding(
                                        padding: const EdgeInsets.all(
                                            4.0), // Small padding for inner circle
                                        child: Container(
                                          width: 16, // Size of the inner circle
                                          height:
                                              16, // Size of the inner circle
                                          decoration: const BoxDecoration(
                                            color: Colors
                                                .green, // Inner green circle
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      )
                                    : null, // No inner circle when not selected
                              ),
                            ),
                            const SizedBox(
                                width: 10), // Space between checkbox and text
                            Text(option['label']),
                          ],
                        ),
                      );
                    }).toList(),
                    smallSpace(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.green
                            .shade50, // or your custom color e.g., Color(0x4D17631A)
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "We understand that plans can change. If you need any help rescheduling or have any concerns, feel free to reach out to us. We're here to assist you!",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              color: Color(0xff3C3B3B),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    verticalSpace(context, 0.08),
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: isAnyOptionSelected() && !isLoading
                                  ? () async {
                                      setState(() {
                                        isLoading = true;
                                      });

                                      String? selectedValue =
                                          getSelectedValue();
                                      debugPrint(
                                          'Selected Value: $selectedValue');

                                      try {
                                        final apiService = ApiService();
                                        final now = DateTime.now();
                                        final formattedDate =
                                            DateFormat('yyyy/MM/dd')
                                                .format(now);
                                        final formattedTime =
                                            DateFormat('HH:mm').format(now);

                                        final response = await apiService.put(
                                          ApiUrl.cancelAppointment,
                                          data: {
                                            "id": widget.appointmentId,
                                            "isCanceled": true,
                                            "healthCareProviderId": 0,
                                            "canceledDate": formattedDate,
                                            "canceledTime": formattedTime,
                                            "cancelReason": selectedValue,
                                          },
                                        );

                                        if (response.statusCode == 200) {
                                          if (context.mounted) {
                                            showSuccessModal(context);
                                          }
                                          widget.onRefresh?.call();
                                        } else {
                                          if (context.mounted) {
                                            CustomToast.show(
                                              context,
                                              "Failed to cancel appointment",
                                              type: ToastType.error,
                                            );
                                          }
                                        }
                                      } catch (e) {
                                        if (context.mounted) {
                                          CustomToast.show(
                                            context,
                                            "An error occurred while cancelling",
                                            type: ToastType.error,
                                          );
                                        }
                                      } finally {
                                        setState(() {
                                          isLoading = false;
                                        });
                                      }
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isAnyOptionSelected()
                                    ? ColorConstant.primaryColor
                                    : Colors.grey
                                        .shade400, // Optional: dim color if disabled
                                padding:
                                    const EdgeInsets.symmetric(vertical: 22),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Next',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                  ],
                ),
        ),
      ),
    );
  }
}
