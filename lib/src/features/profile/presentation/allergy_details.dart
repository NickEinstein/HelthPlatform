import 'package:greenzone_medical/src/features/profile/model/allergy_list_model.dart';
import 'package:greenzone_medical/src/features/profile/presentation/medical_records.dart';
import 'package:greenzone_medical/src/features/profile/widget/allergy_widget.dart';
import 'package:greenzone_medical/src/features/profile/widget/delete_dialog.dart';
import 'package:greenzone_medical/src/features/profile/widget/profile_switch_overlay.dart';
import 'package:greenzone_medical/src/provider/profile_provider.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/string_extensions.dart';
import 'package:greenzone_medical/src/utils/packages.dart';

class AllergyDetailsScreen extends ConsumerStatefulWidget {
  static const routeName = '/allergy-details';
  const AllergyDetailsScreen({super.key});

  @override
  ConsumerState<AllergyDetailsScreen> createState() =>
      _AllergyDetailsScreenState();
}

class _AllergyDetailsScreenState extends ConsumerState<AllergyDetailsScreen> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  Set<AllergyListModel> selectedAllergies = {};
  late TextEditingController _otherAllergyController;

  @override
  void initState() {
    super.initState();
    _otherAllergyController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if ((ref.read(profileProvider).allAllergies?.isEmpty ?? true) &&
          mounted) {
        ref.read(profileProvider.notifier).fetchAllAllergies();
      }
    });
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
        'others': [
          {'allergicTo': _otherAllergyController.text}
        ]
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
    final userOtherAllergies = ref.watch(profileProvider).userOtherAllergies;
    final userAllergiesIds = userAllergies?.map((e) => e.allergyId).toList();
    final allergy = ref.watch(profileProvider).allAllergies;

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
                  final allergyAddList = allergy
                      ?.where(
                          (e) => !(userAllergiesIds?.contains(e.id) ?? false))
                      .toList();

                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.white,
                    showDragHandle: true,
                    isScrollControlled: true,
                    useSafeArea: true,
                    builder: (_) {
                      return StatefulBuilder(builder: (context, setModalState) {
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: context.mediaQuery.viewInsets.bottom,
                          ),
                          child: Padding(
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
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        spacing: 12,
                                        // runSpacing: 12,
                                        children: List.generate(
                                          allergyAddList?.length ?? 0,
                                          (index) => Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.grey
                                                  .withValues(alpha: .2),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Checkbox(
                                                  value: selectedAllergies
                                                      .contains(allergyAddList?[
                                                          index]),
                                                  onChanged: (value) {
                                                    setModalState(() {
                                                      if (value == true &&
                                                          !selectedAllergies
                                                              .contains(
                                                                  allergyAddList?[
                                                                      index]) &&
                                                          allergyAddList?[
                                                                  index] !=
                                                              null) {
                                                        selectedAllergies.add(
                                                            allergyAddList![
                                                                index]);
                                                      } else {
                                                        selectedAllergies
                                                            .remove(
                                                                allergyAddList?[
                                                                    index]);
                                                      }
                                                    });
                                                  },
                                                ),
                                                2.width,
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        allergyAddList?[index]
                                                                .allergyOrIntolleranceSource ??
                                                            '',
                                                        style: context.textTheme
                                                            .bodyMedium,
                                                      ),
                                                      4.height,
                                                      Text(
                                                        allergyAddList?[index]
                                                                .description ??
                                                            '',
                                                        style: context.textTheme
                                                            .bodySmall,
                                                        maxLines: 4,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
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
                                6.height,
                                CustomTextField(
                                  hint:
                                      'Enter allergy (e.g Peanuts, Shellfish)',
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
                                    InkWell(
                                      onTap: _submitAllergyDetails,
                                      child: Container(
                                        padding: const EdgeInsets.all(14),
                                        decoration: BoxDecoration(
                                          color: ColorConstant.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          'Add Allergies',
                                          style: context.textTheme.bodyMedium
                                              ?.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                    },
                  );
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
                          context.pushReplacement(
                            MedicalRecordsScreen.routeName,
                          );
                        },
                        child: const Row(
                          children: [
                            Text(
                              'Medical Records',
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
                  if (userAllergies?.isEmpty ?? true)
                    const Center(
                      child: Text('No allergy found'),
                    ),
                  if (userAllergies?.isNotEmpty ?? false) ...[
                    Text(
                      'Medical Allergies',
                      style: context.textTheme.titleMedium,
                    ),
                    8.height,
                    Column(
                      spacing: 16,
                      children: List.generate(
                        userAllergies?.length ?? 0,
                        (index) => AllergyWidget(
                          allergy: userAllergies![index],
                          otherAllergy: allergy?.where((e) {
                            return e.id == userAllergies[index].allergyId;
                          }).firstOrNull,
                        ),
                      ),
                    )
                  ],
                  if (userOtherAllergies?.isNotEmpty ?? false) ...[
                    12.height,
                    Text(
                      'Other Allergies',
                      style: context.textTheme.titleMedium,
                    ),
                    8.height,
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: List.generate(
                        userOtherAllergies?.length ?? 0,
                        (index) => Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(48),
                            border:
                                Border.all(color: ColorConstant.primaryColor),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                userOtherAllergies![index].allergicTo,
                                style: context.textTheme.bodyMedium,
                              ),
                              6.width,
                              InkWell(
                                onTap: () async {
                                  final shouldDelete = await showDeleteDialog(
                                    context,
                                    title: 'Delete Allergy',
                                    content:
                                        'Are you sure you want to delete this allergy?',
                                  );
                                  if (shouldDelete) {
                                    ref
                                        .read(profileProvider.notifier)
                                        .deleteOtherAllergy(
                                          userOtherAllergies[index]
                                              .id
                                              .toString(),
                                        );
                                  }
                                },
                                child: const Icon(
                                  Icons.cancel,
                                  color: ColorConstant.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
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
      list: ['Medical Records', 'Immunization'],
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
