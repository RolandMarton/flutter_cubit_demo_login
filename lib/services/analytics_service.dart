class AnalyticsService {
  void logEvent(String event, {Map<String, dynamic>? params}) {
    final timestamp = DateTime.now().toIso8601String();

    print('[Analytics][$timestamp] $event ${params ?? ""}');
  }
}
