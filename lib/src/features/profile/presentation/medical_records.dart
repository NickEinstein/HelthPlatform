import 'package:greenzone_medical/src/features/profile/presentation/immunization_details.dart';
import 'package:greenzone_medical/src/features/profile/widget/profile_switch_overlay.dart';
import 'package:greenzone_medical/src/provider/profile_provider.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/string_extensions.dart';
import 'package:greenzone_medical/src/utils/packages.dart';

class MedicalRecordsScreen extends ConsumerStatefulWidget {
  static const routeName = '/medical-records';
  const MedicalRecordsScreen({super.key});

  @override
  ConsumerState<MedicalRecordsScreen> createState() =>
      _MedicalRecordsScreenState();
}

class _MedicalRecordsScreenState extends ConsumerState<MedicalRecordsScreen> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
            'Medical Records',
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
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            context.pushReplacement(
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
                                'Medical Records',
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
                    16.height,
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'No medical records found\n',
                            textAlign: TextAlign.center,
                            style: context.textTheme.bodyLarge,
                          ),
                          // 4.height,
                          Text(
                            'Your medical records will appear here once uploaded by your healthcare provider',
                            textAlign: TextAlign.center,
                            style: context.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void _showOverlay() {
    _overlayEntry = profileSwitchOverlay(
      currentScreen: 'Medical Records',
      hideOverlay: _hideOverlay,
      layerLink: _layerLink,
      list: ['Immunization', 'Allergies'],
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
