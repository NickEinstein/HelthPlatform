import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/utils/custom_header.dart';

class CaregiverDetailsPage extends StatelessWidget {
  final Map<String, dynamic> caregiver;

  const CaregiverDetailsPage({super.key, required this.caregiver});

  @override
  Widget build(BuildContext context) {
    final name = caregiver['name'] ?? 'Unknown';
    final location = caregiver['location'] ?? 'No location provided';
    final email = caregiver['email'] ?? 'No email';
    final phone = caregiver['phone'] ?? 'No phone';
    final type = 'Health Center'; // You can dynamically update this later
    final address = '10 Crescent Close, Yaba, Lagos'; // Optional fallback

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              CustomHeader(
                title: name,
                onPressed: () => Navigator.pop(context),
                onSearchPressed: () {},
              ),
              const SizedBox(height: 24),
              Center(
                child: CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.green.shade100,
                  child: Text(
                    name.toString().substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      fontSize: 28,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Center(
                child: Text(
                  location.isNotEmpty ? location : address,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    type,
                    style: const TextStyle(color: Colors.green),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                'Lacus, nulla a accumsan at morbi bibendum tortor id a. '
                'Nullam amet, ultricies orci ultrices odio condimentum.',
                style: TextStyle(color: Colors.black87, fontSize: 14),
              ),
              const SizedBox(height: 24),
              const Text(
                'Contact Details',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Color(0xFFDFF5E4),
                    radius: 20,
                    child: Icon(Icons.email, color: Colors.green),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDFF5E4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        email,
                        style: const TextStyle(color: Colors.green),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Color(0xFFDFF5E4),
                    radius: 20,
                    child: Icon(Icons.phone, color: Colors.green),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    phone,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              const Text(
                'Location',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),
              Container(
                height: 180,
                width: double.infinity,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset(
                  'assets/images/map_app.png',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
