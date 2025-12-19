import 'package:csc_picker_plus/csc_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/constants/helper.dart';
import 'package:greenzone_medical/src/features/profile/model/emergency_contact_info.dart';
import 'package:greenzone_medical/src/features/profile/presentation/update_personal_info_screen.dart';
import 'package:greenzone_medical/src/features/profile/widget/profile_switch_overlay.dart';
import 'package:greenzone_medical/src/provider/profile_provider.dart';
import 'package:greenzone_medical/src/utils/custom_toast.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/primary_button.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../utils/extensions/widget_extensions.dart';

class UpdateEmergencyContact extends ConsumerStatefulWidget {
  static const routeName = '/update-emergency-contact';
  const UpdateEmergencyContact({super.key});

  @override
  ConsumerState<UpdateEmergencyContact> createState() =>
      _UpdateEmergencyContactState();
}

class _UpdateEmergencyContactState
    extends ConsumerState<UpdateEmergencyContact> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _relationshipController;
  late TextEditingController _mobileController;
  late TextEditingController _alternateMobileController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;
  late TextEditingController _stateController;
  late TextEditingController _cityController;
  late TextEditingController _lgaController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime? dateOfBirth;

  @override
  void initState() {
    super.initState();
    _lgaController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _relationshipController = TextEditingController();
    _mobileController = TextEditingController();
    _alternateMobileController = TextEditingController();
    _emailController = TextEditingController();
    _addressController = TextEditingController();
    _stateController = TextEditingController();
    _cityController = TextEditingController();
    _emailController = TextEditingController();
    // Pre-fill data if available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = ref.read(profileProvider);
      final contact = state.emergencyContactInfo;
      if (contact != null) {
        print(contact.toJson());
        _firstNameController.text = contact.firstName;
        _lastNameController.text = contact.lastName;
        _relationshipController.text = contact.relationship;
        _mobileController.text = contact.phone;
        _alternateMobileController.text = contact.altPhone;
        _emailController.text = contact.email;
        _addressController.text = contact.contactAddress;
        // _nationalityController.text = contact.;
        _lgaController.text = contact.lga;
        _stateController.text = contact.stateOfResidence;
        _cityController.text = contact.city;
      }
    });
  }

  @override
  void dispose() {
    _cityController.dispose();
    _mobileController.dispose();
    _stateController.dispose();
    _addressController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _relationshipController.dispose();
    _alternateMobileController.dispose();
    _lgaController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submitEmergencyContact() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    final payload = EmergencyContactInfo(
      email: _emailController.text,
      phone: _mobileController.text,
      altPhone: _alternateMobileController.text,
      stateOfResidence: _stateController.text,
      city: _cityController.text,
      contactAddress: _addressController.text,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      relationship: _relationshipController.text,
      fullName: '${_firstNameController.text} ${_lastNameController.text}',
      lga: _lgaController.text,
    );

    final result = await ref
        .read(profileProvider.notifier)
        .updateEmergencyContact(payload);
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
            'Emergency Contact',
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
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                context.pushReplacement(
                                  UpdatePersonalDetailsScreen.routeName,
                                );
                              },
                              child: const Row(
                                children: [
                                  Text(
                                    'Personal Details',
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
                                  'Emergency Contact',
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
                      CustomTextField(
                        hint: 'Enter first name',
                        label: 'First Name',
                        controller: _firstNameController,
                      ),
                      16.height,
                      CustomTextField(
                        hint: 'Enter last name',
                        label: 'Last Name',
                        controller: _lastNameController,
                      ),
                      16.height,
                      CustomTextField(
                        hint: 'Relationship',
                        label: 'Relationship',
                        controller: _relationshipController,
                      ),
                      16.height,
                      const Text('Phone'),
                      4.height,
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
                      16.height,
                      const Text('Alternate Phone'),
                      4.height,
                      IntlPhoneField(
                        decoration: const InputDecoration(
                          labelText: 'Alternate Phone',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                        initialCountryCode: 'NG',
                        controller: _alternateMobileController,
                      ),
                      16.height,
                      const Text('Residence'),
                      4.height,
                      CSCPickerPlus(
                        padding: 16,
                        showCountry: false,
                        layout: Layout.vertical,
                        cityDropdownLabel: 'Select City',
                        stateDropdownLabel: 'State of residence',
                        countryDropdownLabel: 'Select Country',
                        stateSearchPlaceholder: 'Search State',
                        citySearchPlaceholder: 'Search City',
                        defaultCountry: CscCountry.Nigeria,
                        countryStateLanguage:
                            CountryStateLanguage.englishOrNative,
                        currentCity: _cityController.text,
                        currentState: _stateController.text,
                        currentCountry: '',
                        onCountryChanged: (_) {},
                        onStateChanged: (value) {
                          setState(() {
                            _stateController.text = value ?? '';
                          });
                        },
                        onCityChanged: (value) {
                          setState(() {
                            _cityController.text = value ?? '';
                          });
                        },
                      ),
                      16.height,
                      CustomTextField(
                        hint: 'LGA',
                        label: 'LGA',
                        controller: _lgaController,
                      ),
                      16.height,
                      CustomTextField(
                        hint: 'Address',
                        label: 'Address',
                        controller: _addressController,
                      ),
                      16.height,
                      if (_emailController.text.isNotEmpty) ...[
                        CustomTextField(
                          label: 'Email',
                          hint: '',
                          controller: _emailController,
                          readOnly: true,
                        ),
                        12.height,
                      ],
                      30.height,
                      AppButton(
                        child: const Text('Safe Emergency Contact'),
                        onPressed: () {
                          _submitEmergencyContact();
                        },
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  void _showOverlay() {
    _overlayEntry = profileSwitchOverlay(
      currentScreen: 'Emergency Contact',
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
