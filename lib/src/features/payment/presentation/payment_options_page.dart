import 'package:greenzone_medical/src/utils/packages.dart';

class PaymentOptionsPage extends StatefulWidget {
  const PaymentOptionsPage({super.key});

  @override
  State<PaymentOptionsPage> createState() => _PaymentOptionsPageState();
}

class _PaymentOptionsPageState extends State<PaymentOptionsPage> {
  int _selectedOption = 0; // 0 for Wallet, 1 for Other

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8),
          child: InkWell(
            onTap: () => context.pop(),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffD1FADF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.arrow_back_ios_new,
                  color: Colors.white, size: 20),
            ),
          ),
        ),
        title: const Text(
          "Payment",
          style: TextStyle(
            color: Color(0xff344054),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text(
                "How would you like to pay?",
                style: TextStyle(
                  color: Color(0xff039855),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Your payment is required to complete the booking but it will be kept until the Doctor has delivered service.",
                style: TextStyle(
                  color: Color(0xff667085),
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              _buildPaymentOption(
                index: 0,
                title: "Pay from your ConnectingHealth Wallet",
                selectedColor: const Color(0xff039855),
                textColor: Colors.white,
              ),
              const SizedBox(height: 16),
              _buildPaymentOption(
                index: 1,
                title: "Pay with other options",
                selectedColor: const Color(0xffD1FADF),
                textColor: const Color(0xff039855),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement payment logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff039855),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Proceed with Payment",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOption({
    required int index,
    required String title,
    required Color selectedColor,
    required Color textColor,
  }) {
    bool isSelected = _selectedOption == index;

    return InkWell(
      onTap: () => setState(() => _selectedOption = index),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? selectedColor : Colors.grey.shade200,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? Colors.white : Colors.grey.shade300,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: isSelected
                  ? const Center(
                      child: Icon(Icons.check, size: 16, color: Colors.white),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: isSelected ? textColor : const Color(0xff344054),
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
