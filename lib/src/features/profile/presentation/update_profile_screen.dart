import 'package:csc_picker_plus/csc_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/constants/helper.dart';
import 'package:greenzone_medical/src/features/profile/model/update_patient_payload.dart';
import 'package:greenzone_medical/src/features/profile/widget/show_gender_dialog.dart';
import 'package:greenzone_medical/src/provider/profile_provider.dart';
import 'package:greenzone_medical/src/utils/extensions/primary_button.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';
import 'package:intl/intl.dart';

class UpdateProfileScreen extends ConsumerStatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  ConsumerState<UpdateProfileScreen> createState() =>
      _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends ConsumerState<UpdateProfileScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _genderController;
  late TextEditingController _dobController;
  late TextEditingController _nationalityController;
  late TextEditingController _stateOriginController;
  late TextEditingController _lgaController;
  late TextEditingController _placeOfBirthController;
  late TextEditingController _maritalStatusController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _genderController = TextEditingController();
    _dobController = TextEditingController();
    _nationalityController = TextEditingController();
    _stateOriginController = TextEditingController();
    _lgaController = TextEditingController();
    _placeOfBirthController = TextEditingController();
    _maritalStatusController = TextEditingController();

    // Pre-fill data if available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = ref.read(profileProvider);
      final profile = state.patientProfile?.data;
      if (profile != null) {
        _firstNameController.text = profile.firstName ?? '';
        _lastNameController.text = profile.lastName ?? '';
        _genderController.text = profile.gender ?? '';
        _dobController.text = profile.dateOfBirth != null
            ? DateFormat('yyyy-MM-dd').format(profile.dateOfBirth!)
            : '';
        _nationalityController.text = profile.nationality ?? '';
        _stateOriginController.text = profile.stateOfOrigin ?? '';
        _lgaController.text = profile.lga ?? '';
        _placeOfBirthController.text = profile.placeOfBirth ?? '';
        _maritalStatusController.text = profile.maritalStatus ?? '';
      }
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _genderController.dispose();
    _dobController.dispose();
    _nationalityController.dispose();
    _stateOriginController.dispose();
    _lgaController.dispose();
    _placeOfBirthController.dispose();
    _maritalStatusController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    // Basic validation could be added here
    final payload = UpdatePatientPayload(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      gender: _genderController.text,
      dateOfBirth: _dobController.text,
      nationality: _nationalityController.text,
      stateOfOrigin: _stateOriginController.text,
      lga: _lgaController.text,
      placeOfBirth: _placeOfBirthController.text,
      maritalStatus: _maritalStatusController.text,
      // Default or existing values for fields not shown in this specific screen part
      weight: int.tryParse(ref
                  .read(profileProvider)
                  .patientProfile
                  ?.data
                  ?.weight
                  ?.toString() ??
              '') ??
          0,
      pictureUrl:
          ref.read(profileProvider).patientProfile?.data?.pictureUrl ?? '',
      nin: ref.read(profileProvider).patientProfile?.data?.nin ?? '',
      phoneNumber:
          ref.read(profileProvider).patientProfile?.data?.phoneNumber ?? '',
    );

    final success =
        await ref.read(profileProvider.notifier).updateProfile(payload);
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
      // Navigate or stick based on flow. "Contact Details ->" suggests next screen.
      // For now, staying on page or going back is safer unless next route is known.
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update profile')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(profileProvider).isLoading;
    // Mock user image or use network image
    final profilePic =
        ref.watch(profileProvider).patientProfile?.data?.pictureUrl;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Personal Details',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade200,
              backgroundImage: profilePic != null && profilePic.isNotEmpty
                  ? NetworkImage(profilePic)
                  : null,
              child: profilePic == null || profilePic.isEmpty
                  ? const Icon(Icons.person, color: Colors.grey)
                  : null,
            ),
          )
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            // Navigate to Contact Details if route known
                            _submit();
                          },
                          child: const Row(
                            children: [
                              Text('Contact Details',
                                  style: TextStyle(color: Colors.black)),
                              Icon(Icons.arrow_forward,
                                  size: 16, color: Colors.black),
                            ],
                          ))
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(
                          0xFFE8EAF6), // Light indigo/purple from image
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.5),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(Icons.badge_outlined,
                              color: Colors.indigo), // Icon from image
                        ),
                        12.width,
                        const Text('Personal Data',
                            style: TextStyle(fontSize: 14)),
                        const Spacer(),
                        const Icon(Icons.keyboard_arrow_down,
                            color: Colors.indigo),
                      ],
                    ),
                  ),
                  20.height,
                  CustomTextField(
                    label: 'Firstname',
                    hint: '',
                    controller: _firstNameController,
                  ),
                  12.height,
                  CustomTextField(
                    label: 'Lastname',
                    hint: '',
                    controller: _lastNameController,
                  ),
                  12.height,
                  // Assuming Gender is a dropdown or text. Image shows text field style.
                  CustomTextField(
                    label: 'Gender',
                    hint: '',
                    controller: _genderController,
                    readOnly: true,
                    onTap: () async {
                      final gender = await showGenderDialog(context);
                      if (gender != null) {
                        setState(() {
                          _genderController.text = gender;
                        });
                      }
                    },
                  ),
                  12.height,
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                      child: CustomTextField(
                        label: 'Date of Birth',
                        hint: '',
                        controller: _dobController,
                      ),
                    ),
                  ),
                  12.height,
                  CSCPickerPlus(
                    stateSearchPlaceholder: 'Search State/City/County',
                    countryStateLanguage: CountryStateLanguage.englishOrNative,
                    stateDropdownLabel: 'State/City/County',
                    currentCity: _lgaController.text,
                    currentState: _stateOriginController.text,
                    currentCountry: _nationalityController.text,
                    onCountryChanged: (value) {
                      setState(() {
                        _nationalityController.text = value;
                      });
                    },
                    onStateChanged: (value) {
                      setState(() {
                        _stateOriginController.text = value ?? '';
                      });
                    },
                    onCityChanged: (value) {
                      setState(() {
                        _lgaController.text = value ?? '';
                      });
                    },
                  ),
                  // CustomTextField(
                  //   label: 'Nationality',
                  //   hint: '',
                  //   controller: _nationalityController,
                  // ),
                  // const SizedBox(height: 12),
                  // CustomTextField(
                  //   label: 'State of Origin',
                  //   hint: '',
                  //   controller: _stateOriginController,
                  // ),
                  // const SizedBox(height: 12),
                  // CustomTextField(
                  //   label: 'LGA',
                  //   hint: '',
                  //   controller: _lgaController,
                  // ),
                  12.height,
                  CustomTextField(
                    label: 'Place of Birth',
                    hint: '',
                    controller: _placeOfBirthController,
                  ),
                  12.height,
                  CustomTextField(
                    label: 'Marital Status',
                    hint: '',
                    controller: _maritalStatusController,
                  ),
                  30.height,
                  AppButton(
                    child: const Text('Update Profile'),
                    onPressed: () {
                      _submit();
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
