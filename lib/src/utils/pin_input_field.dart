import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/constants/color_constant.dart';

class PinInputField extends StatefulWidget {
  final int length;
  final Function(String) onChanged;

  const PinInputField({
    Key? key,
    this.length = 4,
    required this.onChanged,
  }) : super(key: key);

  @override
  _PinInputFieldState createState() => _PinInputFieldState();
}

class _PinInputFieldState extends State<PinInputField> {
  List<TextEditingController> controllers = [];
  List<FocusNode> focusNodes = [];

  @override
  void initState() {
    super.initState();
    controllers =
        List.generate(widget.length, (index) => TextEditingController());
    focusNodes = List.generate(widget.length, (index) => FocusNode());

    for (int i = 0; i < widget.length; i++) {
      controllers[i].addListener(() {
        if (mounted) {
          setState(() {}); // Rebuild UI to reflect changes
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
    if (value.isNotEmpty && index < widget.length - 1) {
      FocusScope.of(context).requestFocus(focusNodes[index + 1]);
    }
    widget.onChanged(_getCode());
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
    return Row(
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
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                counterText: "",
                border: InputBorder.none,
              ),
              onChanged: (value) => _onTextChanged(value, index),
            ),
          ),
        );
      }),
    );
  }
}
