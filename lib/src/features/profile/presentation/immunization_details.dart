import 'package:greenzone_medical/src/features/profile/model/immunization_result.dart';
import 'package:greenzone_medical/src/features/profile/presentation/allergy_details.dart';
import 'package:greenzone_medical/src/features/profile/widget/immunization_widget.dart';
import 'package:greenzone_medical/src/features/profile/widget/profile_switch_overlay.dart';
import 'package:greenzone_medical/src/provider/profile_provider.dart';
import 'package:greenzone_medical/src/utils/extensions/date_extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/primary_button.dart';
import 'package:greenzone_medical/src/utils/extensions/string_extensions.dart';
import 'package:greenzone_medical/src/utils/packages.dart';

class ImmunizationDetailsScreen extends ConsumerStatefulWidget {
  static const routeName = '/immunization-details';
  const ImmunizationDetailsScreen({super.key});

  @override
  ConsumerState<ImmunizationDetailsScreen> createState() =>
      _ImmunizationDetailsScreenState();
}

class _ImmunizationDetailsScreenState
    extends ConsumerState<ImmunizationDetailsScreen> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _vaccinationNameController;
  late TextEditingController _vaccineBrandController;
  late TextEditingController _batchIdController;
  late TextEditingController _qtyController;
  late TextEditingController _ageController;
  late TextEditingController _weightController;
  late TextEditingController _tempController;
  late TextEditingController _dateController;
  late TextEditingController _noteController;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _vaccinationNameController = TextEditingController();
    _vaccineBrandController = TextEditingController();
    _batchIdController = TextEditingController();
    _qtyController = TextEditingController();
    _ageController = TextEditingController();
    _weightController = TextEditingController();
    _tempController = TextEditingController();
    _dateController = TextEditingController();
    _noteController = TextEditingController();
  }

  @override
  void dispose() {
    _vaccinationNameController.dispose();
    _vaccineBrandController.dispose();
    _batchIdController.dispose();
    _qtyController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _tempController.dispose();
    _dateController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _submitImmunizationDetails() async {
    if (!(_formKey.currentState?.validate() ?? false) ||
        _selectedDate == null) {
      return;
    }
    context.pop();
    final payload = ImmunizationResult(
      vaccine: _vaccinationNameController.text,
      vaccineBrand: _vaccineBrandController.text,
      batchId: _batchIdController.text,
      quantity: int.parse(_qtyController.text),
      age: int.parse(_ageController.text),
      weight: double.parse(_weightController.text),
      temperature: double.parse(_tempController.text),
      dateGiven: _selectedDate!,
      notes: _noteController.text,
    );

    final result = await ref.read(profileProvider.notifier).addImmunization(
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
    clearCtrls();
  }

  clearCtrls() {
    _vaccinationNameController.clear();
    _vaccineBrandController.clear();
    _batchIdController.clear();
    _qtyController.clear();
    _ageController.clear();
    _weightController.clear();
    _tempController.clear();
    _dateController.clear();
    _noteController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(profileProvider).isLoading;
    final immunization = ref.watch(profileProvider).immunizations;

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
        floatingActionButton: isLoading
            ? const SizedBox()
            : FloatingActionButton(
                backgroundColor: ColorConstant.primaryColor,
                onPressed: () async {
                  _showAddImmunizationSheet();
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
        appBar: AppBar(
          title: const Text(
            'Immunization Details',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
            // onPressed: () => context.pop(),
          ),
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
                              AllergyDetailsScreen.routeName,
                            );
                          },
                          child: const Row(
                            children: [
                              Text(
                                'Allergies',
                                style: TextStyle(color: Colors.black),
                              ),
                              Icon(Icons.arrow_forward,
                                  size: 16, color: Colors.black),
                            ],
                          ),
                        )
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
                              SvgPicture.asset('clinic'.toSvg),
                              // Container(
                              //   decoration: BoxDecoration(
                              //     color: Colors.white.withValues(alpha: 0.5),
                              //     shape: BoxShape.circle,
                              //   ),
                              //   padding: const EdgeInsets.all(8),
                              //   child: const Icon(Icons.badge_outlined,
                              //       color: Colors.indigo), // Icon from image
                              // ),
                              12.width,
                              const Text(
                                'Immunization',
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
                    if (immunization?.isEmpty ?? true)
                      const Center(
                        child: Text('No immunization details found'),
                      ),
                    if (immunization?.isNotEmpty ?? false)
                      Column(
                        spacing: 16,
                        children: List.generate(
                          immunization?.length ?? 0,
                          (index) => ImmunizationWidget(
                            immunization: immunization![index],
                          ),
                        ),
                      )
                  ],
                ),
              ),
      ),
    );
  }

  void _showAddImmunizationSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      showDragHandle: true,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: context.mediaQuery.viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Add Immunization', style: context.textTheme.titleMedium),
                16.height,
                CustomTextField(
                  controller: _vaccinationNameController,
                  label: 'Vaccination Name',
                ),
                16.height,
                CustomTextField(
                  controller: _vaccineBrandController,
                  label: 'Vaccine Brand',
                ),
                16.height,
                CustomTextField(
                  controller: _batchIdController,
                  label: 'Batch ID',
                ),
                16.height,
                CustomTextField(
                  controller: _qtyController,
                  label: 'Quantity',
                  keyboardType: TextInputType.number,
                ),
                16.height,
                CustomTextField(
                  controller: _ageController,
                  label: 'Age',
                  keyboardType: TextInputType.number,
                ),
                16.height,
                CustomTextField(
                  controller: _weightController,
                  label: 'Weight',
                  keyboardType: TextInputType.number,
                ),
                16.height,
                CustomTextField(
                  controller: _tempController,
                  label: 'Temperature',
                  keyboardType: TextInputType.number,
                ),
                16.height,
                CustomTextField(
                  controller: _dateController,
                  label: 'Date',
                  readOnly: true,
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    if (date != null) {
                      _dateController.text = date.formatDatePretty;
                      _selectedDate = date;
                    }
                  },
                ),
                16.height,
                CustomTextField(
                  controller: _noteController,
                  label: 'Note',
                ),
                20.height,
                AppButton(
                  onPressed: _submitImmunizationDetails,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showOverlay() {
    _overlayEntry = profileSwitchOverlay(
      currentScreen: 'Immunization',
      hideOverlay: _hideOverlay,
      layerLink: _layerLink,
      list: ['Allergies', 'Medical Records'],
      
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
