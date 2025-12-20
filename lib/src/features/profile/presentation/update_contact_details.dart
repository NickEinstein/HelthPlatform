import 'package:csc_picker_plus/csc_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greenzone_medical/src/features/profile/model/patient_contact_model.dart';
import 'package:greenzone_medical/src/features/profile/presentation/update_emergency_contact.dart';
import 'package:greenzone_medical/src/features/profile/widget/profile_switch_overlay.dart';
import 'package:greenzone_medical/src/provider/profile_provider.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/primary_button.dart';
import 'package:greenzone_medical/src/utils/packages.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class UpdateContactDetailsScreen extends ConsumerStatefulWidget {
  static const routeName = '/update-contact-details';
  const UpdateContactDetailsScreen({super.key});

  @override
  ConsumerState<UpdateContactDetailsScreen> createState() =>
      _UpdateContactDetailsScreenState();
}

class _UpdateContactDetailsScreenState
    extends ConsumerState<UpdateContactDetailsScreen> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  late TextEditingController _stateOriginController;
  late TextEditingController _lgaController;
  late TextEditingController _homeAddressController;
  late TextEditingController _mobileController;
  late TextEditingController _alternateMobileController;
  late TextEditingController _emailController;
  late TextEditingController _cityController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime? dateOfBirth;

  @override
  void initState() {
    super.initState();
    _stateOriginController = TextEditingController();
    _lgaController = TextEditingController();
    _homeAddressController = TextEditingController();
    _mobileController = TextEditingController();
    _alternateMobileController = TextEditingController();
    _cityController = TextEditingController();
    _emailController = TextEditingController();
    // Pre-fill data if available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = ref.read(profileProvider);
      final contact = state.patientContact;
      if (contact != null) {
        _emailController.text = contact.email;
        _mobileController.text = contact.phone;
        _homeAddressController.text = contact.homeAddress;
        _alternateMobileController.text = contact.altPhone;
        _cityController.text = contact.city;
        _stateOriginController.text = contact.stateOfResidence;
        _lgaController.text = contact.lgaResidence;
      }
    });
  }

  @override
  void dispose() {
    _cityController.dispose();
    _mobileController.dispose();
    _stateOriginController.dispose();
    _lgaController.dispose();
    _alternateMobileController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submitContactDetails() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    final payload = PatientContactModel(
      email: _emailController.text,
      phone: _mobileController.text,
      homeAddress: _homeAddressController.text,
      altPhone: _alternateMobileController.text,
      lgaResidence: _lgaController.text,
      stateOfResidence: _stateOriginController.text,
      city: _cityController.text,
    );

    final result = await ref.read(profileProvider.notifier).updateContact(
          payload,
        );
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
            'Contact Details',
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              context.pushReplacement(
                                UpdateEmergencyContact.routeName,
                              );
                            },
                            child: const Row(
                              children: [
                                Text(
                                  'Emergency Contact',
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
                              const Text('Contact Details',
                                  style: TextStyle(fontSize: 14)),
                              const Spacer(),
                              const Icon(Icons.keyboard_arrow_down,
                                  color: Colors.indigo),
                            ],
                          ),
                        ),
                      ),
                    ),
                    20.height,
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
                      currentState: _stateOriginController.text,
                      currentCountry: '',
                      onCountryChanged: (_) {},
                      onStateChanged: (value) {
                        setState(() {
                          _stateOriginController.text = value ?? '';
                        });
                      },
                      onCityChanged: (value) {
                        setState(() {
                          _cityController.text = value ?? '';
                        });
                      },
                    ),
                    20.height,
                    CustomTextField(
                      label: 'LGA of Residence',
                      controller: _lgaController,
                      hint: '',
                    ),
                    20.height,
                    CustomTextField(
                      label: 'Home Address',
                      controller: _homeAddressController,
                      hint: '',
                    ),
                    20.height,
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
                    20.height,
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
                      child: const Text('Save Contact Details'),
                      onPressed: () {
                        _submitContactDetails();
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
      currentScreen: 'Contact Details',
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
