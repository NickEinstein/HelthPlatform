import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';

class DrugCheckout extends StatefulWidget {
  static const routeName = '/drug-checkout';
  const DrugCheckout({super.key});

  @override
  State<DrugCheckout> createState() => _DrugCheckoutState();
}

class _DrugCheckoutState extends State<DrugCheckout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => context.pop(),
                    child: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF109615), // Green
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Icon(Icons.shopping_cart_outlined,
                            size: 20, color: Colors.white),
                      ),
                      Positioned(
                        top: -8,
                        right: -8,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: Color(0xFFB9F6CA), // Light green badge
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '3',
                            style: context.textTheme.labelSmall?.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              20.height,
              Text(
                'Prescription',
                style: context.textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                ),
              ),
              Text(
                'Check-Out',
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                'Transaction #ID: 04635798785HKS90',
                style: context.textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
              20.height,
              const Divider(),
              10.height,

              // Cart Items
              _buildCartItem(
                drugName: 'Tetracycline',
                pharmacyName: 'MedPlus Pharmacies',
                price: 'N1,200.00',
                quantity: 4,
              ),
              const Divider(),
              _buildCartItem(
                drugName: 'Paracetamol',
                pharmacyName: 'MedPlus Pharmacies',
                price: 'N1,200.00',
                quantity: 4,
              ),
              const Divider(),
              10.height,

              // Summary
              _buildSummaryRow('N2,400.00', isBold: true),
              10.height,
              _buildSummaryRow('Delivery Fee', value: 'N450.00'),
              10.height,
              _buildSummaryRow('Platform Convenience fee', value: 'N200.00'),
              10.height,
              const Divider(thickness: 2, color: Color(0xFF109615)),
              10.height,
              _buildSummaryRow('Grand Total', value: 'N3,050.00', isBold: true),
              30.height,

              // Info Box
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F8E9), // Light green background
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFF4CAF50)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Delivery Details:',
                      style: context.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    5.height,
                    Text(
                      'This is to inform the General Public that the following products are approved for withdrawal, suspension and cancellation by NAFDAC. They are therefore no longer permitted for manufacture, importation, exportation, distribution, advertisement, sale and use within Nigeria.',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade700,
                        fontSize: 10,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              30.height,

              // Continue Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF109615),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCartItem({
    required String drugName,
    required String pharmacyName,
    required String price,
    required int quantity,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                drugName,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF109615),
                ),
              ),
              Text(
                pharmacyName,
                style: context.textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      quantity.toString(),
                      style: context.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  5.width,
                  const Icon(Icons.add_circle_outline,
                      size: 20, color: Colors.grey),
                  5.width,
                  const Icon(Icons.remove_circle_outline,
                      size: 20, color: Colors.grey),
                ],
              ),
              5.height,
              Text(
                price,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, {String? value, bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: isBold ? Colors.black : Colors.grey.shade700,
          ),
        ),
        if (value != null)
          Text(
            value,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: Colors.black,
            ),
          ),
      ],
    );
  }
}
