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

    setState(() {
      _logs = logs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin - Analytics Logs')),
      body: ListView.builder(
        itemCount: _logs.length,
        itemBuilder: (context, index) {
          final log = _logs[index];
          final params = log['params'] ?? '{}';
          return ListTile(title: Text(log['event']), subtitle: Text('Params: $params\nAt: ${log['timestamp']}'));
        },
      ),
    );
  }
}
