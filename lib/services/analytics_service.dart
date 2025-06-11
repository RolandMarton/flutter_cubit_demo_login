import 'dart:convert';

import 'package:login_cubit_test/repository/database_helper.dart';

class AnalyticsService {
  final List<Map<String, dynamic>> _logs = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();

  List<Map<String, dynamic>> get logs => List.unmodifiable(_logs);

  Future<void> logEvent(String event, {Map<String, dynamic>? params}) async {
    final logEntry = {
      'event': event,
      'params': params != null ? jsonEncode(params) : null,
      'timestamp': DateTime.now().toIso8601String(),
    };
    _logs.add(logEntry);

    final db = await _dbHelper.database;
    await db.insert('logs', logEntry);
  }

  Future<List<Map<String, dynamic>>> getAllLogs() async {
    final db = await _dbHelper.database;
    final logsFromDb = await db.query('logs', orderBy: 'timestamp DESC');
    return logsFromDb;
  }
}
