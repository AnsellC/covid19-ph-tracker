import 'package:covid/providers/rss_provider.dart';
import 'package:covid/providers/stats_provider.dart';
import 'package:covid/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CovidApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid PH',
      theme: ThemeData(
        textTheme: TextTheme(
          headline1: TextStyle(
            color: Colors.white,
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
          ),
          headline6: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w300,
          ),
          subtitle2: TextStyle(
            color: Colors.white,
            fontSize: 50.0,
            fontWeight: FontWeight.bold,
          ),
          caption: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
          ),
        ),
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<StatsProvider>(create: (_) => StatsProvider()),
          ChangeNotifierProvider<RssProvider>(create: (_) => RssProvider()),
        ],
        child: HomeScreen(),
      ),
    );
  }
}
