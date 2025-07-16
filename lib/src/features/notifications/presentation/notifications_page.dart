import 'package:intl/intl.dart';

import '../../../provider/all_providers.dart';
import '../../../utils/packages.dart';

class NotificationPage extends ConsumerStatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  ConsumerState<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends ConsumerState<NotificationPage> {
  final TextEditingController _searchController = TextEditingController();
  String selectedCategory = 'All';

  void _openFilterSheet(List<String> categories) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors
          .white, // surfaceTint white effect can be done by white for simplicity
      builder: (_) {
        return Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: categories
                    .map((type) => ListTile(
                          title: Text(type),
                          trailing: selectedCategory == type
                              ? const Icon(Icons.check, color: Colors.green)
                              : null,
                          onTap: () {
                            setState(() => selectedCategory = type);
                            Navigator.pop(context);
                          },
                        ))
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final asyncNotifications = ref.watch(userNotificationProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          verticalSpace(context, 0.06),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CustomHeader(
              title: 'Notifications',
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const Divider(color: ColorConstant.primaryColor, thickness: 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xffE6E6E6)),
                      ),
                    ),
                    onChanged: (value) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 10),
                asyncNotifications.maybeWhen(
                  data: (notifications) {
                    final Set<String> categories = {
                      'All',
                      ...notifications.map((n) => n.type),
                    };
                    return GestureDetector(
                      onTap: () => _openFilterSheet(categories.toList()),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                8,
                              ),
                              color: Color(0xffF3F9F3)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 8),
                            child: Icon(Icons.filter_list,
                                size: 30, color: Colors.grey[700]),
                          )),
                    );
                  },
                  orElse: () =>
                      Icon(Icons.filter_list, color: Colors.grey[700]),
                ),
              ],
            ),
          ),

          /// Category Chips - Horizontal Scroll
          asyncNotifications.when(
            data: (notifications) {
              final Set<String> categories = {
                'All',
                ...notifications.map((n) => n.type),
              };

              return SizedBox(
                height: 45,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  children: categories.map((type) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(type),
                        selected: selectedCategory == type,
                        onSelected: (_) =>
                            setState(() => selectedCategory = type),
                        selectedColor: ColorConstant.primaryColor,
                        backgroundColor: Colors.white, // unselected background
                        labelStyle: TextStyle(
                          color: selectedCategory == type
                              ? Colors.white
                              : const Color(0xff202325),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5), // radius 5
                          side: BorderSide(
                            color: selectedCategory == type
                                ? Colors.transparent
                                : ColorConstant.primaryColor
                                    .withOpacity(0.4), // unselected border
                          ),
                        ),
                        showCheckmark: false,
                      ),
                    );
                  }).toList(),
                ),
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (e, _) => const SizedBox.shrink(),
          ),

          smallSpace(),

          /// Notifications List
          Expanded(
            child: asyncNotifications.when(
              data: (notifications) {
                final filtered = notifications.where((n) {
                  final matchesCategory =
                      selectedCategory == 'All' || n.type == selectedCategory;
                  final matchesSearch = _searchController.text.isEmpty ||
                      n.title
                          .toLowerCase()
                          .contains(_searchController.text.toLowerCase()) ||
                      n.message
                          .toLowerCase()
                          .contains(_searchController.text.toLowerCase());
                  return matchesCategory && matchesSearch;
                }).toList();

                if (filtered.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'No notifications found.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: filtered.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final item = filtered[index];
                    return Column(
                      children: [
                        ListTile(
                          leading: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: const Color(0xffF3F9F3),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.notifications_active,
                                  color: ColorConstant.primaryColor, size: 35),
                            ),
                          ),
                          title: RichText(
                            text: TextSpan(
                              text: '${item.title} ',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                  text: item.message,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.green),
                                ),
                              ],
                            ),
                          ),
                          subtitle: Text(
                            DateFormat.yMMMMEEEEd()
                                .add_jm()
                                .format(item.createdAt),
                          ),
                        ),
                        const Divider(
                          color: Color(0xFFE0E0E0), // light grey line
                          thickness: 1,
                          indent: 16,
                          endIndent: 16,
                        ),
                      ],
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
    );
  }
}
