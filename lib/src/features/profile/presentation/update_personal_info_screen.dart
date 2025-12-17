import 'package:csc_picker_plus/csc_picker_plus.dart';
import 'package:greenzone_medical/src/features/profile/model/update_patient_payload.dart';
import 'package:greenzone_medical/src/features/profile/presentation/update_contact_details.dart';
import 'package:greenzone_medical/src/features/profile/widget/profile_dialogs.dart';
import 'package:greenzone_medical/src/features/profile/widget/profile_switch_overlay.dart';
import 'package:greenzone_medical/src/provider/profile_provider.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/primary_button.dart';
import 'package:greenzone_medical/src/utils/packages.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class UpdatePersonalDetailsScreen extends ConsumerStatefulWidget {
  static const routeName = '/update-personal-details';
  const UpdatePersonalDetailsScreen({super.key});

  @override
  ConsumerState<UpdatePersonalDetailsScreen> createState() =>
      _UpdatePersonalDetailsScreenState();
}

class _UpdatePersonalDetailsScreenState
    extends ConsumerState<UpdatePersonalDetailsScreen> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _genderController;
  late TextEditingController _dobController;
  late TextEditingController _nationalityController;
  late TextEditingController _stateOriginController;
  late TextEditingController _lgaController;
  late TextEditingController _maritalStatusController;
  late TextEditingController _mobileController;
  late TextEditingController _weightController;
  late TextEditingController _ninController;
  late TextEditingController _emailController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime? dateOfBirth;

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
    _maritalStatusController = TextEditingController();
    _mobileController = TextEditingController();
    _weightController = TextEditingController();
    _ninController = TextEditingController();
    _emailController = TextEditingController();
    // Pre-fill data if available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        final state = ref.read(profileProvider);
        final profile = state.patientProfile?.data;
        if (profile != null) {
          print(profile.toJson());
          _emailController.text = profile.email ?? '';
          _mobileController.text = profile.phoneNumber ?? '';
          _firstNameController.text = profile.firstName ?? '';
          _lastNameController.text = profile.lastName ?? '';
          _genderController.text = profile.gender ?? '';
          dateOfBirth = profile.dateOfBirth;
          _dobController.text = profile.dateOfBirth != null
              ? DateFormat('yyyy-MM-dd').format(profile.dateOfBirth!)
              : '';
          _nationalityController.text = profile.nationality ?? '';
          _stateOriginController.text = profile.stateOfOrigin ?? '';
          print('-------------------------------');
          print(profile.stateOfOrigin);
          print(_stateOriginController.text);
          print('-------------------------------');
          _lgaController.text = profile.placeOfBirth ?? '';
          _maritalStatusController.text = profile.maritalStatus ?? '';
          _weightController.text = profile.weight?.toString() ?? '';
          _ninController.text = profile.nin ?? '';
          if (mounted) {
            setState(() {});
          }
        }
      } catch (e, s) {
        print(e);
        print(s);
      }
    });
  }

  @override
  void dispose() {
    _mobileController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _genderController.dispose();
    _dobController.dispose();
    _nationalityController.dispose();
    _stateOriginController.dispose();
    _lgaController.dispose();
    _maritalStatusController.dispose();
    _weightController.dispose();
    _ninController.dispose();
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
        dateOfBirth = picked;
        _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _submitPersonalData() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    final payload = UpdatePatientPayload(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      gender: _genderController.text,
      dateOfBirth: dateOfBirth,
      nationality: _nationalityController.text.split(' ').lastOrNull ?? '',
      stateOfOrigin: _stateOriginController.text,
      lga: _lgaController.text,
      placeOfBirth: '',
      maritalStatus: _maritalStatusController.text,
      // Default or existing values for fields not shown in this specific screen part
      weight: double.tryParse(_weightController.text),
      pictureUrl:
          ref.read(profileProvider).patientProfile?.data?.pictureUrl ?? '',
      nin: _ninController.text,
      phoneNumber: _mobileController.text,
    );

    final result =
        await ref.read(profileProvider.notifier).updateProfile(payload);
    if (result.$1 && mounted) {
      context.showFeedBackDialog(
        message: result.$2 ?? 'Profile updated successfully',
        toastType: ToastType.success,
      );
    } else if (mounted) {
      context.showFeedBackDialog(
        message: result.$2 ?? 'Failed to update profile',
        toastType: ToastType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(profileProvider).isLoading;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (context.mediaQuery.viewInsets.bottom > 0) {
          FocusManager.instance.primaryFocus?.unfocus();
        } else {
          // ref.invalidate(profileProvider);
          ref.read(profileProvider.notifier).fetchAll();
          context.pop();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Personal Details',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => context.pop(),
          ),
          //   actions: [
          //     Padding(
          //       padding: const EdgeInsets.only(right: 16.0),
          //       child: CircleAvatar(
          //         backgroundColor: Colors.grey.shade200,
          //         backgroundImage: profilePic != null && profilePic.isNotEmpty
          //             ? NetworkImage(profilePic)
          //             : null,
          //         child: profilePic == null || profilePic.isEmpty
          //             ? const Icon(Icons.person, color: Colors.grey)
          //             : null,
          //       ),
          //     )
          //   ],
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
                              // _submitPersonalData();
                              context.pushReplacement(
                                UpdateContactDetailsScreen.routeName,
                              );
                            },
                            child: const Row(
                              children: [
                                Text(
                                  'Contact Details',
                                  style: TextStyle(color: Colors.black),
                                ),
                                Icon(Icons.arrow_forward,
                                    size: 16, color: Colors.black),
                              ],
                            ))
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        if (_overlayEntry == null) {
                          _showOverlay();
                        } else {
                          _hideOverlay();
                        }
                      },
                      child: CompositedTransformTarget(
                        link: _layerLink,
                        child: Container(
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
                              const Text(
                                'Personal Data',
                                style: TextStyle(fontSize: 14),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.indigo,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    20.height,
                    Row(
                      children: [
                        // Expanded(
                        //   // flex: 2,
                        //   child: Container(
                        //     padding: const EdgeInsets.symmetric(
                        //         horizontal: 8, vertical: 8),
                        //     decoration: BoxDecoration(
                        //       color: const Color(0xFFF5F5F5),
                        //       border: Border.all(
                        //         color: const Color(0xFFB3B3B3),
                        //         width: 1,
                        //       ),
                        //       borderRadius: const BorderRadius.only(
                        //         topLeft: Radius.circular(8),
                        //         bottomLeft: Radius.circular(8),
                        //       ),
                        //     ),
                        //     child: const Text('Firstname'),
                        //   ),
                        // ),
                        Expanded(
                          child: CustomTextField(
                            label: 'Firstname',
                            hint: '',
                            controller: _firstNameController,
                          ),
                        ),
                      ],
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
                    22.height,
                    IntlPhoneField(
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      initialCountryCode: 'NG',
                      controller: _mobileController,
                    ),
                    // IntlMobileField(
                    //   favorite: const ['NG'],
                    //   initialCountryCode: 'NG',
                    //   languageCode: "en",
                    //   decoration: const InputDecoration(
                    //     labelText: 'Mobile Number',
                    //     border: OutlineInputBorder(
                    //       borderSide: BorderSide(),
                    //     ),
                    //     hintText: '',
                    //   ),
                    //   disableLengthCounter: true,
                    //   controller: _mobileController,
                    // ),
                    if (_emailController.text.isNotEmpty) ...[
                      CustomTextField(
                        label: 'Email',
                        hint: '',
                        controller: _emailController,
                        readOnly: true,
                      ),
                      12.height,
                    ],
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
                    const Text('Nationality'),
                    4.height,
                    CSCPickerPlus(
                      padding: 16,
                      layout: Layout.vertical,
                      cityDropdownLabel: 'Select City',
                      stateDropdownLabel: 'State of residence',
                      countryDropdownLabel: 'Select Country',
                      stateSearchPlaceholder: 'Search State',
                      citySearchPlaceholder: 'Search City',
                      defaultCountry: CscCountry.Nigeria,
                      countryStateLanguage:
                          CountryStateLanguage.englishOrNative,
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
                      key: const Key('maritalStatus'),
                      label: 'Marital Status',
                      hint: '',
                      controller: _maritalStatusController,
                      readOnly: true,
                      onTap: () async {
                        final maritalStatus = await showMaritalStatusDialog(
                          context,
                        );
                        if (maritalStatus != null) {
                          setState(() {
                            _maritalStatusController.text = maritalStatus;
                          });
                        }
                      },
                    ),
                    12.height,
                    CustomTextField(
                      label: 'Weight (kg)',
                      hint: '',
                      keyboardType: TextInputType.number,
                      controller: _weightController,
                    ),
                    12.height,
                    CustomTextField(
                      label: 'National Identification Number',
                      hint: '',
                      keyboardType: TextInputType.number,
                      controller: _ninController,
                    ),
                    30.height,
                    AppButton(
                      child: const Text('Update Profile'),
                      onPressed: () {
                        _submitPersonalData();
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void _showOverlay() {
    _overlayEntry = profileSwitchOverlay(
      currentScreen: 'Personal Data',
      hideOverlay: _hideOverlay,
      layerLink: _layerLink,
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
