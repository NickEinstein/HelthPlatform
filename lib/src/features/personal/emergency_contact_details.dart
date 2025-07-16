import '../../provider/all_providers.dart';
import '../../utils/packages.dart';

class EmergencyContactDetails extends ConsumerStatefulWidget {
  const EmergencyContactDetails({super.key});

  @override
  ConsumerState<EmergencyContactDetails> createState() =>
      _EmergencyContactDetailsState();
}

class _EmergencyContactDetailsState
    extends ConsumerState<EmergencyContactDetails> {
  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userEmergencyContactProvider);

    return userAsync.when(
        loading: () => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
        error: (error, _) => Scaffold(
              extendBodyBehindAppBar: true,
              appBar: const CustomAppBar(
                title: 'Personal Details',
                allowBackButton: false,
              ),
              drawer: const HomeDrawer(),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    verticalSpace(context, 0.15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 27),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  Icons.arrow_back,
                                  color: Color(0xff444444),
                                ),
                              ),
                            ],
                          ),
                          smallSpace(),
                          buildRecordTile(
                            title: 'Emergency Contact Details',
                            icon: SvgAssets.medx,
                            isSvg: false,
                            isSubtitle: false,
                            isCircle: true,
                            dropDown: true,
                            onTap: () {},
                          ),
                          smallSpace(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              verticalSpace(context, 0.06),
                              Center(
                                child: Text(
                                  'No Emergency Contact Details found',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          mediumSpace(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        data: (user) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: const CustomAppBar(
              title: 'Personal Details',
              allowBackButton: false,
            ),
            drawer: const HomeDrawer(),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  verticalSpace(context, 0.15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 27),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back,
                                color: Color(0xff444444),
                              ),
                            ),
                          ],
                        ),
                        smallSpace(),
                        buildRecordTile(
                          title: 'Emergency Contact Details',
                          icon: SvgAssets.medx,
                          isSvg: false,
                          isSubtitle: false,
                          isCircle: true,
                          dropDown: true,
                          onTap: () {},
                        ),
                        smallSpace(),
                        Column(
                          children: [
                            AppInput(
                              inLineLabel: 'Firstname',
                              initialText: user.firstName,
                              readOnly: true,
                            ),
                            tinySpace(),
                            AppInput(
                              inLineLabel: 'Lastname',
                              initialText: user.lastName,
                              readOnly: true,
                            ),
                            tinySpace(),
                            AppInput(
                              inLineLabel: 'Relationship',
                              initialText: user.relationship,
                              readOnly: true,
                            ),
                            tinySpace(),
                            AppInput(
                              inLineLabel: 'Phone Number',
                              initialText: user.phone,
                              readOnly: true,
                            ),
                            tinySpace(),
                            AppInput(
                              inLineLabel: 'Email Address',
                              initialText: user.email,
                              readOnly: true,
                            ),
                            tinySpace(),
                            AppInput(
                              inLineLabel: 'Contact Address',
                              initialText: user.contactAddress,
                              readOnly: true,
                            ),
                            tinySpace(),
                            AppInput(
                              inLineLabel: 'State of Residence',
                              initialText: user.stateOfResidence,
                              readOnly: true,
                            ),
                            tinySpace(),
                            AppInput(
                              inLineLabel: 'LGA',
                              initialText: user.lga,
                              readOnly: true,
                            ),
                            tinySpace(),
                            AppInput(
                              inLineLabel: 'City',
                              initialText: user.city,
                              readOnly: true,
                            ),
                            tinySpace(),
                            AppInput(
                              inLineLabel: 'Alt Phone Number',
                              initialText: user.altPhone,
                              readOnly: true,
                            ),
                          ],
                        ),
                        mediumSpace(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
