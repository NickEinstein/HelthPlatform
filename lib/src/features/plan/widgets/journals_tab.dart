import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';

class Journal {
  final String id;
  final String title;
  final String content;
  final DateTime date;

  Journal({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
  });

  factory Journal.fromJson(Map<String, dynamic> json) {
    return Journal(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date.toIso8601String(),
    };
  }
}

final journalListProvider = FutureProvider<List<Journal>>((ref) async {

  return [
    Journal(
      id: '1',
      title: 'Few hair loss 3rd day in to this program',
      content:
          'Your journal helps you document your progress, achievements and observations as you crush your goals.',
      date: DateTime(2025, 9, 5, 14, 0),
    ),
    Journal(
      id: '2',
      title: 'Feeling energized today',
      content:
          'This is my second journal entry. Feeling much better with the new routine.',
      date: DateTime(2025, 9, 4, 10, 30),
    ),
    Journal(
      id: '3',
      title: 'First day progress',
      content: 'Starting my journey today. Excited to see the results.',
      date: DateTime(2025, 9, 3, 9, 0),
    ),
  ];
});

// Notifier for managing journal state
class JournalNotifier extends StateNotifier<AsyncValue<List<Journal>>> {
  JournalNotifier() : super(const AsyncValue.loading());

  Future<void> fetchJournals() async {
    state = const AsyncValue.loading();
    try {
      await Future.delayed(const Duration(seconds: 1));
      state = AsyncValue.data([
        Journal(
          id: '1',
          title: 'Few hair loss 3rd day in to this program',
          content:
              'Your journal helps you document your progress, achievements and observations as you crush your goals.',
          date: DateTime(2025, 9, 5, 14, 0),
        ),
      ]);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> addJournal(Journal journal) async {
  }
}

final journalNotifierProvider =
    StateNotifierProvider<JournalNotifier, AsyncValue<List<Journal>>>((ref) {
  return JournalNotifier();
});

class JournalsTab extends ConsumerStatefulWidget {
  const JournalsTab({super.key});

  @override
  ConsumerState<JournalsTab> createState() => _JournalsTabState();
}

class _JournalsTabState extends ConsumerState<JournalsTab> {
  // Hold the latest journal before sending to backend
  Journal? _pendingJournal;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    // Fetch journals when widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(journalNotifierProvider.notifier).fetchJournals();
    });
  }

  void _createNewJournal() {
    setState(() {
      _pendingJournal = Journal(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: 'New Journal Entry',
        content: 'This is a new journal entry that will be sent to backend',
        date: DateTime.now(),
      );
    });

    _showPendingJournalDialog();
  }

  Future<void> _savePendingJournal() async {
    if (_pendingJournal == null) return;

    setState(() {
      _isSaving = true;
    });

    try {
      await ref
          .read(journalNotifierProvider.notifier)
          .addJournal(_pendingJournal!);

      if (mounted) {
        setState(() {
          _pendingJournal = null;
          _isSaving = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Journal saved successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving journal: $e')),
        );
      }
    }
  }

  void _showPendingJournalDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Save Journal?'),
        content: Text(_pendingJournal?.title ?? 'No title'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _pendingJournal = null;
              });
              Navigator.pop(context);
            },
            child: const Text('Discard'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _savePendingJournal();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final journalsAsync = ref.watch(journalNotifierProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello Gabriella,',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          10.height,
          Text(
            'Your journal helps you document your progress, achievements and observations as you crush your goals.',
            style: context.textTheme.bodyMedium?.copyWith(
              height: 1.5,
            ),
          ),
          20.height,

          if (_pendingJournal != null) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.shade300),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.orange),
                  10.width,
                  Expanded(
                    child: Text(
                      'You have an unsaved journal entry',
                      style: context.textTheme.bodySmall,
                    ),
                  ),
                  if (_isSaving)
                    const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  else
                    TextButton(
                      onPressed: _savePendingJournal,
                      child: const Text('Save'),
                    ),
                ],
              ),
            ),
            20.height,
          ],

          // Actions
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Color(0xFF8CEE8C), // Light green
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.mic, color: Colors.white),
              ),
              10.width,
              Expanded(
                child: ElevatedButton(
                  onPressed: _createNewJournal,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF98FB98), // Pale green
                    foregroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: const BorderSide(color: Color(0xFF109615)),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Make a Note',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          20.height,

          journalsAsync.when(
            data: (journals) {
              if (journals.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Text(
                      'No journals yet. Start writing!',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: journals.length,
                itemBuilder: (context, index) {
                  return _buildJournalCard(context, journals[index]);
                },
              );
            },
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(40.0),
                child: CircularProgressIndicator(),
              ),
            ),
            error: (error, stack) => Center(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    Text(
                      'Error loading journals',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: Colors.red,
                      ),
                    ),
                    10.height,
                    ElevatedButton(
                      onPressed: () {
                        ref
                            .read(journalNotifierProvider.notifier)
                            .fetchJournals();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildJournalCard(BuildContext context, Journal journal) {
  return Container(
    margin: const EdgeInsets.only(bottom: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      journal.title,
                      style: context.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    5.height,
                    Text(
                      journal.content,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade700,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: const BoxDecoration(
            color: Color(0xFFDCF8C6), // Light green footer
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Row(
            children: [
              const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
              5.width,
              Text(
                '${_formatMonth(journal.date.month)} ${journal.date.day}, ${journal.date.year}',
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                ),
              ),
              20.width,
              const Icon(Icons.access_time, size: 14, color: Colors.grey),
              5.width,
              Text(
                '${journal.date.hour}:${journal.date.minute.toString().padLeft(2, '0')}${journal.date.hour >= 12 ? 'pm' : 'am'}',
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

String _formatMonth(int month) {
  const months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  return months[month - 1];
}
