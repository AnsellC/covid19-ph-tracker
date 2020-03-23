import 'dart:convert';

import 'package:covid/models/stats.dart';
import 'package:http/http.dart';

class StatsResource {
  Client client = Client();

  Future<Stats> getStats() async {
    final response =
        await client.get('https://covid19.mathdro.id/api/countries/ph');

    if (response.statusCode != 200) {
      return null;
    }
    return Stats.fromJson(jsonDecode(response.body));
  }
}
