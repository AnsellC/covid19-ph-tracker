import 'package:covid/providers/stats_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  final boxTween1 = MultiTrackTween([
    Track('position').add(
      Duration(milliseconds: 1000),
      Tween(
        begin: -10.0,
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

  final boxTween2 = MultiTrackTween([
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

  Widget _box(BuildContext context, String title, String content) {
    return Container(
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
            title,
            style: Theme.of(context).textTheme.title,
          ),
          Text(
            content,
            style: Theme.of(context).textTheme.subtitle,
          ),
        ],
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
                // Confirmed Cases Box
                Expanded(
                  child: ControlledAnimation(
                    duration: boxTween1.duration,
                    tween: boxTween1,
                    builder: (BuildContext context, animation) {
                      return Opacity(
                        opacity: animation['opacity'],
                        child: Transform.translate(
                          offset: Offset(0.0, animation['position']),
                          child: _box(
                            context,
                            'Confirmed Cases',
                            provider.stats.confirmed.toString(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ControlledAnimation(
                    duration: boxTween1.duration,
                    tween: boxTween1,
                    builder: (BuildContext context, animation) {
                      return Opacity(
                        opacity: animation['opacity'],
                        child: Transform.translate(
                          offset: Offset(0.0, animation['position']),
                          child: _box(
                            context,
                            'Recovered',
                            provider.stats.recovered.toString(),
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
                    duration: boxTween2.duration,
                    tween: boxTween2,
                    builder: (BuildContext context, animation) {
                      return Opacity(
                        opacity: animation['opacity'],
                        child: Transform.translate(
                          offset: Offset(0.0, animation['position']),
                          child: _box(
                            context,
                            'Deaths',
                            provider.stats.deaths.toString(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ControlledAnimation(
                    duration: boxTween2.duration,
                    tween: boxTween2,
                    builder: (BuildContext context, animation) {
                      return Opacity(
                        opacity: animation['opacity'],
                        child: Transform.translate(
                          offset: Offset(0.0, animation['position']),
                          child: _box(
                            context,
                            'Death Rate',
                            '${provider.stats.deathRate.toString()}%',
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
