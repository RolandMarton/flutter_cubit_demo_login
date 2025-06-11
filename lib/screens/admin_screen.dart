import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:login_cubit_test/services/analytics_service.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<Map<String, dynamic>> _logs = [];

  @override
  void initState() {
    super.initState();
    _loadLogs();
  }

  Future<void> _loadLogs() async {
    final logs = await context.read<AnalyticsService>().getAllLogs();
    setState(() => _logs = logs);
  }

  Future<void> _clearLogs() async {
    await context.read<AnalyticsService>().clearAllLogs();
    await _loadLogs(); // refresh after clearing
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin - Analytics Logs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            tooltip: 'Clear Logs',
            onPressed: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: const Text('Clear all logs?'),
                      content: const Text('Are you sure you want to delete all analytics logs?'),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                        TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete')),
                      ],
                    ),
              );
              if (confirmed == true) {
                await _clearLogs();

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Logs cleared')));
                }
              }
            },
          ),
        ],
      ),
      body:
          _logs.isEmpty
              ? const Center(child: Text('No logs found'))
              : ListView.builder(
                itemCount: _logs.length,
                itemBuilder: (context, index) {
                  final log = _logs[index];
                  final params = log['params'] ?? '{}';
                  return ListTile(
                    title: Text(log['event']),
                    subtitle: Text('Params: $params\nAt: ${log['timestamp']}'),
                  );
                },
              ),
    );
  }
}
