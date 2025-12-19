import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/color_constant.dart';
import '../../../constants/dimens.dart';
import '../../../utils/custom_header.dart';
import 'widget/account_controller_holder.dart';

class UploadSelfieScreen extends ConsumerStatefulWidget {
  final VoidCallback onNext;
  final GlobalKey<FormState> formKey;
  final AccountCreationController controller;

  const UploadSelfieScreen({
    super.key,
    required this.onNext,
    required this.formKey,
    required this.controller,
  });
  @override
  _UploadSelfieScreenState createState() => _UploadSelfieScreenState();
}

class _UploadSelfieScreenState extends ConsumerState<UploadSelfieScreen> {
  final ImagePicker _picker = ImagePicker();
  bool _isValid = false;

  void _validateForm() {
    setState(() {
      _isValid = widget.formKey.currentState?.validate() ?? false;
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile =
        await _picker.pickImage(source: source, imageQuality: 75);
    if (pickedFile != null) {
      setState(() {
        widget.controller.imageFile = File(pickedFile.path);
      });

      /// Optional: Automatically upload after picking
      // final result = await widget.controller
      //     .uploadProfileUrl(widget.controller.imageFile!);
      // print("Upload result: $result");
    }
  }

  Widget _buildImagePreview() {
    return CircleAvatar(
      radius: 100,
      backgroundColor: Colors.green.shade50,
      child: widget.controller.imageFile == null
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.camera_alt_outlined,
                    size: 60, color: Colors.green),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreenAccent.shade100,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: () => _pickImage(ImageSource.camera),
                  icon: Icon(Icons.camera_alt, color: Colors.green.shade900),
                  label: const Text("Take a photo"),
                ),
              ],
            )
          : ClipOval(
              child: Image.file(
                widget.controller.imageFile!,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: widget.formKey,
        onChanged: _validateForm,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomHeader(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                smallSpace(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                            text: "Upload your",
                            style: TextStyle(
                                color: Color(0xff3C3B3B),
                                fontWeight: FontWeight.w500,
                                fontSize: 24),
                          ),
                          TextSpan(
                            text: " selfie",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 24,
                                color: ColorConstant.primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                _buildImagePreview(),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  child: const Text(
                    "Upload a picture",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                mediumSpace(),
                smallSpace(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
