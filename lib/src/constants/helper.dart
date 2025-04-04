import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/constants/color_constant.dart';
import 'package:dropdown_search/dropdown_search.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final bool obscureText; // Added for password fields

  const CustomTextField({
    Key? key,
    required this.label,
    required this.hint,
    this.controller,
    this.validator,
    this.onChanged,
    this.obscureText = false, // Default to false
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

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();

    hasUppercase = ValueNotifier(false);
    hasLowercase = ValueNotifier(false);
    hasNumber = ValueNotifier(false);
    hasSpecialChar = ValueNotifier(false);
    hasText = ValueNotifier(false);

    _controller.addListener(() => _validatePassword(_controller.text));
  }

  void _validatePassword(String value) {
    hasText.value = value.isNotEmpty;
    hasUppercase.value = _uppercase.hasMatch(value);
    hasLowercase.value = _lowercase.hasMatch(value);
    hasNumber.value = _number.hasMatch(value);
    hasSpecialChar.value = _specialChar.hasMatch(value);

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
        _buildValidationItem("Password must contain Uppercase", hasUppercase),
        _buildValidationItem("Password must contain Lowercase", hasLowercase),
        _buildValidationItem("Password must contain a Number", hasNumber),
        _buildValidationItem(
            "Password must contain a Special Character (!@#\$&*~)",
            hasSpecialChar),
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
                      color: valid ? Colors.green : Colors.red),
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

String timeAgo(String? createdAt) {
  if (createdAt == null || createdAt.isEmpty)
    return "Creation date unavailable";

  try {
    DateTime createdDate = DateTime.parse(createdAt).toLocal();
    final now = DateTime.now();
    final difference = now.difference(createdDate);

    if (difference.inDays >= 7) {
      int weeks = (difference.inDays / 7).floor();
      return "Created about $weeks ${weeks == 1 ? 'week' : 'weeks'} ago";
    } else if (difference.inDays > 0) {
      return "Created about ${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago";
    } else if (difference.inHours > 0) {
      return "Created about ${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago";
    } else {
      return "Created just now";
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
