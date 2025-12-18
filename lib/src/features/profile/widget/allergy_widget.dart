import 'package:greenzone_medical/src/features/profile/model/allergy_list_model.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/packages.dart';
import 'package:intl/intl.dart';

class AllergyWidget extends ConsumerStatefulWidget {
  final UserAllergyModel allergy;
  final AllergyListModel? otherAllergy;
  const AllergyWidget({super.key, required this.allergy, this.otherAllergy});

  @override
  ConsumerState<AllergyWidget> createState() => _AllergyWidgetState();
}

class _AllergyWidgetState extends ConsumerState<AllergyWidget> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isOpen = !isOpen;
        });
      },
      child: isOpen
          ? Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFAEAEAE),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.allergy.allergy,
                          style: context.textTheme.labelLarge,
                        ),
                        const RotatedBox(
                            quarterTurns: 1,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                              color: Color(0xFFB3B3B3),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Age:',
                                style: context.textTheme.labelLarge,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.allergy.allergy,
                                style: context.textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                        8.height,
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Batch Number:',
                                style: context.textTheme.labelLarge,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                // widget.immunization.batchId ?? '',
                                '',
                                style: context.textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                        8.height,
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Brand:',
                                style: context.textTheme.labelLarge,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                // widget.immunization.vaccineBrand ?? '',
                                '',
                                style: context.textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Text(
                      DateFormat('MMMM dd, yyyy').format(
                        // widget.immunization.dateGiven ??
                        DateTime.now(),
                      ),
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF797979),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    // widget.immunization.vaccine ??
                    '',
                    style: context.textTheme.labelLarge,
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Color(0xFFB3B3B3),
                  )
                ],
              ),
            ),
    );
  }
}
