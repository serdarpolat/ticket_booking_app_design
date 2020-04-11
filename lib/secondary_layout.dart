import 'package:flutter/material.dart';
import 'package:ticketbooking_app/radial_progress_bar.dart';

class SecondaryLayout extends StatelessWidget {
  final double w;
  final double h;
  final int swipe;
  final bool isExpand;
  final String title;
  final Animation progressAnimation;
  final Function onPressed;

  const SecondaryLayout(
      {Key key,
      this.w,
      this.h,
      this.swipe,
      this.isExpand,
      this.title,
      this.progressAnimation,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String story =
        "For their eighth fully animated feature, Illumination and Universal Pictures present The Grinch, based on Dr. Seuss' beloved holiday classic. The Grinch tells the story of a cynical grump who goes on a mission to steal Christmas, only to have his heart changed by a young girl's generous holiday spirit. Funny, heartwarming, and visually stunning, it's a universal story about the spirit of Christmas and the indomitable power of optimism. Academy Award nominee Benedict Cumberbatch lends his voice to the infamous Grinch, who lives a solitary life inside a cave on Mt. Crumpet with only his loyal dog, Max, for company. With a cave rigged with inventions and contraptions for his day-to-day needs, the Grinch only sees his neighbors in Whoville when he runs out of food. Each year at Christmas they disrupt his tranquil solitude with their increasingly bigger, brighter, and louder celebrations. When the Whos declare they are going to make Christmas three times bigger this year, the Grinch";
    return AnimatedPositioned(
      duration: Duration(milliseconds: 600),
      curve: Curves.easeInToLinear,
      top: -h * swipe,
      left: 0,
      right: 0,
      bottom: h * swipe,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 1200),
        curve: Interval(0.3, 1.0, curve: Curves.ease),
        width: w,
        height: h,
        color: isExpand ? Colors.black.withOpacity(0.75) : Colors.transparent,
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: <Widget>[
                  AnimatedPadding(
                    duration: Duration(milliseconds: 1200),
                    curve: Interval(0.0, 1.0, curve: Curves.ease),
                    padding: EdgeInsets.only(
                      top: 72 - 32.0 * swipe,
                    ),
                    child: Container(
                      width: w,
                      child: Text(
                        title.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 36,
                          letterSpacing: -1,
                        ),
                      ),
                    ),
                  ),
                  AnimatedPadding(
                    duration: Duration(milliseconds: 1200),
                    curve: Interval(0.0, 1.0, curve: Curves.ease),
                    padding: EdgeInsets.only(top: 8.0 - 8.0 * swipe),
                    child: Container(
                      width: w,
                      child: Text(
                        "2018",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  AnimatedPadding(
                    duration: Duration(milliseconds: 1200),
                    curve: Interval(0.0, 1.0, curve: Curves.ease),
                    padding: EdgeInsets.only(top: 24.0 - 24.0 * swipe),
                    child: AnimatedBuilder(
                        animation: progressAnimation,
                        builder: (context, child) {
                          return Container(
                            width: w,
                            child: Center(
                              child: Container(
                                width: w / 2.1,
                                height: w / 2.1,
                                padding: EdgeInsets.all(14),
                                child: RadialProgressBar(
                                  trackColor: Colors.transparent,
                                  progressColor: Color(0xff31FDD1),
                                  progressPercent:
                                      0.84 * progressAnimation.value,
                                  progressWidth: 14,
                                  startAngle: -90,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      padding: EdgeInsets.all(6),
                                      child: RadialProgressBar(
                                        trackColor: Colors.transparent,
                                        progressColor: Color(0xff3155ED),
                                        progressPercent:
                                            0.92 * progressAnimation.value,
                                        progressWidth: 14,
                                        startAngle: -90,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  "92",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 36,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  "LIKED IT",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              "%",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(height: 36),
                  CriticsAudience(),
                  SizedBox(height: 36),
                  WatchTrailer(),
                  SizedBox(height: 10),
                  MovieCasting(),
                  SizedBox(height: 10),
                  Container(
                    width: w,
                    child: Text(
                      "PLOT",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 36,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  Container(
                    width: w,
                    padding: EdgeInsets.only(top: 14, left: 44, right: 44),
                    child: Text(
                      story + " " + story,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 600),
                curve: Interval(0.5, 1.0, curve: Curves.easeInToLinear),
                height: 90,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      swipe == 0 ? Colors.black : Colors.transparent,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: IconButton(
                  icon: Icon(Icons.expand_more),
                  onPressed: onPressed,
                  color: Colors.white.withOpacity(0.5),
                  iconSize: 44,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CriticsAudience extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Container(
      width: w,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "CRITICS",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff2BFDA9),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff7FDBFA),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "AUDIENCE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WatchTrailer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Container(
      width: w,
      child: Center(
        child: Container(
          width: w * 0.4,
          height: 54,
          child: Center(
            child: Text(
              "WATCH TRAILER",
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}

class MovieCasting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Container(
      width: w,
      padding: EdgeInsets.all(46),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Text(
                  "Rating",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  "NR",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Text(
                  "Genre",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  "Animation, Kids & Family\nScience Fiction & Fantasy",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Text(
                  "Runtime",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  "60 minutes",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Text(
                  "Director",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  "Yarrow Cheney, Scott Mosier",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Text(
                  "Starring",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  "Benedict Cumberbatch",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
