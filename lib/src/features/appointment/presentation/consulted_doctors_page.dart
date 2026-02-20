import 'package:greenzone_medical/src/utils/packages.dart';

class ConsultedDoctorsPage extends StatefulWidget {
  const ConsultedDoctorsPage({super.key});

  @override
  State<ConsultedDoctorsPage> createState() => _ConsultedDoctorsPageState();
}

class _ConsultedDoctorsPageState extends State<ConsultedDoctorsPage> {
  final TextEditingController _searchController = TextEditingController();

  // Toggle this to test both states
  bool get _isEmpty => _consultations.isEmpty;

  final List<Map<String, String>> _consultations = [
    {
      'doctor': 'Dr. Adams Adewole Oni',
      'clinic': 'Healing Stripes Medical Centre',
      'address': '14, Tony Brown Street, Victoria Island Lagos.',
      'date': '23 Nov 2025, 20:48:11',
      'diagnosis': 'Respiratory Infection',
      'specialty': 'general',
    },
    {
      'doctor': 'Dr. Margaret Adesola',
      'clinic': 'Smile 360 Dental Clinic',
      'address': '14, Tony Brown Street, Victoria Island Lagos.',
      'date': '23 Nov 2025, 20:48:11',
      'diagnosis': 'Respiratory Infection',
      'specialty': 'dental',
    },
    {
      'doctor': 'Dr. Adams Adewole Oni',
      'clinic': 'Healing Stripes Medical Centre',
      'address': '14, Tony Brown Street, Victoria Island Lagos.',
      'date': '23 Nov 2025, 20:48:11',
      'diagnosis': 'Respiratory Infection',
      'specialty': 'general',
    },
  ];

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
          "Consulted Doctors",
          style: TextStyle(
            color: Color(0xff344054),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildSearchAndFilter(),
            const SizedBox(height: 30),
            Expanded(
              child: _isEmpty ? _buildEmptyState() : _buildConsultationList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: "Search for Labs",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.tune, color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade100, width: 2),
            ),
            child: Icon(Icons.person_outline,
                size: 60, color: Colors.grey.shade300),
          ),
          const SizedBox(height: 24),
          const Text(
            "No consulted doctors found",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xff475467),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Your consultation history will appear here",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 100), // Push up slightly from center
        ],
      ),
    );
  }

  Widget _buildConsultationList() {
    return ListView.builder(
      itemCount: _consultations.length,
      padding: const EdgeInsets.only(bottom: 20),
      itemBuilder: (context, index) {
        final item = _consultations[index];
        return _buildConsultationCard(item);
      },
    );
  }

  Widget _buildConsultationCard(Map<String, String> data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSpecialtyIcon(data['specialty'] ?? 'general'),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data['doctor'] ?? "",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color(0xff1D2939),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios,
                              size: 14, color: Colors.grey),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        data['clinic'] ?? "",
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        data['address'] ?? "",
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.access_time,
                              size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            data['date'] ?? "",
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xffD1FADF),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "Completed",
                              style: TextStyle(
                                color: Color(0xff039855),
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(11),
                bottomRight: Radius.circular(11),
              ),
            ),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 13, color: Color(0xff344054)),
                children: [
                  const TextSpan(
                    text: "Diagnosis: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: data['diagnosis'] ?? ""),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialtyIcon(String specialty) {
    IconData iconData = Icons.medical_services;
    Color iconColor = const Color(0xff12B76A);

    if (specialty == 'dental') {
      iconData = Icons.medical_services_outlined;
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade100),
        shape: BoxShape.circle,
      ),
      child: Icon(iconData, color: iconColor, size: 24),
    );
  }
}
