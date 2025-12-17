import 'package:greenzone_medical/src/features/profile/model/immunization_result.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/packages.dart';
import 'package:intl/intl.dart';

class ImmunizationWidget extends StatefulWidget {
  final ImmunizationResult immunization;
  const ImmunizationWidget({super.key, required this.immunization});

  @override
  State<ImmunizationWidget> createState() => _ImmunizationWidgetState();
}

class _ImmunizationWidgetState extends State<ImmunizationWidget> {
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
          ? SizedBox(
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
                        Text(widget.immunization.vaccine ?? '   '),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFFB3B3B3),
                        )
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
                                widget.immunization.age.toString(),
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
                                widget.immunization.batchId ?? '',
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
                                widget.immunization.vaccineBrand ?? '',
                                style: context.textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFB3B3B3),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Text(
                      DateFormat('mmmm dd, yyyy').format(
                        widget.immunization.dateGiven ?? DateTime.now(),
                      ),
                      style: context.textTheme.bodyMedium,
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
                  Text(widget.immunization.vaccine ?? '   '),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xFFB3B3B3),
                  )
                ],
              ),
            ),
    );
  }
}
