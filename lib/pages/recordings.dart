import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../layout/app_drawer.dart';
import '../layout/app_header.dart';
import '../widgets/animated_background.dart';

class RecordingsPage extends StatefulWidget {
  const RecordingsPage({super.key});

  @override
  State<RecordingsPage> createState() => _RecordingsPageState();
}

class _RecordingsPageState extends State<RecordingsPage> {
  List<Map<String, String>> _recordings = List.generate(
    5,
    (i) => {
      'title': 'Recording_${i + 1}.mp3',
      'time': 'Today at ${10 + i}:30 AM',
      'duration': '2:${45 - i}s',
    },
  );

  void _deleteRecording(int index) {
    setState(() {
      _recordings.removeAt(index);
    });
  }

  void _deleteAllRecordings() {
    setState(() {
      _recordings = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return Scaffold(
          drawer: AppDrawer(),
          appBar: AppHeader(title: "Recordings"),
          body: AnimatedBackground(
            isDark: themeProvider.isDark,
            child: SafeArea(
              child: Column(
                children: [
                  // Delete All button
                  Container(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red.shade300, size: 28),
                      tooltip: 'Delete All Recordings',
                      onPressed: _recordings.isNotEmpty ? _deleteAllRecordings : null,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _recordings.length,
                      itemBuilder: (context, index) {
                        final rec = _recordings[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: themeProvider.isDark
                                ? Colors.grey.shade900
                                : Colors.white,
                            border: Border.all(
                              color: Colors.orange.shade200,
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.orange.shade100.withOpacity(0.5),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.mic,
                                color: Colors.orange.shade400,
                                size: 32,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      rec['title']!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: themeProvider.isDark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      rec['time']!,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: themeProvider.isDark
                                            ? Colors.grey.shade400
                                            : Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    rec['duration']!,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: themeProvider.isDark
                                          ? Colors.grey.shade400
                                          : Colors.grey.shade600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.play_arrow, color: Colors.pink.shade400),
                                        onPressed: () {
                                          // TODO: Add audio playback functionality
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete, color: Colors.red.shade400),
                                        tooltip: 'Delete Recording',
                                        onPressed: () => _deleteRecording(index),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
