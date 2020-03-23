import 'package:covid/models/stats.dart';
import 'package:covid/resources/stats_resource.dart';
import 'package:flutter/foundation.dart';

class StatsProvider with ChangeNotifier {
  final StatsResource statsResource = StatsResource();
  Stats stats;

  StatsProvider() {
    get();
  }

  Future<void> get() async {
    stats = await statsResource.getStats();
    notifyListeners();
  }

  void refresh() async {
    stats = null;
    notifyListeners();
    get();
  }
}
