class CancelConfirmationModal extends StatelessWidget {
  final VoidCallback onConfirm;

  const CancelConfirmationModal({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Cancel Appointment',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
          ),
          const SizedBox(height: 10),
          const Text(
            'Are you sure you want to cancel your appointment?',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              minimumSize: const Size.fromHeight(50),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm();
            },
            child: const Text('Yes, Cancel'),
          ),
          const SizedBox(height: 10),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.red.shade50,
              minimumSize: const Size.fromHeight(50),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Back', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
