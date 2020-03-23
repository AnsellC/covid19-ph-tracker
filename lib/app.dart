import 'package:covid/providers/stats_provider.dart';
import 'package:covid/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CovidApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid PH',
      theme: ThemeData(
        textTheme: TextTheme(
          headline: TextStyle(
            color: Colors.white,
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
          ),
          title: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w300,
          ),
          subtitle: TextStyle(
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
      home: ChangeNotifierProvider<StatsProvider>(
        create: (_) => StatsProvider(),
        child: HomeScreen(),
      ),
    );
  }
}
