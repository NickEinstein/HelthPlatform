import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final VoidCallback? onCameraTap;

  const CustomSearchBar({super.key, this.onCameraTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white, // ✅ Ensures no Flutter default color interference
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffE6E6E6)),
          color: Colors.white, // ✅ Explicitly setting white background
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Image.asset(
              'assets/images/search.png',
              height: 32,
              width: 25,
            ),
            const SizedBox(width: 8),
            const Expanded(
              child: TextField(
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "Search meds or article...",
                  hintStyle: TextStyle(
                      color: Color(0xff999999),
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  border: InputBorder.none, // ✅ Removes TextField border
                  contentPadding: EdgeInsets.zero, // ✅ Removes extra padding
                ),
              ),
            ),
            GestureDetector(
              onTap: onCameraTap,
              child: const Icon(Icons.camera_alt, color: Color(0xff999999)),
            ),
          ],
        ),
      ),
    );
  }
}
