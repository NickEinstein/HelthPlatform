import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greenzone_medical/src/features/plan/models/user_journal_model.dart';
import 'package:greenzone_medical/src/model/regular_app_model.dart';
import 'package:greenzone_medical/src/provider/my_goal_provider.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';

class JournalsTab extends ConsumerStatefulWidget {
  final RegularAppModel app;
  const JournalsTab({
    super.key,
    required this.app,
  });

  @override
  ConsumerState<JournalsTab> createState() => _JournalsTabState();
}

class _JournalsTabState extends ConsumerState<JournalsTab> {
  List<UserJournalModel> _journals = [];
  final progressController = TextEditingController();
  final currentValueController = TextEditingController();

  @override
  void initState() {
    super.initState();
    refreshUserJournals();
  }

  void refreshUserJournals() async {
    final journals = await ref
        .read(myGoalServiceProvider)
        .getUserGoalJournals(widget.app.id);

    if (journals.isNotEmpty && mounted) {
      setState(() {
        _journals = journals;
      });
    }
  }

  Future<void> _createNewJournal() async {
    progressController.clear();
    currentValueController.clear();
    final newJournal = await showModalBottomSheet<UserJournalModel?>(
      context: context,
      isScrollControlled: true,
      builder: (bottomSheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add an Entry',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: progressController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Progress',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: currentValueController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Current Value',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(bottomSheetContext),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      final progress = int.tryParse(progressController.text);
                      final currentValue =
                          int.tryParse(currentValueController.text);

                      if (progress != null && currentValue != null) {
                        final newJournal = UserJournalModel(
                          goalId: widget.app.id,
                          entryDate: DateTime.now(),
                          progress: progress,
                          currentValue: currentValue,
                        );
                        Navigator.pop(bottomSheetContext, newJournal);
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );

    if (newJournal is UserJournalModel) {
      print('Prev: ${_journals.length}');
      setState(() {
        _journals = [newJournal, ..._journals];
      });

      print('Curr : ${_journals.length}');
      _savePendingJournal();
    }
  }

  Future<void> _savePendingJournal() async {
    if (_journals.isEmpty) return;

    try {
      final didSave =
          await ref.read(myGoalServiceProvider).saveJournal(_journals.last);

      if (mounted && didSave) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Journal saved successfully!')),
        );
      }
      if (!didSave) {
        throw Exception('Failed to save journal');
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _journals.removeLast();
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving journal: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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

          // Actions
          Row(
            children: [
              // Container(
              //   padding: const EdgeInsets.all(12),
              //   decoration: const BoxDecoration(
              //     color: Color(0xFF8CEE8C), // Light green
              //     shape: BoxShape.circle,
              //   ),
              //   child: const Icon(Icons.mic, color: Colors.white),
              // ),
              // 10.width,
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
                  child: const Text(
                    'Add an entry',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          20.height,

          if (_journals.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Text(
                  'No journals yet. Start writing!',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          if (_journals.isNotEmpty)
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _journals.length,
              itemBuilder: (context, index) {
                return _buildJournalCard(context, _journals[index]);
              },
            ),
        ],
      ),
    );
  }
}

Widget _buildJournalCard(BuildContext context, UserJournalModel journal) {
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
                      'Current Value: ${journal.currentValue}',
                      style: context.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    5.height,
                    Text(
                      'Progress: ${journal.progress}',
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
                '${_formatMonth(journal.entryDate.month)} ${journal.entryDate.day}, ${journal.entryDate.year}',
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                ),
              ),
              20.width,
              const Icon(Icons.access_time, size: 14, color: Colors.grey),
              5.width,
              Text(
                '${journal.entryDate.hour}:${journal.entryDate.minute.toString().padLeft(2, '0')}${journal.entryDate.hour >= 12 ? 'pm' : 'am'}',
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
