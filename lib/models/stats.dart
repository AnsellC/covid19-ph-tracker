class Stats {
  int confirmed;
  int recovered;
  int deaths;
  DateTime lastUpdated;
  double deathRate;

  Stats({
    this.confirmed,
    this.deaths,
    this.recovered,
    this.deathRate,
    this.lastUpdated,
  });

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      confirmed: json['confirmed']['value'],
      recovered: json['recovered']['value'],
      deaths: json['deaths']['value'],
      deathRate: json['confirmed']['value'] / json['deaths']['value'],
      lastUpdated: DateTime.parse(json['lastUpdate']),
    );
  }
}
