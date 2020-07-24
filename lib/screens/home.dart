import 'package:covid/analytics.dart';
import 'package:covid/providers/rss_provider.dart';
import 'package:covid/providers/stats_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  final formatter = new NumberFormat("#,###");
  final boxTween = MultiTrackTween([
    Track('position').add(
      Duration(milliseconds: 1000),
      Tween(
        begin: 10.0,
        end: 0.0,
      ),
      curve: Curves.elasticOut,
    ),
    Track('opacity').add(
      Duration(
        milliseconds: 300,
      ),
      Tween(
        begin: 0.0,
        end: 1.0,
      ),
      curve: Curves.easeInOut,
    ),
  ]);

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
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Tracker',
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          .copyWith(fontWeight: FontWeight.w200),
                    ),
                  ],
                ),
              ),
            ),
            provider.stats == null
                ? (provider.timedOut == false
                    ? _loading()
                    : _errorOccured(context))
                : _stats(context),
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

  Widget _refreshButton(BuildContext context) {
    final provider = Provider.of<StatsProvider>(context);
    return FlatButton(
      color: Colors.redAccent,
      child: Text(
        'Refresh',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        analytics.logEvent(name: 'refresh');
        provider.refresh();
      },
    );
  }

  Widget _loading() {
    return Expanded(
      child: SpinKitDoubleBounce(
        color: Colors.white,
      ),
    );
  }

  Widget _news(BuildContext context) {
    final rssProvider = Provider.of<RssProvider>(context);
    print(rssProvider.feed);
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'News',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Text('h');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _errorOccured(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'An error occured. Make sure you have an active internet connection.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          _refreshButton(context),
        ],
      ),
    );
  }

  Widget _box(BuildContext context, String title, String content) {
    return Container(
      margin: EdgeInsets.all(10.0),
      alignment: Alignment.center,
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
            title,
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            content,
            style: Theme.of(context).textTheme.headline5.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
          ),
        ],
      ),
    );
  }

  Widget _stats(BuildContext context) {
    final provider = Provider.of<StatsProvider>(context);
    final rssProvider = Provider.of<RssProvider>(context);

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Confirmed Cases Box
                Expanded(
                  child: ControlledAnimation(
                    duration: boxTween.duration,
                    tween: boxTween,
                    builder: (BuildContext context, animation) {
                      return Opacity(
                        opacity: animation['opacity'],
                        child: Transform.translate(
                          offset: Offset(0.0, animation['position']),
                          child: _box(
                            context,
                            'Confirmed Cases',
                            formatter.format(provider.stats.confirmed),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ControlledAnimation(
                    duration: boxTween.duration,
                    tween: boxTween,
                    builder: (BuildContext context, animation) {
                      return Opacity(
                        opacity: animation['opacity'],
                        child: Transform.translate(
                          offset: Offset(0.0, animation['position']),
                          child: _box(
                            context,
                            'Recovered',
                            formatter.format(provider.stats.recovered),
                          ),
                        ),
                      );
                    },
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
                  child: ControlledAnimation(
                    delay: Duration(
                      milliseconds: 100,
                    ),
                    duration: boxTween.duration,
                    tween: boxTween,
                    builder: (BuildContext context, animation) {
                      return Opacity(
                        opacity: animation['opacity'],
                        child: Transform.translate(
                          offset: Offset(0.0, animation['position']),
                          child: _box(
                            context,
                            'Deaths',
                            formatter.format(provider.stats.deaths),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ControlledAnimation(
                    delay: Duration(
                      milliseconds: 100,
                    ),
                    duration: boxTween.duration,
                    tween: boxTween,
                    builder: (BuildContext context, animation) {
                      return Opacity(
                        opacity: animation['opacity'],
                        child: Transform.translate(
                          offset: Offset(0.0, animation['position']),
                          child: _box(
                            context,
                            'Death Rate',
                            '${provider.stats.deathRate.toStringAsFixed(1)}%',
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            "last updated: ${timeago.format(provider.stats.lastUpdated)}",
            style: Theme.of(context).textTheme.caption.copyWith(
                  fontWeight: FontWeight.normal,
                ),
          ),
          _refreshButton(context),
          SizedBox(
            height: 20.0,
          ),
          rssProvider.feed.isNotEmpty
              ? _news(context)
              : Container(
                  padding: EdgeInsets.all(
                    20.0,
                  ),
                  child: SpinKitWave(
                    color: Colors.white,
                  ),
                ),
        ],
      ),
    );
  }
}
