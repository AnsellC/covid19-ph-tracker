import 'package:covid/providers/stats_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StatsProvider>(context);

    return Scaffold(
      backgroundColor: Colors.red,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              flex: 0,
              child: Container(
                padding: EdgeInsets.only(top: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'CovidPH',
                      style: Theme.of(context).textTheme.headline,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Tracker',
                      style: Theme.of(context)
                          .textTheme
                          .headline
                          .copyWith(fontWeight: FontWeight.w200),
                    ),
                  ],
                ),
              ),
            ),
            provider.stats != null ? _stats(context) : _loading(),
            Flexible(
              flex: 0,
              child: Container(
                padding: EdgeInsets.only(bottom: 15.0),
                child: GestureDetector(
                  onTap: () async {
                    const url = 'https://github.com/AnsellC';
                    if (await canLaunch(url)) {
                      await launch(url);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Created by',
                        style: Theme.of(context).textTheme.display1.copyWith(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
                      ),
                      SizedBox(
                        width: 2.0,
                      ),
                      Text(
                        '@AnsellC',
                        style: Theme.of(context).textTheme.display1.copyWith(
                              color: Colors.white,
                              fontSize: 15.0,
                              decoration: TextDecoration.underline,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loading() {
    return Expanded(
      child: SpinKitDoubleBounce(
        color: Colors.white,
      ),
    );
  }

  Widget _stats(BuildContext context) {
    final provider = Provider.of<StatsProvider>(context);
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    padding: EdgeInsets.all(
                      10.0,
                    ),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Confirmed Cases',
                          style: Theme.of(context).textTheme.title,
                        ),
                        Text(
                          provider.stats.confirmed.toString(),
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    padding: EdgeInsets.all(
                      10.0,
                    ),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Recovered',
                          style: Theme.of(context).textTheme.title,
                        ),
                        Text(
                          provider.stats.recovered.toString(),
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    padding: EdgeInsets.all(
                      10.0,
                    ),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Deaths',
                          style: Theme.of(context).textTheme.title,
                        ),
                        Text(
                          provider.stats.deaths.toString(),
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    padding: EdgeInsets.all(
                      10.0,
                    ),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Death Rate',
                          style: Theme.of(context).textTheme.title,
                        ),
                        Text(
                          "${provider.stats.deathRate.toString()}%",
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          Text(
            "last updated: ${timeago.format(provider.stats.lastUpdated)}",
            style: Theme.of(context).textTheme.caption,
          ),
          SizedBox(
            height: 20.0,
          ),
          FlatButton(
            color: Colors.redAccent,
            child: Text(
              'Refresh',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              provider.refresh();
            },
          ),
        ],
      ),
    );
  }
}
