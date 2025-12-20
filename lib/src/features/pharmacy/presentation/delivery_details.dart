import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/features/pharmacy/presentation/drug_checkout.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';

class DeliveryDetails extends StatefulWidget {
  static const routeName = '/delivery-details';
  const DeliveryDetails({super.key});

  @override
  State<DeliveryDetails> createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  final TextEditingController _stateController =
      TextEditingController(text: 'Abia');
  final TextEditingController _lgaController =
      TextEditingController(text: 'Abia-North-South');
  final TextEditingController _cityController =
      TextEditingController(text: 'Abia');
  final TextEditingController _addressController =
      TextEditingController(text: '3 Adeola Folami Street');
  final TextEditingController _contactPersonController =
      TextEditingController(text: 'William Humphrey');
  final TextEditingController _phoneController =
      TextEditingController(text: '080368368728');

  @override
  void dispose() {
    _stateController.dispose();
    _lgaController.dispose();
    _cityController.dispose();
    _addressController.dispose();
    _contactPersonController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Delivery Details',
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFFDCF8C6), // Light green
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(color: Color(0xFF109615)),
                      ),
                    ),
                    child: Text(
                      'Use Google',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ],
              ),
              30.height,
              _buildFormField(
                context,
                label: 'State',
                controller: _stateController,
              ),
              20.height,
              _buildFormField(
                context,
                label: 'Local Government Area',
                controller: _lgaController,
              ),
              20.height,
              _buildFormField(
                context,
                label: 'City',
                controller: _cityController,
              ),
              20.height,
              _buildFormField(
                context,
                label: 'House Number & Street',
                controller: _addressController,
              ),
              20.height,
              _buildFormField(
                context,
                label: 'Contact Person',
                controller: _contactPersonController,
              ),
              20.height,
              _buildFormField(
                context,
                label: 'Phone Number',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
              ),
              40.height,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.push(DrugCheckout.routeName);
                  },
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
                      fontSize: 16,
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

  Widget _buildFormField(
    BuildContext context, {
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
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
        ),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: context.textTheme.bodyMedium?.copyWith(
            color: Colors.grey.shade800,
          ),
          decoration: const InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 10),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF109615)),
            ),
          ),
        ),
      ],
    );
  }
}
