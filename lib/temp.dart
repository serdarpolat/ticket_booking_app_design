import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ticket Booking',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "Barlow"),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController ctrl;
  Animation<double> animation;
  PageController pageController = PageController(viewportFraction: 0.78);
  double get w => MediaQuery.of(context).size.width;
  double get h => MediaQuery.of(context).size.height;

  int leftPosition = 0;
  int tapButton = 0;
  bool opacity = false;

  @override
  void initState() {
    super.initState();

    ctrl =
        AnimationController(vsync: this, duration: Duration(milliseconds: 360));

    animation = Tween(begin: 0.0, end: 1.0).animate(ctrl);

    int next = 0;

    pageController.addListener(() {
      setState(() {
        next = pageController.page.round();
        leftPosition = next;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    animation = Tween<double>(begin: 0.0, end: -1.57107).animate(ctrl);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          //! Background images
          ...movies.map((e) {
            return AnimatedPositioned(
              duration: Duration(milliseconds: 320),
              top: 0,
              left: w * e.idx - (w * leftPosition),
              child: BlurBg(
                w: w,
                h: h,
                img: e.img,
              ),
            );
          }).toList(),
          //! Background image blur
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 16,
              sigmaY: 16,
            ),
            child: Container(
              color: Colors.black.withOpacity(0.1),
            ),
          ),

          //! Movie infos
          AnimatedPositioned(
            duration: Duration(milliseconds: 1200),
            curve: Interval(0.0, 0.6, curve: Curves.ease),
            left: 50 * (1.0 - tapButton),
            right: 50 * (1.0 - tapButton),
            bottom: 50 * (1.0 - tapButton),
            top: h * (0.3 - 0.2 * tapButton),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                child: Column(
                  children: <Widget>[
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 1200),
                      curve: Interval(0.5, 1.0),
                      opacity: 1.0 * tapButton,
                      child: Container(
                          child: tapButton == 0 ? Container() : Seats()),
                    ),
                    Spacer(),
                    Container(
                      width: w,
                      height: 320,
                      child: Stack(
                        children: <Widget>[
                          ...movies.map((e) {
                            return AnimatedPositioned(
                              duration: Duration(milliseconds: 320),
                              top: 0,
                              left: (w - 100) * e.idx -
                                  ((w - 100) * leftPosition),
                              child: AnimatedOpacity(
                                duration: Duration(milliseconds: 400),
                                curve: Interval(0.5, 1.0),
                                opacity: opacity ? 0 : 1,
                                child: Container(
                                  width: w - 100 * (1 - tapButton),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 50.0 * (1 - tapButton)),
                                  color: Colors.yellow,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        width: w,
                                        height: 80,
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Text(
                                            e.title.toUpperCase(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 12),
                                      Row(
                                        children: <Widget>[
                                          Spacer(),
                                          Icon(
                                            Icons.location_on,
                                            color: Color(0xffF92CA4),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            "AMC, Metreon 16",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                      SizedBox(height: 48),
                                      tapButton == 0
                                          ? TimePicker()
                                          : Container(
                                              width: w,
                                              color: Colors.blue,
                                              child: Column(
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Text(
                                                        "Date",
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      Text(
                                                        "JUN 18",
                                                        style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                    BottomButton(
                      w: w,
                      tapButton: tapButton,
                      onTap: () {
                        setState(() {
                          tapButton == 1 ? tapButton = 0 : tapButton = 1;
                        });

                        print(ctrl.status);

                        if (ctrl.status == AnimationStatus.dismissed) {
                          setState(() {
                            ctrl.forward();
                          });
                        } else {
                          setState(() {
                            ctrl.reverse();
                          });
                        }

                        print(ctrl.value);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 1200),
            curve: Interval(0.6, 1.0),
            top: 180 + 20.0 * tapButton,
            left: (w - 73) / 2,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 1200),
              curve: Interval(0.6, 1.0),
              opacity: 1.0 * tapButton,
              child: Container(
                width: 120,
                height: 90,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "BEST SEATS\nAVAILABLE",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Tap to select\nmovie seats",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(0, 5),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 1200),
            curve: Interval(0.6, 1.0),
            top: 260 + 20.0 * tapButton,
            left: (w + 13) / 2,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 1200),
              curve: Interval(0.6, 1.0),
              opacity: 1.0 * tapButton,
              child: Transform.rotate(
                angle: pi / 4,
                child: Container(
                  width: 20,
                  height: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 360),
            top: 64.0 - (220 * tapButton),
            child: Container(
              width: w,
              height: h * 0.5,
              child: PageView(
                onPageChanged: (page) {
                  setState(() {
                    opacity = true;
                  });

                  Future.delayed(Duration(milliseconds: 600), () {
                    setState(() {
                      opacity = false;
                    });
                  });
                },
                controller: pageController,
                children: movies.map((e) {
                  return AnimatedPadding(
                    duration: Duration(milliseconds: 240),
                    padding: EdgeInsets.symmetric(horizontal: 20 * 0.0),
                    child: Container(
                      height: h * 0.5,
                      padding: EdgeInsets.only(left: 30, right: 30, bottom: 40),
                      child: Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          Opacity(
                            opacity: 1.0 - tapButton,
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.6),
                                    offset: Offset(0, 10),
                                    blurRadius: 20,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                          AnimatedBuilder(
                            animation: animation,
                            builder: (context, child) {
                              return Transform(
                                transform: Matrix4.identity()
                                  ..setEntry(3, 2, 0.0008)
                                  ..rotateX(e.idx == leftPosition
                                      ? animation.value
                                      : 0),
                                alignment: Alignment.center,
                                child: Transform.scale(
                                  scale: 1.0 - (0.2 * ctrl.value),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/${e.img}"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 360 + (360 * tapButton)),
            curve: Interval(0.6, 1.0),
            top: 36,
            left: 30.0 * (1 - tapButton),
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 360 + (360 * tapButton)),
              curve: Interval(0.6, 1.0),
              opacity: 1.0 * tapButton,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TimePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 140,
      child: Row(
        children: <Widget>[
          Expanded(
            child: CupertinoPicker(
              itemExtent: 40,
              onSelectedItemChanged: (i) {},
              children: dayList.map((e) {
                return Container(
                  padding: EdgeInsets.only(left: 24),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    e.toUpperCase(),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: CupertinoPicker(
              itemExtent: 36,
              onSelectedItemChanged: (i) {},
              children: timeList.map((e) {
                return Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    e.toUpperCase(),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class Seats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Container(
      width: w,
      child: Stack(
        children: <Widget>[
          Column(
            children: [
              SizedBox(height: 32),
              Container(
                width: w,
                child: Text(
                  "SCREEN",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.withOpacity(0.7),
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
              ),
              SizedBox(height: 32),
              Container(
                width: w,
                color: Colors.red,
                padding: EdgeInsets.only(
                  left: 90,
                  right: 90,
                ),
                child: Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  alignment: WrapAlignment.center,
                  children: List.generate(108, (index) {
                    return Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: index == 66
                            ? Colors.purple
                            : index == 67 ? Colors.purple : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 16),
              Container(
                width: w,
                color: Colors.red,
                padding: EdgeInsets.only(
                  left: 75,
                  right: 75,
                ),
                child: Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  alignment: WrapAlignment.center,
                  children: List.generate(42, (index) {
                    return Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

List<String> dayList = [
  "Today",
  "Sunday",
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
];

List<String> timeList = [
  "09:30",
  "10:30",
  "11:30",
  "12:30",
  "13:30",
  "14:30",
  "15:30",
  "16:30",
  "17:30",
  "18:30",
  "19:30",
  "20:30",
  "21:30",
];

class BottomButton extends StatelessWidget {
  final Function onTap;
  final int tapButton;
  final double w;

  const BottomButton({Key key, this.onTap, this.tapButton, this.w})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: Duration(milliseconds: 1200),
      curve: Interval(0.2, 1.0, curve: Curves.elasticOut),
      padding: EdgeInsets.only(
        left: 40.0 * tapButton,
        right: 40.0 * tapButton,
        bottom: 40.0 * tapButton,
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: w,
          height: 72,
          child: Center(
            child: Text(
              tapButton == 0 ? "BOOK" : "PAY",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Color(0xffF92CA4),
                offset: Offset(0, 10),
                blurRadius: 16,
              ),
            ],
            gradient: LinearGradient(
              colors: [
                Color(0xffF92CA4),
                Color(0xffCF005A),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MovieModel {
  final String img;
  final int idx;
  final String title;

  MovieModel(this.img, this.idx, this.title);
}

List<MovieModel> movies = [
  MovieModel("early_man.jpg", 0, "Early Man"),
  MovieModel("infinity_war.jpg", 1, "Avengers\nInfinity War"),
  MovieModel("the_grinch.jpg", 2, "The Grinch"),
];

class BlurBg extends StatelessWidget {
  final double w;
  final double h;
  final String img;

  const BlurBg({
    Key key,
    this.img,
    this.w,
    this.h,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/$img"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

// setState(() {
//                       testi = 1;
//                     });

//                     Future.delayed(Duration(milliseconds: 120), () {
//                       setState(() {
//                         testi = 0;
//                         coffeeTitle = cupItems[cuploc].title;
//                       });
//                     });
