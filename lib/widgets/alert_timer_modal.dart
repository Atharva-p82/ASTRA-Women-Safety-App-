import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/alert_provider.dart';

class AlertTimerModal extends StatefulWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const AlertTimerModal({
    super.key,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  State<AlertTimerModal> createState() => _AlertTimerModalState();
}

class _AlertTimerModalState extends State<AlertTimerModal> {
  late Future<void> _timerFuture;

  @override
  void initState() {
    super.initState();
    _timerFuture = _startTimer();
  }

  Future<void> _startTimer() async {
    final alertProvider = Provider.of<AlertProvider>(context, listen: false);
    for (int i = 2;i > 0; i--) {
      await Future.delayed(Duration(seconds: 1));
      if (mounted) {
        alertProvider.decrementTimer();
      }
      if (alertProvider.timerSeconds == 0) {
        if (mounted) {
          widget.onConfirm();
          Navigator.pop(context);
        }
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.warning, size: 60, color: Colors.red.shade600),
            SizedBox(height: 16),
            Text(
              'Alert Triggered!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade600,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Is this a false alarm?',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
            ),
            SizedBox(height: 24),
            Consumer<AlertProvider>(
              builder: (context, alertProvider, _) {
                return Text(
                  '${alertProvider.timerSeconds} seconds',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                );
              },
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    widget.onCancel();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'False Alarm',
                    style:
                        TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    widget.onConfirm();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade600,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Confirm Alert',
                    style:
                        TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
