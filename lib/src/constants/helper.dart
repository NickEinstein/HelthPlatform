import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/constants/color_constant.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hint;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.hint,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _hasText = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            widget.label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xff3C3B3B),
            ),
          ),
        ),
        // Custom TextField with Dynamic Background
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: const TextStyle(
              color: Color(0xffB3B3B3),
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: const BorderSide(
                color: Color(0xffB3B3B3),
                width: 0.8, // Tiny green border
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: const BorderSide(
                color: Color(0xffB3B3B3),
                width: 0.8, // Thicker when focused
              ),
            ),
            filled: true, // Enable background color
            fillColor: _hasText
                ? ColorConstant.primaryLightColor.withOpacity(0.3)
                : Colors.transparent, // Background color
          ),
        ),
      ],
    );
  }
}

class CustomLongTextField extends StatefulWidget {
  final String label;
  final String hint;

  const CustomLongTextField({
    Key? key,
    required this.label,
    required this.hint,
  }) : super(key: key);

  @override
  State<CustomLongTextField> createState() => _CustomLongTextFieldState();
}

class _CustomLongTextFieldState extends State<CustomLongTextField> {
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _hasText = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            widget.label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xff3C3B3B),
            ),
          ),
        ),
        // Custom TextField with Dynamic Background
        TextField(
          controller: _controller,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: const TextStyle(
              color: Color(0xffB3B3B3),
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: const BorderSide(
                color: Color(0xffB3B3B3),
                width: 0.8, // Tiny green border
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: const BorderSide(
                color: Color(0xffB3B3B3),
                width: 0.8, // Thicker when focused
              ),
            ),
            filled: true, // Enable background color
            fillColor: _hasText
                ? ColorConstant.primaryLightColor.withOpacity(0.3)
                : Colors.transparent, // Background color
          ),
        ),
      ],
    );
  }
}

class CustomDropdown extends StatefulWidget {
  final String label;
  final List<String> options;
  final String hint;
  final ValueChanged<String?>? onChanged;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.options,
    this.hint = "Select an option",
    this.onChanged,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Persistent label
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            widget.label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xff3C3B3B),
            ),
          ),
        ),
        // Dropdown field with dynamic background
        DropdownButtonFormField<String>(
          value: _selectedValue,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 18,
          ),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: const TextStyle(
              color: Color(0xffB3B3B3),
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            isDense: true, // Keeps field compact
            alignLabelWithHint: true, // Aligns hint correctly
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 16,
            ), // Ensures correct padding
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: const BorderSide(
                color: Color(0xffB3B3B3),
                width: 0.8,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: const BorderSide(
                color: Color(0xffB3B3B3),
                width: 0.8,
              ),
            ),
            filled: true, // Enables background color
            fillColor: _selectedValue != null
                ? ColorConstant.primaryLightColor.withOpacity(0.3)
                : Colors.transparent, // Background color change
          ),
          items: widget.options
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              _selectedValue = value;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
        ),
      ],
    );
  }
}

class PasswordTextField extends StatefulWidget {
  final String label;
  final Function(String) onChanged;

  const PasswordTextField({
    Key? key,
    required this.label,
    required this.onChanged,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _isObscured = true;
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;

  final RegExp _uppercase = RegExp(r'[A-Z]');
  final RegExp _lowercase = RegExp(r'[a-z]');
  final RegExp _number = RegExp(r'[0-9]');
  final RegExp _specialChar = RegExp(r'[!@#\$&*~]');

  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasNumber = false;
  bool hasSpecialChar = false;

  void _validatePassword(String value) {
    setState(() {
      _hasText = value.isNotEmpty; // Check if text field has input
      hasUppercase = _uppercase.hasMatch(value);
      hasLowercase = _lowercase.hasMatch(value);
      hasNumber = _number.hasMatch(value);
      hasSpecialChar = _specialChar.hasMatch(value);
    });

    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            widget.label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xff3C3B3B),
            ),
          ),
        ),
        TextField(
          controller: _controller,
          obscureText: _isObscured,
          onChanged: _validatePassword,
          decoration: InputDecoration(
            filled: true,
            fillColor: _hasText
                ? ColorConstant.primaryLightColor.withOpacity(0.3)
                : Colors.white, // Background color changes
            hintText: "Enter Password",
            hintStyle: const TextStyle(
              color: Color(0xffB3B3B3),
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide:
                  const BorderSide(color: Color(0xffB3B3B3), width: 0.8),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide:
                  const BorderSide(color: Color(0xffB3B3B3), width: 0.8),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _isObscured ? Icons.visibility_off : Icons.visibility,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  _isObscured = !_isObscured;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        _buildValidationItem("Password must contain Uppercase", hasUppercase),
        _buildValidationItem("Password must contain lowercase", hasLowercase),
        _buildValidationItem("Password must contain a number", hasNumber),
        _buildValidationItem(
            "Password must contain special character !@#\$&*~", hasSpecialChar),
      ],
    );
  }

  Widget _buildValidationItem(String text, bool isValid) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          Icon(
            isValid ? Icons.check_box : Icons.check_box_outline_blank,
            color: isValid ? Colors.green : Colors.grey,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isValid ? Colors.green : Color(0xff3C3B3B),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ConfirmPasswordTextField extends StatefulWidget {
  final String label;
  final String password;

  const ConfirmPasswordTextField({
    Key? key,
    required this.label,
    required this.password,
  }) : super(key: key);

  @override
  _ConfirmPasswordTextFieldState createState() =>
      _ConfirmPasswordTextFieldState();
}

class _ConfirmPasswordTextFieldState extends State<ConfirmPasswordTextField> {
  bool _isObscured = true;
  final TextEditingController _controller = TextEditingController();
  bool isMatching = false;
  bool hasText = false;

  void _checkMatch(String value) {
    setState(() {
      isMatching = value == widget.password;
      hasText = value.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xff3C3B3B), // Adjust label color
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _controller,
          obscureText: _isObscured,
          onChanged: _checkMatch,
          decoration: InputDecoration(
            hintText: 'Enter Confirm password',
            hintStyle: TextStyle(
              color: ColorConstant.primaryLightColor.withOpacity(0.3),
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            filled: true,
            fillColor: hasText
                ? ColorConstant.primaryLightColor.withOpacity(0.3)
                : Colors.transparent,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide:
                  const BorderSide(color: Color(0xffB3B3B3), width: 0.8),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide:
                  const BorderSide(color: Color(0xffB3B3B3), width: 0.8),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _isObscured ? Icons.visibility_off : Icons.visibility,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  _isObscured = !_isObscured;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Icon(
              isMatching ? Icons.check_box : Icons.check_box_outline_blank,
              color: isMatching ? Colors.green : Colors.grey,
            ),
            const SizedBox(width: 8),
            Text(
              "Passwords match",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isMatching ? Colors.green : const Color(0xff3C3B3B),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class LoginPasswordTextField extends StatefulWidget {
  final String label;
  final String password;

  const LoginPasswordTextField({
    Key? key,
    required this.label,
    required this.password,
  }) : super(key: key);

  @override
  _LoginPasswordTextFieldState createState() => _LoginPasswordTextFieldState();
}

class _LoginPasswordTextFieldState extends State<LoginPasswordTextField> {
  bool _isObscured = true;
  final TextEditingController _controller = TextEditingController();
  bool hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        hasText = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xff3C3B3B), // Adjust label color
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _controller,
          obscureText: _isObscured,
          decoration: InputDecoration(
            filled: true,
            fillColor: hasText
                ? ColorConstant.primaryLightColor.withOpacity(0.3)
                : Colors.transparent,
            hintText: 'Enter password',
            hintStyle: const TextStyle(
              color: Color(0xffB3B3B3),
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: const BorderSide(
                color: Color(0xffB3B3B3),
                width: 0.8,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: const BorderSide(
                color: Color(0xffB3B3B3),
                width: 0.8,
              ),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            suffixIcon: IconButton(
              icon: Icon(
                _isObscured ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  _isObscured = !_isObscured;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class DateOfBirthField extends StatefulWidget {
  final String label;
  const DateOfBirthField({super.key, required this.label});

  @override
  State<DateOfBirthField> createState() => _DateOfBirthFieldState();
}

class _DateOfBirthFieldState extends State<DateOfBirthField> {
  final TextEditingController _controller = TextEditingController();
  bool _hasDate = false; // Track if a date is selected

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _controller.text = "${picked.month}/${picked.day}/${picked.year}";
        _hasDate = true; // Update background color condition
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Persistent label
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            widget.label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xff3C3B3B),
            ),
          ),
        ),
        // TextField with date picker
        TextField(
          controller: _controller,
          readOnly: true, // Prevent manual input
          onTap: () => _selectDate(context),
          decoration: InputDecoration(
            hintText: "mm/dd/yy",
            hintStyle: const TextStyle(
              color: Color(0xffB3B3B3),
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            suffixIcon: IconButton(
              icon: const Icon(Icons.calendar_month_outlined,
                  color: Colors.black),
              onPressed: () => _selectDate(context),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: const BorderSide(
                color: Color(0xffB3B3B3),
                width: 0.8,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: const BorderSide(
                color: Color(0xffB3B3B3),
                width: 0.8,
              ),
            ),
            filled: true, // Enables background color
            fillColor: _hasDate
                ? ColorConstant.primaryLightColor.withOpacity(0.3)
                : Colors.transparent, // Background color change
          ),
        ),
      ],
    );
  }
}
