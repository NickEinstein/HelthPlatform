import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final Color backgroundColor;
  final VoidCallback? onTap;

  const CustomListTile({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    this.backgroundColor =
        const Color(0xFFE0E0E0), // default grayish background
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 24,
        child: ClipOval(
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Color(0xff909090)),
      ),
      trailing: const Icon(Icons.arrow_forward_ios,
          color: Color(0xffCCCCCC), size: 16),
      onTap: onTap,
    );
  }
}
