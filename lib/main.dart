import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';
import 'package:ticketbooking_app/movie_model.dart';
import 'package:ticketbooking_app/secondary_layout.dart';

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

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController ctrl;
  AnimationController progressCtrl;
  Animation<double> animation;
  Animation<double> progressAnimation;
  PageController pageController = PageController(viewportFraction: 0.78);
  double get w => MediaQuery.of(context).size.width;
  double get h => MediaQuery.of(context).size.height;

  int leftPosition = 0;
  int tapButton = 0;
  bool opacity = false;
  Widget seatDummy = Container();
  int swipe = 1;
  int activeIdx = 0;
  bool isExpand = false;

  @override
  void initState() {
    super.initState();

    ctrl =
        AnimationController(vsync: this, duration: Duration(milliseconds: 360));

    progressCtrl = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    animation = Tween(begin: 0.0, end: 1.0).animate(ctrl);
    progressAnimation = Tween(begin: 0.0, end: 1.0).animate(progressCtrl);

    int next = 0;

    pageController.addListener(() {
      setState(() {
        next = pageController.page.round();
        leftPosition = next;
      });
    });
  }

  String btnTitle = "BOOK";

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
              right: 0,
              child: Align(
                alignment: Alignment.center,
                child: BlurBg(
                  w: w,
                  h: h,
                  img: e.img,
                  swipe: (1 - swipe),
                ),
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
          Positioned(
            top: 0,
            left: 24,
            right: 24,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.black.withOpacity(0.2),
              ),
            ),
          ),
          SecondaryLayout(
            w: w,
            h: h,
            swipe: swipe,
            isExpand: isExpand,
            title: movies[activeIdx].title,
            progressAnimation: progressAnimation,
            onPressed: () {
              setState(() {
                swipe = 1;
                isExpand = !isExpand;
                progressCtrl.reverse();
              });
            },
          ),

          //! Movie Item
          AnimatedPositioned(
            duration: Duration(milliseconds: 600),
            curve: Curves.easeInToLinear,
            top: (h - 88) * (1.0 - swipe),
            left: 0,
            right: 0,
            bottom: -88 * (1.0 - swipe),
            child: Stack(
              children: <Widget>[
                //! Movie infos
                AnimatedPositioned(
                  duration: Duration(milliseconds: 1200),
                  curve: Interval(0.0, 0.6, curve: Curves.ease),
                  left: 50 * (1.0 - tapButton),
                  right: 50 * (1.0 - tapButton),
                  bottom: 50 * (1.0 - tapButton),
                  top: h * (0.3 - 0.2 * tapButton),
                  onEnd: () {
                    if (tapButton == 1) {
                      setState(() {
                        seatDummy = Seats(tapBtn: tapButton);
                      });
                    }
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      height: 622,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.white,
                      ),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            bottom: 130,
                            left: 0,
                            child: AnimatedOpacity(
                              duration: Duration(milliseconds: 150),
                              curve: Interval(0.5, 1.0),
                              opacity: opacity ? 0 : 1,
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 1200),
                                curve: Interval(0.0, 0.6, curve: Curves.ease),
                                width: w - (100 * (1 - tapButton)),
                                height: 250 + 60.0 * tapButton,
                                child: Stack(
                                  children: <Widget>[
                                    ...movies.map((t) {
                                      double ww = w - 100;
                                      return TitleLayout(
                                        title: t.title,
                                        left: ww * t.idx - ww * leftPosition,
                                        width: w - (100 * (1 - tapButton)),
                                      );
                                    }).toList(),
                                    Positioned(
                                      top: 63,
                                      left: 0,
                                      child: Opacity(
                                        opacity: 1.0 * tapButton,
                                        child: Container(
                                          width: w,
                                          child: Column(
                                            children: <Widget>[
                                              Column(
                                                children: <Widget>[
                                                  SizedBox(height: 16),
                                                  ...items.map((e) {
                                                    return TicketInfoItem(
                                                      w: w,
                                                      items: e,
                                                    );
                                                  }).toList(),
                                                  SizedBox(height: 16),
                                                  Container(
                                                    width: w - 100,
                                                    child: Text(
                                                      "\$25.00",
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 30,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    ...movies.map((e) {
                                      double ww = w - 100;
                                      return TimePickerLayout(
                                        left: ww * e.idx - ww * leftPosition,
                                        w: w,
                                        tapBtn: tapButton,
                                      );
                                    }).toList(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          AnimatedPositioned(
                            left: 50.0 * tapButton,
                            right: 50.0 * tapButton,
                            bottom: 50.0 * tapButton,
                            duration: Duration(milliseconds: 1200),
                            curve: Interval(0.2, 1.0, curve: Curves.elasticOut),
                            onEnd: () {
                              setState(() {
                                tapButton == 0
                                    ? btnTitle = "BOOK"
                                    : btnTitle = "PAY";
                              });
                            },
                            child: BottomButton(
                              w: w,
                              onTap: () {
                                setState(() {
                                  tapButton == 0
                                      ? tapButton = 1
                                      : tapButton = 0;
                                });

                                if (tapButton == 0) {
                                  setState(() {
                                    seatDummy = Container();
                                  });
                                }

                                if (ctrl.status == AnimationStatus.dismissed) {
                                  setState(() {
                                    ctrl.forward();
                                  });
                                } else {
                                  setState(() {
                                    ctrl.reverse();
                                  });
                                }
                              },
                              btnTitle: btnTitle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                seatDummy,
                EmptySeatPop(w: w, tapBtn: tapButton),
                EmptySeatPopArrow(w: w, tapBtn: tapButton),
                //! Image
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

                        Future.delayed(Duration(milliseconds: 300), () {
                          setState(() {
                            opacity = false;
                          });
                        });
                      },
                      controller: pageController,
                      children: movies.map((e) {
                        return AnimatedPadding(
                          duration: Duration(milliseconds: 240),
                          padding: EdgeInsets.only(
                              top:
                                  swipe == 1 ? 0 : activeIdx == e.idx ? 0 : 30),
                          child: Container(
                            height: h * 0.5,
                            padding: EdgeInsets.only(
                                left: 30, right: 30, bottom: 40),
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
                                        child: SimpleGestureDetector(
                                          onVerticalSwipe: (direction) {
                                            setState(() {
                                              activeIdx = e.idx;
                                            });
                                            if (direction ==
                                                SwipeDirection.down) {
                                              setState(() {
                                                swipe = 0;
                                                isExpand = !isExpand;
                                                progressCtrl.forward();
                                              });
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/${e.img}"),
                                                fit: BoxFit.cover,
                                              ),
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
              ],
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 360),
            curve: Interval(0.6, 1.0),
            top: 18 - 36.0 * tapButton,
            left: (w - 52) / 2,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 360),
              curve: Interval(0.6, 1.0),
              opacity: 1.0 * (1 - tapButton) * swipe,
              child: IconButton(
                icon: Icon(Icons.expand_less),
                color: Colors.white.withOpacity(0.5),
                onPressed: () {},
                iconSize: 44,
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

class EmptySeatPopArrow extends StatelessWidget {
  final double w;
  final int tapBtn;

  const EmptySeatPopArrow({Key key, this.w, this.tapBtn}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 1200),
      curve: Interval(0.6, 1.0),
      top: 260 + 20.0 * tapBtn,
      left: (w + 13) / 2,
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 1200),
        curve: Interval(0.6, 1.0),
        opacity: 1.0 * tapBtn,
        child: Transform.rotate(
          angle: pi / 4,
          child: Container(
            width: 20,
            height: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class EmptySeatPop extends StatelessWidget {
  final double w;
  final int tapBtn;

  const EmptySeatPop({Key key, this.w, this.tapBtn}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 1200),
      curve: Interval(0.6, 1.0),
      top: 180 + 20.0 * tapBtn,
      left: (w - 73) / 2,
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 1200),
        curve: Interval(0.6, 1.0),
        opacity: 1.0 * tapBtn,
        child: Container(
          width: 120,
          height: 90,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "BEST SEATS\nAVAILABLE",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: 6),
              Text(
                "Tap to select\nmovie seats",
                textAlign: TextAlign.center,
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
    );
  }
}

class TitleLayout extends StatelessWidget {
  final double left;
  final double width;
  final String title;

  const TitleLayout({Key key, this.left, this.width, this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 320),
      top: 0,
      left: left,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 1200),
        curve: Interval(0.0, 0.6, curve: Curves.ease),
        width: width,
        height: 63,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            title.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

class TimePickerLayout extends StatelessWidget {
  final double left;
  final double w;
  final int tapBtn;

  const TimePickerLayout({Key key, this.left, this.w, this.tapBtn})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 320),
      top: 63,
      left: left,
      child: Opacity(
        opacity: 1 * (1.0 - tapBtn),
        child: Column(
          children: <Widget>[
            SizedBox(height: 6),
            AnimatedContainer(
              duration: Duration(milliseconds: 1200),
              curve: Interval(0.0, 0.6, curve: Curves.ease),
              width: w - (100 * (1 - tapBtn)),
              child: Column(
                children: <Widget>[
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
                  SizedBox(height: 8),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 1200),
                    curve: Interval(0.0, 0.6, curve: Curves.ease),
                    width: w - (100 * (1 - tapBtn)),
                    child: Row(
                      children: <Widget>[
                        AnimatedContainer(
                          duration: Duration(milliseconds: 1200),
                          curve: Interval(0.0, 0.6, curve: Curves.ease),
                          width: (w - (100 * (1 - tapBtn))) / 2,
                          height: 144,
                          child: CupertinoPicker(
                            itemExtent: 48,
                            magnification: 1.2,
                            onSelectedItemChanged: (a) {},
                            children: dayList.map((e) {
                              return Container(
                                width: (w - 100) / 2,
                                height: 48,
                                alignment: Alignment.center,
                                child: Text(
                                  e.toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 1200),
                          curve: Interval(0.0, 0.6, curve: Curves.ease),
                          width: (w - (100 * (1 - tapBtn))) / 2,
                          height: 144,
                          child: CupertinoPicker(
                            itemExtent: 48,
                            magnification: 1.2,
                            onSelectedItemChanged: (a) {},
                            children: timeList.map((e) {
                              return Container(
                                width: (w - 100) / 2,
                                height: 48,
                                alignment: Alignment.center,
                                child: Text(
                                  e.toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TicketInfoItems {
  final String keys;
  final String values;

  TicketInfoItems(this.keys, this.values);
}

List<TicketInfoItems> items = [
  TicketInfoItems("DATE", "JUN 18"),
  TicketInfoItems("TIME", "16:40"),
  TicketInfoItems("CINEMA", "AMC Metreon 16"),
  TicketInfoItems("QUANT 2", "2 Tickets"),
];

class TicketInfoItem extends StatelessWidget {
  final double w;
  final TicketInfoItems items;

  const TicketInfoItem({Key key, this.w, this.items}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Container(
        width: w - 100,
        height: 44,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              items.keys,
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              items.values,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
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
  final int tapBtn;

  const Seats({Key key, this.tapBtn}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Positioned(
      top: 96,
      left: 0,
      child: Container(
        width: w,
        height: 370,
        child: Column(
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
  final double w;
  final String btnTitle;

  const BottomButton({Key key, this.onTap, this.w, this.btnTitle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: w - 100,
        height: 72,
        child: Center(
          child: Text(
            btnTitle,
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
    );
  }
}

class BlurBg extends StatelessWidget {
  final double w;
  final double h;
  final String img;
  final int swipe;

  const BlurBg({
    Key key,
    this.img,
    this.w,
    this.h,
    this.swipe,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 360),
      width: w + 240 * swipe,
      height: h + 240 * swipe,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/$img"),
          fit: BoxFit.fitHeight,
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
