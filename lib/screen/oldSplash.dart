import 'dart:async';

import 'package:flutter/material.dart';

import 'package:whip_smart/screen/home_screen.dart';
//import 'package:whip_smart/screen/home_screen.dart';
import 'package:whip_smart/screen/login_screen.dart';
import 'package:whip_smart/screen/on_boading_screen.dart';
import 'package:whip_smart/utils/navigation_router.dart';
import 'package:whip_smart/utils/util.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }
  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }
  @override
  Widget build(BuildContext context) {
    // final firebaseUser = context.watch<User?>();
    // Timer(Duration(seconds: 5),() => NavigationRouter.switchToLogin(context));


    // if (firebaseUser != null) {
    //   NavigationRouter.switchToHome(context),
    // }
    // else{
    //   NavigationRouter.switchToLogin(context),
    // }
    // });


    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Container(

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(image: AssetImage('images/logo.png')),

                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text(
                        Util.name,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0),
                      )
                    ],
                  ),
                ),
              ),

            ],
          )
        ],
      ),

    );


  }
  void navigationPage() {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user != null) {

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
        //Navigator.pop(context);
      }
      else{
        // Navigator.of(context).pushReplacementNamed('/LoginScreen');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => OnBoardingPage()));

      }
    });


  }
}

