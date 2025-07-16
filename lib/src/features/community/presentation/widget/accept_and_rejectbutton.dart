import 'package:flutter/material.dart';

class AcceptRejectButtons extends StatelessWidget {
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final bool isLoading;

  const AcceptRejectButtons({
    Key? key,
    required this.onAccept,
    required this.onReject,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: isLoading ? null : onAccept,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Accept'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: isLoading ? null : onReject,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Reject'),
              ),
            ],
          );
  }
}
