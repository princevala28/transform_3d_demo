import 'dart:math';

import 'package:flutter/material.dart';
import 'package:login_transform_demo/ColorConst.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  Animation<double> hAnimation;
  bool isFront = true;
  double verticalDrag = 0;
  double horizontalDrag = 0;
  double dragOffset = 45;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorLightBG,
      body: GestureDetector(
        onPanStart: (details) {
          controller.reset();
          setState(() {
            verticalDrag = 0;
            horizontalDrag = 0;
          });
        },
        onPanUpdate: (details) {
          var oldVDrag = verticalDrag;
          var oldDrag = horizontalDrag;
          verticalDrag += details.delta.dy;
          verticalDrag %= 360;
          horizontalDrag -= details.delta.dx;
          horizontalDrag %= 360;
          if (verticalDrag > dragOffset && verticalDrag < 360 - dragOffset) {
            verticalDrag = oldVDrag;
          }
          if (horizontalDrag > dragOffset &&
              horizontalDrag < 360 - dragOffset) {
            horizontalDrag = oldDrag;
          }
          setState(() {});
        },
        onPanEnd: (details) {
          final double vEnd = 360 - verticalDrag >= 180 ? 0 : 360;
          final double hEnd = 360 - horizontalDrag >= 180 ? 0 : 360;
          animation = Tween<double>(begin: verticalDrag, end: vEnd)
              .animate(controller)
            ..addListener(() {
              setState(() {
                verticalDrag = animation.value;
              });
            });
          hAnimation = Tween<double>(begin: horizontalDrag, end: hEnd)
              .animate(controller)
            ..addListener(() {
              setState(() {
                horizontalDrag = animation.value;
              });
            });
          controller.forward();
        },
        child: Expanded(
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                child: Expanded(
                  child: Image.asset("assets/img_moneyheist.jpg", fit: BoxFit.fill,),
                ),
              ),
              Container(
                height: double.infinity,
                width: double.infinity,
                color: colorBlackTr,
              ),
              Center(
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(verticalDrag / 180 * pi)
                    ..rotateY(horizontalDrag / 180 * pi),
                  alignment: Alignment.center,
                  child: Container(
                    width: 300,
                    height: 450,
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                        color: colorCardBG,
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 12.0, // soften the shadow
                            spreadRadius: 0.0, //extend the shadow
                            offset: Offset(
                              4.0, // Move to right 10  horizontally
                              4.0, // Move to bottom 10 Vertically
                            ),
                          ),
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Divider(
                          height: 16,
                        ),
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 16.0, // soften the shadow
                              spreadRadius: 8.0, //extend the shadow
                              offset: Offset(
                                4.0, // Move to right 10  horizontally
                                4.0, // Move to bottom 10 Vertically
                              ),
                            ),
                          ], shape: BoxShape.circle),
                          child: CircleAvatar(
                            backgroundImage: AssetImage("assets/img_dp.png"),
                          ),
                        ),
                        Divider(
                          height: 22,
                        ),
                        Text("Money Heist",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        Divider(
                          height: 2,
                        ),
                        Text(
                          "Netflix original series",
                          style: TextStyle(fontSize: 12, color: Colors.white54),
                        ),
                        Divider(
                          height: 12,
                        ),
                        Text(
                          "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.",
                          style: TextStyle(fontSize: 12, color: Colors.white, ),
                          textAlign: TextAlign.center,
                        ),
                        Divider(height: 24,),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                              color: colorRed,
                              borderRadius: BorderRadius.all(Radius.circular(16.0))
                          ),
                          child: Text(
                            "Play now",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                          ),
                        ),

                        Expanded(child: Divider(height: 16,)),
                        /*Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/ic_linkedin.png", height: 18, width: 18, color: Colors.white,),SizedBox(width: 22,),
                            Image.asset("assets/ic_twitter.png", height: 18, width: 18, color: Colors.white,),SizedBox(width: 22,),
                            Image.asset("assets/ic_instagram.png", height: 18, width: 18, color: Colors.white,),SizedBox(width: 22,),
                            Image.asset("assets/ic_github.png", height: 18, width: 18, color: Colors.white,)
                          ],
                        ),*/
                        Divider(height: 16,),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      )
    );
  }
}
