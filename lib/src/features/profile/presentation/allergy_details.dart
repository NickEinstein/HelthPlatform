import 'package:greenzone_medical/src/features/profile/model/allergy_list_model.dart';
import 'package:greenzone_medical/src/features/profile/presentation/immunization_details.dart';
import 'package:greenzone_medical/src/features/profile/widget/allergy_widget.dart';
import 'package:greenzone_medical/src/features/profile/widget/profile_switch_overlay.dart';
import 'package:greenzone_medical/src/provider/profile_provider.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/primary_button.dart';
import 'package:greenzone_medical/src/utils/extensions/string_extensions.dart';
import 'package:greenzone_medical/src/utils/packages.dart';

class AllergyDetailsScreen extends ConsumerStatefulWidget {
  static const routeName = '/allergy-details';
  const AllergyDetailsScreen({super.key});

  @override
  ConsumerState<AllergyDetailsScreen> createState() =>
      _ImmunizationDetailsScreenState();
}

class _ImmunizationDetailsScreenState
    extends ConsumerState<AllergyDetailsScreen> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  Set<AllergyListModel> selectedAllergies = {};
  late TextEditingController _otherAllergyController;

  @override
  void initState() {
    super.initState();
    _otherAllergyController = TextEditingController();
    if ((ref.read(profileProvider).allAllergies?.isEmpty ?? true) && mounted) {
      ref.read(profileProvider.notifier).fetchAllAllergies();
    }
  }

  @override
  void dispose() {
    _otherAllergyController.dispose();
    super.dispose();
  }

  void _submitAllergyDetails() async {
    context.pop();
    final payload = {
      'allergies': selectedAllergies.map((e) => e.toJson()).toList(),
      if (_otherAllergyController.text.isNotEmpty)
        'others': [_otherAllergyController.text]
    };

    final result = await ref.read(profileProvider.notifier).addAllergy(
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
    _otherAllergyController.clear();
    selectedAllergies.clear();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(profileProvider).isLoading;
    final userAllergies = ref.watch(profileProvider).userAllergies;
    final userAllergiesIds = userAllergies?.map((e) => e.allergyId).toList();
    final allergy = ref
        .watch(profileProvider)
        .allAllergies
        ?.where((e) => !(userAllergiesIds?.contains(e.id) ?? false))
        .toList();

    void showAddAllergySheet() {
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
                  Text(
                    'Add Allergies',
                    style: context.textTheme.titleMedium,
                  ),
                  8.height,
                  Text(
                    'Medical Allergies',
                    style: context.textTheme.titleMedium,
                  ),
                  8.height,
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.withValues(alpha: .4),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: List.generate(
                        allergy?.length ?? 0,
                        (index) => Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey.withValues(alpha: .4),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Checkbox(
                                value:
                                    selectedAllergies.contains(allergy?[index]),
                                onChanged: (value) {
                                  setState(() {
                                    if (value == true &&
                                        !selectedAllergies
                                            .contains(allergy?[index]) &&
                                        allergy?[index] != null) {
                                      selectedAllergies.add(allergy![index]);
                                    } else {
                                      selectedAllergies.remove(allergy?[index]);
                                    }
                                  });
                                },
                              ),
                              2.width,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    allergy?[index]
                                            .allergyOrIntolleranceSource ??
                                        '',
                                    style: context.textTheme.bodyMedium,
                                  ),
                                  4.height,
                                  Text(
                                    allergy?[index].description ?? '',
                                    style: context.textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  16.height,
                  Text(
                    'Other Allergies',
                    style: context.textTheme.titleMedium,
                  ),
                  CustomTextField(
                    hint: 'Enter allergy (e.g Peanuts, Shellfish)',
                    controller: _otherAllergyController,
                  ),
                  20.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          context.pop();
                        },
                        child: Text(
                          'Cancel',
                          style: context.textTheme.bodyLarge,
                        ),
                      ),
                      8.width,
                      AppButton(
                        onPressed: _submitAllergyDetails,
                        child: const Text('Add Allergies'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (context.mediaQuery.viewInsets.bottom > 0) {
          FocusManager.instance.primaryFocus?.unfocus();
        } else {
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
                  showAddAllergySheet();
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
        appBar: AppBar(
          title: const Text(
            'Allergy Details',
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
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          context.pushNamed(
                            ImmunizationDetailsScreen.routeName,
                          );
                        },
                        child: const Row(
                          children: [
                            Text(
                              'Immunization',
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
                            // Container(
                            //   decoration: BoxDecoration(
                            //     color: Colors.white.withValues(alpha: 0.5),
                            //     shape: BoxShape.circle,
                            //   ),
                            //   padding: const EdgeInsets.all(8),
                            //   child: const Icon(Icons.badge_outlined,
                            //       color: Colors.indigo), // Icon from image
                            // ),
                            SvgPicture.asset('clinic'.toSvg),
                            12.width,
                            const Text(
                              'Allergy',
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
                  if (allergy?.isEmpty ?? true)
                    const Center(
                      child: Text('No allergy found'),
                    ),
                  if (allergy?.isNotEmpty ?? false)
                    Column(
                      spacing: 16,
                      children: List.generate(
                        userAllergies?.length ?? 0,
                        (index) => AllergyWidget(
                          allergy: userAllergies![index],
                          otherAllergy: allergy
                              ?.where((e) => e.id == userAllergies[index].id)
                              .firstOrNull,
                        ),
                      ),
                    )
                ],
              ),
      ),
    );
  }

  void _showOverlay() {
    _overlayEntry = profileSwitchOverlay(
      currentScreen: 'Immunization Details',
      hideOverlay: _hideOverlay,
      layerLink: _layerLink,
      list: ['Allergies'],
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
