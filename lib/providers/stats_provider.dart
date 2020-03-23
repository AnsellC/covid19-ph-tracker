import 'dart:async';
import 'dart:io';

import 'package:covid/models/stats.dart';
import 'package:covid/resources/stats_resource.dart';
import 'package:flutter/foundation.dart';

class StatsProvider with ChangeNotifier {
  final StatsResource statsResource = StatsResource();
  Stats stats;
  bool timedOut = false;

  StatsProvider() {
    get();
  }

  Future<void> get() async {
    try {
      stats = await statsResource.getStats();
    } on TimeoutException catch (_) {
      timedOut = true;
    } on SocketException catch (_) {
      timedOut = true;
    }

    notifyListeners();
  }

  void refresh() async {
    stats = null;
    timedOut = false;
    notifyListeners();
    get();
  }
}
