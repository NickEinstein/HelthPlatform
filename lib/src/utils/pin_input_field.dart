import 'package:flutter/material.dart';

import '../constants/color_constant.dart';

class PinInputField extends StatefulWidget {
  final int length;
  final Function(String) onChanged;
  final Function(String)? onCompleted;
  final String? Function(String)? validator;

  const PinInputField({
    Key? key,
    this.length = 4,
    required this.onChanged,
    this.onCompleted,
    this.validator,
  }) : super(key: key);

  @override
  _PinInputFieldState createState() => _PinInputFieldState();
}

class _PinInputFieldState extends State<PinInputField> {
  List<TextEditingController> controllers = [];
  List<FocusNode> focusNodes = [];
  String? errorText; // Store validation error message

  @override
  void initState() {
    super.initState();
    controllers =
        List.generate(widget.length, (index) => TextEditingController());
    focusNodes = List.generate(widget.length, (index) => FocusNode());

    for (int i = 0; i < widget.length; i++) {
      controllers[i].addListener(() {
        if (mounted) {
          setState(() {}); // Rebuild UI when text changes
        }
      });
      focusNodes[i].addListener(() {
        if (mounted) {
          setState(() {}); // Rebuild UI when focus changes
        }
      });
    }
  }

  void _onTextChanged(String value, int index) {
    if (value.isNotEmpty && !RegExp(r'^[0-9]$').hasMatch(value)) {
      controllers[index].clear(); // Clear invalid input
      setState(() {
        errorText = "Only numbers are allowed";
      });
      return;
    }

    // Move focus only if a valid digit is entered
    if (value.isNotEmpty && index < widget.length - 1) {
      FocusScope.of(context).requestFocus(focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(focusNodes[index - 1]);
    }

    String pin = _getCode();
    widget.onChanged(pin);

    // Validate input dynamically
    if (pin.length == widget.length) {
      String? validationMessage = widget.validator?.call(pin);
      setState(() {
        errorText = validationMessage;
      });

      if (validationMessage == null) {
        widget.onCompleted?.call(pin);
      } else {
        // Clear all fields if PIN is invalid
        for (var controller in controllers) {
          controller.clear();
        }
        FocusScope.of(context).requestFocus(focusNodes[0]); // Reset focus
      }
    }
  }

  String _getCode() {
    return controllers.map((e) => e.text).join();
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(widget.length, (index) {
            bool hasText = controllers[index].text.isNotEmpty;
            bool isFocused = focusNodes[index].hasFocus;

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: (hasText || isFocused)
                    ? ColorConstant.primaryLightColor.withOpacity(0.3)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Center(
                child: TextField(
                  controller: controllers[index],
                  focusNode: focusNodes[index],
                  textAlign: TextAlign.center,
                  maxLength: 1,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                    counterText: "",
                    border: InputBorder.none,
                  ),
                  onChanged: (value) => _onTextChanged(value, index),
                ),
              ),
            );
          }),
        ),
        if (errorText != null) // Show validation message if it exists
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              errorText!,
              style: const TextStyle(color: Colors.red, fontSize: 14),
            ),
          ),
      ],
    );
  }
}
