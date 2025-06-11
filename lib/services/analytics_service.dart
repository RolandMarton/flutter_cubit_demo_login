import 'dart:convert';

import 'package:login_cubit_test/repository/database_helper.dart';

class AnalyticsService {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<List<Map<String, dynamic>>> getAllLogs() async {
    final db = await _dbHelper.database;
    return db.query('logs', orderBy: 'timestamp DESC');
  }

  Future<void> clearAllLogs() async {
    final db = await _dbHelper.database;
    await db.delete('logs');
  }

  Future<void> logEvent(String event, {Map<String, dynamic>? params}) async {
    final db = await _dbHelper.database;
    await db.insert('logs', {
      'event': event,
      'params': params != null ? jsonEncode(params) : null,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }
}
