import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:greenzone_medical/src/constants/color_constant.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final bool obscureText; // Added for password fields
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.hint,
    this.controller,
    this.validator,
    this.onChanged,
    this.obscureText = false, // Default to false
    this.inputFormatters,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;
  bool _hasText = false;
  String? _errorText;
  bool _isInternalController = false; // Track ownership

  @override
  void initState() {
    super.initState();
    // Use provided controller or create one internally
    if (widget.controller != null) {
      _controller = widget.controller!;
    } else {
      _controller = TextEditingController();
      _isInternalController = true; // Mark internal controller
    }

    _controller.addListener(() {
      final text = _controller.text;
      if (mounted) {
        setState(() {
          _hasText = text.isNotEmpty;
        });
      }
      widget.onChanged?.call(text);
    });
  }

  void _validate() {
    setState(() {
      _errorText = widget.validator?.call(_controller.text);
    });
  }

  @override
  void dispose() {
    if (_isInternalController) {
      _controller.dispose(); // Dispose only if created internally
    }
    super.dispose();
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
        TextFormField(
          controller: _controller,
          obscureText: widget.obscureText,
          validator: widget.validator,
          inputFormatters: widget.inputFormatters,
          onChanged: (value) => setState(() {
            _hasText = value.isNotEmpty;
          }),
          onFieldSubmitted: (_) => _validate(),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: const TextStyle(
              color: Color(0xffB3B3B3),
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
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
                width: 1.2,
              ),
            ),
            filled: true,
            fillColor: _hasText
                ? ColorConstant.primaryLightColor.withOpacity(0.3)
                : Colors.transparent,
            errorText: _errorText,
          ),
        ),
      ],
    );
  }
}

class CustomLongTextField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController? controller; // External controller

  const CustomLongTextField({
    Key? key,
    required this.label,
    required this.hint,
    this.controller, // Optional controller parameter
  }) : super(key: key);

  @override
  State<CustomLongTextField> createState() => _CustomLongTextFieldState();
}

class _CustomLongTextFieldState extends State<CustomLongTextField> {
  late TextEditingController _controller;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    // Use the provided controller, or create a new one if it's not provided
    _controller = widget.controller ?? TextEditingController();

    _controller.addListener(() {
      setState(() {
        _hasText = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    // Dispose only if the controller is local (not passed from outside)
    if (widget.controller == null) {
      _controller.dispose();
    }
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
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String? value;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.options,
    this.hint = "Select an option",
    this.onChanged,
    this.validator,
    this.controller,
    this.value,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _setInitialValue();
  }

  void _setInitialValue() {
    if (widget.value != null && widget.value!.isNotEmpty) {
      if (widget.options.contains(widget.value)) {
        _selectedValue = widget.value;
      } else {
        _selectedValue = null;
      }
    } else if (widget.controller != null &&
        widget.controller!.text.isNotEmpty) {
      if (widget.options.contains(widget.controller!.text)) {
        _selectedValue = widget.controller!.text;
      } else {
        _selectedValue = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> uniqueOptions = widget.options.toSet().toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        DropdownSearch<String>(
          selectedItem: _selectedValue,
          popupProps: PopupProps.menu(
            showSearchBox: true,
            searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                hintText: "Search...",
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          items: uniqueOptions,
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              hintText: widget.hint,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3),
                borderSide:
                    const BorderSide(color: Color(0xffB3B3B3), width: 0.8),
              ),
              filled: true,
              fillColor: _selectedValue != null
                  ? ColorConstant.primaryLightColor.withOpacity(0.3)
                  : Colors.transparent,
            ),
          ),
          onChanged: (value) {
            setState(() {
              _selectedValue = value;
            });
            if (widget.controller != null) {
              widget.controller!.text = value ?? '';
            }
            widget.onChanged?.call(value);
          },
          validator: widget.validator ??
              (value) {
                if (value == null || value.isEmpty) {
                  return "Please select an option";
                }
                return null;
              },
        ),
      ],
    );
  }
}

class NoSearchDropdown extends StatefulWidget {
  final String label;
  final List<String> options;
  final String hint;
  final ValueChanged<String?>? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String? value;

  const NoSearchDropdown({
    Key? key,
    required this.label,
    required this.options,
    this.hint = "Select an option",
    this.onChanged,
    this.validator,
    this.controller,
    this.value,
  }) : super(key: key);

  @override
  State<NoSearchDropdown> createState() => _NoSearchDropdownState();
}

class _NoSearchDropdownState extends State<NoSearchDropdown> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _setInitialValue();
  }

  void _setInitialValue() {
    if (widget.value != null && widget.value!.isNotEmpty) {
      if (widget.options.contains(widget.value)) {
        _selectedValue = widget.value;
      } else {
        _selectedValue = null;
      }
    } else if (widget.controller != null &&
        widget.controller!.text.isNotEmpty) {
      if (widget.options.contains(widget.controller!.text)) {
        _selectedValue = widget.controller!.text;
      } else {
        _selectedValue = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> uniqueOptions = widget.options.toSet().toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xff3C3B3B),
          ),
        ),
        const SizedBox(height: 4),
        DropdownSearch<String>(
          selectedItem: _selectedValue,
          popupProps: const PopupProps.menu(
            showSearchBox: false,
            fit: FlexFit.loose,
            constraints: BoxConstraints(maxHeight: 200),
          ),
          items: uniqueOptions,
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              hintText: widget.hint,
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3),
                borderSide:
                    const BorderSide(color: Color(0xffB3B3B3), width: 0.8),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          onChanged: (value) {
            setState(() {
              _selectedValue = value;
            });
            if (widget.controller != null) {
              widget.controller!.text = value ?? '';
            }
            widget.onChanged?.call(value);
          },
          validator: widget.validator ??
              (value) {
                if (value == null || value.isEmpty) {
                  return "Please select an option";
                }
                return null;
              },
        ),
      ],
    );
  }
}

class PasswordTextField extends StatefulWidget {
  final String label;
  final Function(String) onChanged;
  final TextEditingController? controller;

  const PasswordTextField({
    Key? key,
    required this.label,
    required this.onChanged,
    this.controller,
  }) : super(key: key);

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _isObscured = true;
  late TextEditingController _controller;

  final RegExp _uppercase = RegExp(r'[A-Z]');
  final RegExp _lowercase = RegExp(r'[a-z]');
  final RegExp _number = RegExp(r'[0-9]');
  final RegExp _specialChar = RegExp(r'[!@#\$&*~]');

  late ValueNotifier<bool> hasUppercase;
  late ValueNotifier<bool> hasLowercase;
  late ValueNotifier<bool> hasNumber;
  late ValueNotifier<bool> hasSpecialChar;
  late ValueNotifier<bool> hasText;
  late ValueNotifier<bool> hasMinLength;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();

    hasUppercase = ValueNotifier(false);
    hasLowercase = ValueNotifier(false);
    hasNumber = ValueNotifier(false);
    hasSpecialChar = ValueNotifier(false);
    hasText = ValueNotifier(false);
    hasMinLength = ValueNotifier(false);

    _controller.addListener(() => _validatePassword(_controller.text));
  }

  void _validatePassword(String value) {
    hasText.value = value.isNotEmpty;
    hasUppercase.value = _uppercase.hasMatch(value);
    hasLowercase.value = _lowercase.hasMatch(value);
    hasNumber.value = _number.hasMatch(value);
    hasSpecialChar.value = _specialChar.hasMatch(value);
    hasMinLength.value = value.length >= 8;

    widget.onChanged(value);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    hasUppercase.dispose();
    hasLowercase.dispose();
    hasNumber.dispose();
    hasSpecialChar.dispose();
    hasText.dispose();
    hasMinLength.dispose();
    super.dispose();
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
            fillColor: hasText.value
                ? ColorConstant.primaryLightColor.withOpacity(0.3)
                : Colors.white,
            hintText: "Enter Password",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
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
        _buildValidationItem(
            "Password must be at least 8 characters", hasMinLength),
        _buildValidationItem("Password must contain Uppercase", hasUppercase),
        _buildValidationItem("Password must contain Lowercase", hasLowercase),
        _buildValidationItem("Password must contain a Number", hasNumber),
        _buildValidationItem(
          "Password must contain a Special Character (!@#\$&*~)",
          hasSpecialChar,
        ),
      ],
    );
  }

  Widget _buildValidationItem(String text, ValueNotifier<bool> isValid) {
    return ValueListenableBuilder<bool>(
      valueListenable: isValid,
      builder: (context, valid, child) {
        return Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            children: [
              Icon(valid ? Icons.check_circle : Icons.cancel,
                  color: valid ? Colors.green : Colors.red),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: valid ? Colors.green : Colors.red,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ConfirmPasswordTextField extends StatefulWidget {
  final String label;
  final String password;
  final Function(bool) onMatchChanged;
  final TextEditingController? controller;

  const ConfirmPasswordTextField({
    Key? key,
    required this.label,
    required this.password,
    required this.onMatchChanged,
    this.controller,
  }) : super(key: key);

  @override
  _ConfirmPasswordTextFieldState createState() =>
      _ConfirmPasswordTextFieldState();
}

class _ConfirmPasswordTextFieldState extends State<ConfirmPasswordTextField> {
  late TextEditingController _controller;
  bool _isObscured = true;
  bool isMatching = false;
  bool hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(() => _checkMatch(_controller.text));
  }

  @override
  void didUpdateWidget(covariant ConfirmPasswordTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.password != widget.password) {
      _checkMatch(_controller.text);
    }
  }

  void _checkMatch(String value) {
    bool match = value == widget.password;

    if (match != isMatching) {
      setState(() {
        isMatching = match;
        hasText = value.isNotEmpty;
      });
    }
    widget.onMatchChanged(isMatching);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
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
            color: Color(0xff3C3B3B),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _controller,
          obscureText: _isObscured,
          decoration: InputDecoration(
            hintText: 'Enter Confirm password',
            hintStyle: const TextStyle(
              color: Color(0xffB3B3B3),
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
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
              isMatching ? Icons.check_circle : Icons.cancel,
              color: isMatching ? Colors.green : Colors.red,
            ),
            const SizedBox(width: 8),
            Text(
              isMatching ? "Passwords match" : "Passwords do not match",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isMatching ? Colors.green : Colors.red,
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
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged; // Add onChanged
  final FocusNode? focusNode; // Add focusNode to control focus

  const LoginPasswordTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.validator,
    this.onChanged,
    this.focusNode, // Accept focusNode
  }) : super(key: key);

  @override
  _LoginPasswordTextFieldState createState() => _LoginPasswordTextFieldState();
}

class _LoginPasswordTextFieldState extends State<LoginPasswordTextField> {
  bool _isObscured = true;

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
            color: Color(0xff3C3B3B),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode, // Add focusNode here
          obscureText: _isObscured,
          validator: widget.validator,
          onChanged: widget.onChanged, // Call the parent's onChanged
          decoration: InputDecoration(
            filled: true,
            fillColor: widget.controller.text.isNotEmpty
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
  final TextEditingController controller; // Pass controller for validation

  const DateOfBirthField({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  State<DateOfBirthField> createState() => _DateOfBirthFieldState();
}

class _DateOfBirthFieldState extends State<DateOfBirthField> {
  bool _hasDate = false;

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      // Convert the picked date to UTC and format it as YYYY-MM-DD
      String formattedDate =
          "${picked.toUtc().year.toString().padLeft(4, '0')}-${picked.toUtc().month.toString().padLeft(2, '0')}-${picked.toUtc().day.toString().padLeft(2, '0')}";

      setState(() {
        widget.controller.text = formattedDate; // Only date, no time
        _hasDate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        TextFormField(
          controller: widget.controller,
          readOnly: true,
          onTap: () => _selectDate(context),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select your date of birth';
            }
            return null;
          },
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
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: const BorderSide(
                color: Color(0xffB3B3B3),
                width: 0.8,
              ),
            ),
            filled: true,
            fillColor: _hasDate
                ? ColorConstant.primaryLightColor.withOpacity(0.3)
                : Colors.transparent,
          ),
        ),
      ],
    );
  }
}

String maskEmail(String email) {
  final parts = email.split('@');
  if (parts.length != 2) return email; // Return original if format is incorrect

  final username = parts[0];
  final domain = parts[1];

  String maskedUsername = username.length > 4
      ? '${username.substring(0, 4)}****'
      : '${username[0]}****';

  return '$maskedUsername@$domain';
}

String timeAgos(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inMinutes < 1) return "Just now";
  if (difference.inHours < 1) return "${difference.inMinutes}m ago";
  if (difference.inDays < 1) return "${difference.inHours}h ago";
  return "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}";
}

String timeAgo(String? createdAt, String title) {
  if (createdAt == null || createdAt.isEmpty)
    return "Creation date unavailable";

  try {
    DateTime createdDate = DateTime.parse(createdAt).toLocal();
    final now = DateTime.now();
    final difference = now.difference(createdDate);

    if (difference.inDays >= 7) {
      int weeks = (difference.inDays / 7).floor();
      return "${title} about $weeks ${weeks == 1 ? 'week' : 'weeks'} ago";
    } else if (difference.inDays > 0) {
      return "${title} about ${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago";
    } else if (difference.inHours > 0) {
      return "${title} about ${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago";
    } else {
      return "${title} just now";
    }
  } catch (e) {
    return "Invalid date format";
  }
}

String getGreeting() {
  final hour = DateTime.now().hour;

  if (hour >= 5 && hour < 12) {
    return "Good morning! ";
  } else if (hour >= 12 && hour < 18) {
    return "Good afternoon! ";
  } else {
    return "Good evening! ";
  }
}

bool canProceed(String password, String confirmPassword) {
  final hasMinLength = password.length >= 8;
  final hasUppercase = password.contains(RegExp(r'[A-Z]'));
  final hasLowercase = password.contains(RegExp(r'[a-z]'));
  final hasDigit = password.contains(RegExp(r'\d'));
  final hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

  if (password.isEmpty || confirmPassword.isEmpty) {
    return false;
  }

  if (!hasMinLength ||
      !hasUppercase ||
      !hasLowercase ||
      !hasDigit ||
      !hasSpecialChar) {
    return false;
  }

  if (password != confirmPassword) {
    return false;
  }

  return true;
}

String formatDate(String dateTimeStr) {
  try {
    DateTime dateTime = DateTime.parse(dateTimeStr);
    String formattedDate =
        DateFormat('MMM dd, yyyy').format(dateTime); // e.g., Mar 26, 2025
    return "$formattedDate • ";
  } catch (e) {
    return "Invalid date";
  }
}

String formatTimeAgo(String dateTimeStr) {
  try {
    DateTime dateTime = DateTime.parse(dateTimeStr);
    Duration diff = DateTime.now().difference(dateTime);

    if (diff.inSeconds < 60) {
      return 'Just now';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes} minute${diff.inMinutes == 1 ? '' : 's'} ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} day${diff.inDays == 1 ? '' : 's'} ago';
    } else if (diff.inDays < 30) {
      int weeks = (diff.inDays / 7).floor();
      return '$weeks week${weeks == 1 ? '' : 's'} ago';
    } else if (diff.inDays < 365) {
      int months = (diff.inDays / 30).floor();
      return '$months month${months == 1 ? '' : 's'} ago';
    } else {
      int years = (diff.inDays / 365).floor();
      return '$years year${years == 1 ? '' : 's'} ago';
    }
  } catch (e) {
    return "Invalid date";
  }
}

Widget buildTab(
  String label,
  bool isSelected,
  int index,
  VoidCallback onTap,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.green : Colors.grey[800],
            ),
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 4),
              height: 2,
              width: label.length * 10.0,
              color: Colors.green,
            ),
        ],
      ),
    ),
  );
}

String formatNewDate(String dateString) {
  try {
    // Parse the input date string
    final DateTime dateTime = DateTime.parse(dateString);

    // Format the date into the desired format
    final String formattedDate = DateFormat('MMMM dd, yyyy').format(dateTime);

    return formattedDate;
  } catch (e) {
    // Handle any parsing errors
    return 'Invalid Date';
  }
}

Future<List<String>?> openCategoryFilterDialog(
  List<String> categories,
  BuildContext context,
) {
  // Clear selected categories before opening the dialog
  List<String> tempSelectedCategories = [];

  return showModalBottomSheet<List<String>>(
    context: context,
    isScrollControlled: true, // 🛑 Allow scrollable content
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Categories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ...categories.map((cat) => StatefulBuilder(
                    builder: (context, setState) {
                      final isSelected = tempSelectedCategories.contains(cat);
                      return CheckboxListTile(
                        title: Text(cat),
                        value: isSelected,
                        activeColor: ColorConstant.primaryColor,
                        onChanged: (bool? selected) {
                          setState(() {
                            if (selected == true) {
                              tempSelectedCategories.add(cat);
                            } else {
                              tempSelectedCategories.remove(cat);
                            }
                          });
                        },
                      );
                    },
                  )),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      ColorConstant.primaryColor, // Muted green when disabled
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: const Color(
                      0xffA8D5BA), // Ensure disabled color is applied
                  disabledForegroundColor: Colors.white
                      .withOpacity(0.6), // Lightened text for disabled state
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context, tempSelectedCategories);
                },
                child: const Text('Done'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );
    },
  );
}

String formatWeekDate(String dateString) {
  final dateTime = DateTime.parse(dateString);
  final dayOfWeek =
      DateFormat('EEEE').format(dateTime); // Day of the week (e.g. Monday)
  final time = DateFormat('hh:mm a').format(dateTime); // Time (e.g. 02:35 PM)

  return "$dayOfWeek $time";
}

void openMapWithAddress(String address) async {
  final query = Uri.encodeComponent(address);
  final googleMapsUrl =
      'https://www.google.com/maps/search/?api=1&query=$query';

  if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
    await launchUrl(Uri.parse(googleMapsUrl),
        mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not open the map.';
  }
}

String convertTo24HourManual(String time12h) {
  // Normalize spaces (in case of non-breaking spaces or extra whitespace)
  time12h = time12h.replaceAll(RegExp(r'\s+'), ' ').trim();

  final parts = time12h.split(' ');
  if (parts.length != 2) return time12h; // return original if format unexpected

  final timePart = parts[0]; // e.g. "2:00"
  final period = parts[1].toUpperCase(); // "AM" or "PM"

  final timeSplit = timePart.split(':');
  int hour = int.parse(timeSplit[0]);
  final minute = timeSplit.length > 1 ? int.parse(timeSplit[1]) : 0;

  if (period == 'PM' && hour != 12) {
    hour += 12;
  } else if (period == 'AM' && hour == 12) {
    hour = 0;
  }

  // Pad with leading zeros
  final hourStr = hour.toString().padLeft(2, '0');
  final minuteStr = minute.toString().padLeft(2, '0');

  return '$hourStr:$minuteStr'; // e.g., "14:00"
}

String formatPostDate(String? rawDate) {
  if (rawDate == null) return '';
  final date = DateTime.tryParse(rawDate);
  if (date == null) return '';

  final now = DateTime.now();
  final difference = now.difference(date);

  if (difference.inSeconds < 60) {
    return '${difference.inSeconds}s ago';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes}m ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours}h ago';
  } else if (difference.inDays < 7) {
    return '${difference.inDays}d ago';
  } else if (difference.inDays < 30) {
    final weeks = (difference.inDays / 7).floor();
    return '${weeks}w ago';
  } else if (difference.inDays < 365) {
    final months = (difference.inDays / 30).floor();
    return '${months}mo ago';
  } else {
    final years = (difference.inDays / 365).floor();
    return '${years}y ago';
  }
}

Color getAvatarColor(String name) {
  final colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.teal,
    Colors.orange,
    Colors.brown,
    Colors.cyan,
    Colors.indigo,
    Colors.pink,
  ];
  final hash = name.hashCode;
  final index = hash % colors.length;
  return colors[index];
}

Future<void> requestPermissions() async {
  await Permission.microphone.request();
  await Permission.camera.request();
}

String stripHtmlTags(String htmlText) {
  return htmlText.replaceAll(RegExp(r'<[^>]*>'), '');
}
