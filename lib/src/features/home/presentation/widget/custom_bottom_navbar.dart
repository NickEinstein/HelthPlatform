import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/constants/constants.dart';
import 'package:greenzone_medical/src/features/account/account.dart';
import 'package:greenzone_medical/src/features/appointment/appointment.dart';

import '../../../prescription/presentation/prescriptions.dart';
import '../../home.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int setPage;

  CustomBottomNavBar({this.setPage = 0});

  @override
  _CustomBottomNavState createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNavBar> {
  int currentTab = 0;
  final List<Widget> screen = [
    const HomePage(),
    const AppointmentPage(),
    const PrescriptionPage(),
    const AccountPage()
  ];

  @override
  void initState() {
    super.initState();
    currentTab = widget.setPage;
    currentScreen = screen[widget.setPage];
  }

  final PageStorageBucket bucket = PageStorageBucket();
  late Widget currentScreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50), // Rounded top-left
          topRight: Radius.circular(50), // Rounded top-right
        ),
        child: BottomAppBar(
          elevation: 1,
          color: Colors.white,
          child: Container(
            height: 65, // Adjusted height
            padding:
                const EdgeInsets.symmetric(vertical: 6), // Adjusted padding
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly, // Evenly distribute
              children: [
                _buildTabItem(0, 'Home', 'assets/icon/home_g.png',
                    'assets/icon/home.png'),
                _buildTabItem(
                    1,
                    'Appointment',
                    'assets/icon/appointment_g_home.png',
                    'assets/icon/appointment_home.png'),
                _buildTabItem(2, 'Prescription', 'assets/icon/prescription.png',
                    'assets/icon/prescription.png'),
                _buildTabItem(3, 'Account', 'assets/icon/profile.png',
                    'assets/icon/profile.png'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabItem(
      int index, String label, String iconPath, String activeIconPath) {
    bool isSelected = currentTab == index;
    return Expanded(
      // Ensures equal spacing
      child: GestureDetector(
        onTap: () {
          setState(() {
            currentScreen = screen[index];
            currentTab = index;
          });
        },
        child: SizedBox(
          height: 45, // Fixed height to prevent overflow
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                isSelected ? activeIconPath : iconPath,
                height: 24, // Reduced size to fit
                width: 24,
              ),
              const SizedBox(height: 2), // Reduced spacing
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12, // Reduced font size
                  color: isSelected
                      ? ColorConstant.primaryColor
                      : ColorConstant.secondryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
