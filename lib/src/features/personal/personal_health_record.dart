import '../../provider/all_providers.dart';
import '../../utils/packages.dart';

class PersonalDataScreen extends ConsumerStatefulWidget {
  const PersonalDataScreen({super.key});

  @override
  ConsumerState<PersonalDataScreen> createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends ConsumerState<PersonalDataScreen> {
  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userProvider);

    return userAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => const Scaffold(
        body: Center(child: Text('Error loading personal details')),
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
                            onTap: () => Navigator.pop(context),
                            child: const Icon(Icons.arrow_back,
                                color: Color(0xff444444)),
                          ),
                          InkWell(
                            onTap: () {
                              context.push(
                                Routes.USERCONTACT,
                              );
                              // Navigate to contact details
                            },
                            child: Row(
                              children: [
                                Text(
                                  'Contact Details',
                                  style: CustomTextStyle.textsmall15.w400
                                      .withColorHex(0xff343333),
                                ),
                                const Icon(Icons.arrow_forward,
                                    color: Color(0xff444444)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      smallSpace(),
                      buildRecordTile(
                        title: 'Personal Data',
                        icon: SvgAssets.medx,
                        isSvg: false,
                        isSubtitle: false,
                        isCircle: true,
                        dropDown: true,
                        onTap: () {},
                      ),
                      smallSpace(),
                      AppInput(
                          inLineLabel: 'Firstname',
                          initialText: '${user.firstName}',
                          readOnly: true),
                      tinySpace(),
                      AppInput(
                          inLineLabel: 'Lastname',
                          initialText: '${user.lastName}',
                          readOnly: true),
                      tinySpace(),
                      AppInput(
                          inLineLabel: 'Gender',
                          initialText: '${user.gender}',
                          readOnly: true),
                      tinySpace(),
                      AppInput(
                        inLineLabel: 'Date of Birth',
                        initialText: '${user.dateOfBirth?.split("T").first}',
                        readOnly: true,
                      ),
                      tinySpace(),
                      AppInput(
                          inLineLabel: 'Nationality',
                          initialText: '${user.nationality}',
                          readOnly: true),
                      tinySpace(),
                      AppInput(
                          inLineLabel: 'State of Origin',
                          initialText: '${user.stateOfOrigin}',
                          readOnly: true),
                      tinySpace(),
                      AppInput(
                          inLineLabel: 'LGA',
                          initialText: '${user.lga}',
                          readOnly: true),
                      tinySpace(),
                      AppInput(
                          inLineLabel: 'Place of Birth',
                          initialText: '${user.placeOfBirth}',
                          readOnly: true),
                      tinySpace(),
                      AppInput(
                          inLineLabel: 'Marital Status',
                          initialText: '${user.maritalStatus}',
                          readOnly: true),
                      mediumSpace()
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
