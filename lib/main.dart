import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController _controller;
  AnimationController controller;
  bool son = true;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: new Duration(seconds: 2))
          ..repeat();
  }

  List dataOne = [
    {
      'milliseconds': 60000,
      'img': 'image/3.0x/cloud_3.png',
      'width': 15.0,
      'top': 20.0
    },
    {
      'milliseconds': 60000,
      'img': 'image/3.0x/cloud_2.png',
      'width': 30.0,
      'top': 35.0
    },
    {
      'milliseconds': 60000,
      'img': 'image/3.0x/cloud_1.png',
      'width': 70.0,
      'top': 45.0
    },
    {
      'milliseconds': 60000,
      'img': 'image/3.0x/cloud_4.png',
      'width': 45.0,
      'top': 87.0
    },
    {
      'milliseconds': 60000,
      'img': 'image/3.0x/cloud_5.png',
      'width': 33.0,
      'top': 148.0
    }
  ];

  List dataTwo = [
    [50.0, 70.0, 2200, 1],
    [100.0, 90.0, 2000, 2],
    [148.0, 70.0, 2300, 3],
    [210.0, 90.0, 1800, 4],
    [260.0, 110.0, 2100, 5],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
//            Image.asset('image/3.0x/bg_bar_night.png'),
            Container(
              height: MediaQuery.of(context).size.height * 0.75,
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    son
                        ? 'image/3.0x/bg_down.png'
                        : 'image/3.0x/bg_down_night.png',
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    gaplessPlayback: true,
                  ),
                  Positioned(
                    width: MediaQuery.of(context).size.width,
                    bottom: 0,
                    child: Image.asset(
                        son
                            ? 'image/3.0x/bg_up_f.png'
                            : 'image/3.0x/bg_up_night.png',
                        gaplessPlayback: true),
                  ),
                  Positioned(
                    top: 120,
                    child: Image.asset(son ? '' : 'image/3.0x/bg_moon.png',
                        width: 70),
                  ),
                  Positioned(
                    right: 26,
                    top: MediaQuery.of(context).size.height * 0.75 * 0.6,
                    child: Image.asset(
                      son
                          ? 'image/3.0x/windmill.png'
                          : 'image/3.0x/windmill_night.png',
                      width: 25,
                      gaplessPlayback: true,
                    ),
                  ),

                  /// 风车
                  Positioned(
                    right: 13,
                    top: MediaQuery.of(context).size.height * 0.75 * 0.6 - 25,
                    child: RotationTransition(
                      turns: _controller,
                      alignment: Alignment.center,
                      child: Image.asset(
                        son
                            ? 'image/3.0x/fengshan.png'
                            : 'image/3.0x/fengshan_night.png',
                        width: 50,
                        gaplessPlayback: true,
                      ),
                    ),
                  ),

                  ///云
                  Stack(
                    children: dataOne.map((item) {
                      return Positioned(
                        top: item['top'],
                        child: CloudWidget(
                          milliseconds: item['milliseconds'],
                          img: item['img'],
                          width: item['width'],
                        ),
                      );
                    }).toList(),
                  ),

                  ///球
                  Stack(
                    children: dataTwo.map((item) {
                      return Positioned(
                          left: item[0],
                          bottom: item[1],
                          child: WheatWidget(
                            milliseconds: item[2],
                            day: item[3],
                          ));
                    }).toList(),
                  )
                ],
              ),
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  son = !son;
                  print(son);
                });
              },
              child: Text('切换'),
            ),
          ],
        ),
      ),
    );
  }
}

class CloudWidget extends StatefulWidget {
  final int milliseconds;
  final String img;
  final double width;

  const CloudWidget({
    Key key,
    this.milliseconds,
    this.img,
    this.width,
  }) : super(key: key);
  @override
  _CloudWidgetState createState() => _CloudWidgetState();
}

class _CloudWidgetState extends State<CloudWidget>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
        vsync: this, duration: new Duration(milliseconds: widget.milliseconds));
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.forward();
    animation = Tween(begin: Offset(0.0, 0.0), end: Offset(10.0, 0.0))
        .animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation,
      child: Image.asset(widget.img, width: widget.width),
    );
  }
}

class WheatWidget extends StatefulWidget {
  final int milliseconds;
  final int day;
  const WheatWidget({
    Key key,
    this.milliseconds,
    this.day,
  }) : super(key: key);
  @override
  _WheatWidgetState createState() => _WheatWidgetState();
}

class _WheatWidgetState extends State<WheatWidget>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
        vsync: this, duration: new Duration(milliseconds: widget.milliseconds));
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    animation = Tween(
      begin: Offset(0, 0),
      end: Offset(0, 0.5),
    ).animate(controller);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
        position: animation,
        child: Column(
          children: <Widget>[
            Image.asset(
              'image/3.0x/wheat_3.png',
              width: 60,
              gaplessPlayback: true,
            ),
            Text('第${widget.day}天', style: TextStyle(color: Colors.white)),
          ],
        ));
  }
}
