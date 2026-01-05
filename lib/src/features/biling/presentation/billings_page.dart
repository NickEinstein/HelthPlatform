import '../../../provider/all_providers.dart';
import '../../../provider/index_provider.dart';
import '../../../utils/packages.dart';
import '../model/billing_response.dart';

class BillingsPage extends ConsumerStatefulWidget {
  const BillingsPage({super.key});

  @override
  ConsumerState<BillingsPage> createState() => _HealthInsurancePageState();
}

class _HealthInsurancePageState extends ConsumerState<BillingsPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Billings',
      ),
      drawer: const HomeDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(27).copyWith(bottom: 0),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    ref.read(indexProvider.notifier).state = 0;
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(SvgAssets.arrowBack),
                      11.gap,
                      // Text(
                      //   'HMO Insurance',
                      //   style: CustomTextStyle.textsmall15.w500,
                      // )
                    ],
                  ),
                ),
                18.gap,
                InkWell(
                  onTap: () {
                    // pushTo(const ContactPharmarcyPage());
                  },
                  child: Container(
                    decoration: ShapeDecoration(
                      color: const Color(0xffDCFEDE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          SvgAssets.billingsPill,
                        ),
                        26.gap,
                        Consumer(
                          builder: (context, ref, child) {
                            final billingAsync = ref.watch(userBillingProvider);

                            return billingAsync.when(
                              data: (billingList) {
                                final totalPaymentBreakdowns = billingList
                                    .expand((billing) =>
                                        billing.paymentBreakdowns ?? [])
                                    .length;

                                return Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Billing History',
                                        style: CustomTextStyle.textsmall15.w700
                                            .withColorHex(0xff343333),
                                      ),
                                      5.gap,
                                      Text(
                                        '$totalPaymentBreakdowns Items',
                                        style: CustomTextStyle.textxSmall13
                                            .withColorHex(0xff909090),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              loading: () => const Center(
                                  child: CircularProgressIndicator()),
                              error: (e, _) => const Center(
                                  child: Text('Error loading billings')),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Expanded(child: InsuranceWidget()),
        ],
      ),
    );
  }
}

class InsuranceWidget extends ConsumerWidget {
  const InsuranceWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final billings = ref.watch(userBillingProvider);

    return billings.when(
      data: (billingData) {
        if (billingData.isEmpty) {
          return const Center(child: Text('No billing data available.'));
        }

        return RefreshIndicator.adaptive(
          onRefresh: () async {
            // ignore: unused_result
            ref.refresh(userBillingProvider);
          },
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 17),
            itemCount: billingData.length,
            separatorBuilder: (context, index) => 17.gap,
            itemBuilder: (context, index) {
              final item = billingData[index];
              return InsuranceCoverageBox(billing: item);
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator.adaptive()),
      error: (error, stackTrace) =>
          const Center(child: Text('Error loading billing data')),
    );
  }
}

class InsuranceCoverageBox extends ConsumerStatefulWidget {
  final BillingResponse billing;
  const InsuranceCoverageBox({super.key, required this.billing});

  @override
  ConsumerState<InsuranceCoverageBox> createState() =>
      _InsuranceCoverageBoxState();
}

class _InsuranceCoverageBoxState extends ConsumerState<InsuranceCoverageBox> {
  bool showDetails = false;
  late final List<(String, String)> items = widget.billing.paymentBreakdowns
          ?.map((e) => (e.productName ?? '', '₦${e.cost ?? 0}'))
          .toList() ??
      [];

  @override
  Widget build(BuildContext context) {
    final breakdowns = widget.billing.paymentBreakdowns ?? [];

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xffF5F5F5),
            borderRadius: BorderRadius.circular(7),
            border: Border.all(
              width: 0.5,
              color: const Color(0xffAEAEAE),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: InkWell(
                  onTap: () => setState(() => showDetails = !showDetails),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${widget.billing.diagnosis ?? 'No Diagnosis'}:',
                          style: CustomTextStyle.textsmall14.w700
                              .withColorHex(0xff393939),
                        ),
                      ),
                      Text(
                        '₦${widget.billing.totalCost ?? 0}',
                        textAlign: TextAlign.right,
                        style: CustomTextStyle.textsmall14.black,
                      ),
                      Icon(
                        showDetails
                            ? Icons.keyboard_arrow_down_rounded
                            : Icons.keyboard_arrow_right_rounded,
                        color: const Color(0xffB3B3B3),
                      ),
                    ],
                  ),
                ),
              ),
              if (showDetails) ...[
                Container(
                  width: double.infinity,
                  decoration: const ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.5, color: Color(0xFFCACACA)),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7),
                        topRight: Radius.circular(7),
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 231,
                            child: Text('Items',
                                style: CustomTextStyle.textsmall14.w700
                                    .withColorHex(0xff393939)),
                          ),
                          10.gap,
                          Expanded(
                            flex: 91,
                            child: Text('Cost',
                                style: CustomTextStyle.textsmall14.w700
                                    .withColorHex(0xff393939)),
                          ),
                        ],
                      ),
                      6.gap,
                      for (var (index, item) in items.indexed) ...[
                        _DetailRow('${index + 1}. ${item.$1}', item.$2),
                        _DetailRow('Patient Deposit',
                            '₦${breakdowns[index].patientDeposit ?? 0}'),
                        _DetailRow(
                            'Due Payment', '₦${breakdowns[index].duePay ?? 0}'),
                        _DetailRow('HMO Covers',
                            breakdowns[index].hmoCover == 0 ? 'No' : 'Yes'),
                        _DetailRow('HMO Balance',
                            '₦${breakdowns[index].hmoBalance ?? 0}'),
                        _DetailRow(
                            'Status', breakdowns[index].status ?? 'Unknown'),
                        3.gap,
                      ],
                    ],
                  ),
                ),
                _SummaryRow(
                    title: 'Total Bill',
                    value: '₦${widget.billing.totalCost ?? 0}'),
                const Divider(
                    color: Color(0xffAEAEAE), height: 0.5, thickness: 0.5),
                _SummaryRow(
                    title: 'HMO Cover',
                    value: '₦${widget.billing.totalHMOCover ?? 0}'),
                const Divider(
                    color: Color(0xffAEAEAE), height: 0.5, thickness: 0.5),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 231,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Balance ',
                                style: CustomTextStyle.textsmall14.w700
                                    .withColorHex(0xff393939),
                              ),
                              TextSpan(
                                text: '(Patient’s balance)',
                                style: CustomTextStyle.textsmall14
                                    .withColorHex(0xff393939),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 91,
                        child: Text(
                          '₦${widget.billing.patientTotalBalance ?? 0}',
                          style: CustomTextStyle.textsmall14
                              .withColorHex(0xff393939),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                    color: Color(0xffAEAEAE), height: 0.5, thickness: 0.5),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.billing.visitStartedOn ?? '',
                          style: const TextStyle(
                            color: Color(0xFF797979),
                            fontSize: 13,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                      // SvgPicture.asset(SvgAssets.pdfIcon),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String title;
  final String value;
  const _DetailRow(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 231,
            child: Text(title,
                style: CustomTextStyle.textsmall14.withColorHex(0xff393939)),
          ),
          10.gap,
          Expanded(
            flex: 91,
            child: Text(value,
                style: CustomTextStyle.textsmall14.withColorHex(0xff393939)),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String title;
  final String value;
  const _SummaryRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            flex: 231,
            child: Text(title,
                style:
                    CustomTextStyle.textsmall14.w700.withColorHex(0xff393939)),
          ),
          10.gap,
          Expanded(
            flex: 91,
            child: Text(value,
                style: CustomTextStyle.textsmall14.withColorHex(0xff393939)),
          ),
        ],
      ),
    );
  }
}

class HmoProviderWidget extends StatelessWidget {
  const HmoProviderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(27).copyWith(top: 12),
      children: [
        const AppInput(
          initialText: 'AXA Mansard Insurance',
          readOnly: true,
        ),
        13.gap,
        const AppInput(
          inLineLabel: 'HMO Class',
          initialText: 'Gold',
          readOnly: true,
        ),
        13.gap,
        const AppInput(
          inLineLabel: 'Patient’s #ID',
          initialText: 'AX90248084804',
          readOnly: true,
        ),
        13.gap,
        const AppInput(
          inLineLabel: 'Validity',
          initialText: 'November 30, 2025',
          readOnly: true,
        ),
      ],
    );
  }
}
