import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/features/ekiosk/data/model/drug_model.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';

class SingleDrugDetail extends StatelessWidget {
  static const routeName = '/single-drug-detail';
  final DrugModel drug;
  const SingleDrugDetail({super.key, required this.drug});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () => context.pop(),
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Prescription Details',
              style: context.textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
            ),
            5.height,
            Text(
              drug.name,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            30.height,
            // Product Image
            Center(
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                  image: drug.logoPath.isEmpty
                      ? const DecorationImage(
                          image:
                              AssetImage('assets/images/drug_placeholder.png'),
                        )
                      : DecorationImage(
                          image: NetworkImage(drug.logoPath),
                          fit: BoxFit.contain,
                        ),
                ),
                // Fallback icon if image not found (for dev)
                child:
                    const Icon(Icons.medication, size: 80, color: Colors.grey),
              ),
            ),
            30.height,
            // Details
            _buildDetailItem(
              context,
              label: 'Description',
              value: drug.description,
            ),
            const Divider(height: 30),
            _buildDetailItem(
              context,
              label: 'Clinic Name',
              value: drug.clinicName,
            ),
            const Divider(height: 30),
            _buildDetailItem(
              context,
              label: 'Clinic ID',
              value: drug.clinicId.toString(),
            ),
            // const Divider(height: 30),
            // _buildDetailItem(
            //   context,
            //   label: 'Marketer',
            //   value: 'Healthline Limited',
            // ),
            // const Divider(height: 30),
            // _buildDetailItem(
            //   context,
            //   label: 'Application Purpose',
            //   value: 'Withdrawn Voluntarily by Market Authorization Holder',
            //   valueBelow: true,
            // ),
            // 20.height,
            // InkWell(
            //   onTap: () {
            //     context.push(DeliveryDetails.routeName);
            //   },
            //   child: Container(
            //     padding: const EdgeInsets.all(8),
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(8),
            //       color: Colors.white,
            //     ),
            //     child: Text(
            //       'Continue',
            //       style: context.textTheme.bodyLarge?.copyWith(
            //         color: Colors.black,
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(
    BuildContext context, {
    required String label,
    required String value,
    bool valueBelow = false,
  }) {
    Widget labelWidget = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF32CD32), // Lime green
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: context.textTheme.bodySmall?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    Widget valueWidget = Text(
      value,
      style: context.textTheme.bodyMedium?.copyWith(
        color: Colors.grey.shade800,
      ),
    );

    if (valueBelow) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labelWidget,
          10.height,
          valueWidget,
        ],
      );
    }

    return Row(
      children: [
        labelWidget,
        15.width,
        Expanded(child: valueWidget),
      ],
    );
  }
}
