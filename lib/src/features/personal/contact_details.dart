import '../../provider/all_providers.dart';
import '../../utils/packages.dart';

class HealthContactDetails extends ConsumerStatefulWidget {
  const HealthContactDetails({super.key});

  @override
  ConsumerState<HealthContactDetails> createState() =>
      _HealthContactDetailsState();
}

class _HealthContactDetailsState extends ConsumerState<HealthContactDetails> {
  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userContactProvider);

    return userAsync.when(
        loading: () => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
        error: (error, _) => Scaffold(
              body: Center(child: Text('Error loading contact details')),
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
                            InkWell(
                              onTap: () {
                                context.push(
                                  Routes.USEREMERGENCY,
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'Emergency Contact',
                                    style: CustomTextStyle.textsmall15.w400
                                        .withColorHex(0xff343333),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward,
                                    color: Color(0xff444444),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        smallSpace(),
                        buildRecordTile(
                          title: 'Contact Details',
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
                            const AppInput(
                              inLineLabel: 'Country of Residence',
                              initialText: 'Nigeria',
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
                              initialText: user.lgaResidence,
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
                              inLineLabel: 'Home Address',
                              initialText: user.homeAddress,
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
                              inLineLabel: 'Alt Phone #',
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
