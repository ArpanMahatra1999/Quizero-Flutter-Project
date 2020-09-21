import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quizero/constants/backgroundColor.dart';
import 'package:quizero/screens/homeScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  //Splash Screen
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 3), (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomeScreen())
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height/3,
            ),
            Center(
              child: Image(
                height: MediaQuery.of(context).size.width/3,
                width: MediaQuery.of(context).size.width/3,
                image: AssetImage('images/quizero.png'),
              ),
            ),
            Center(child: Text("QUIZERO", style: TextStyle(color: createMaterialColor(Color(0xFF000099)), fontSize: 50, fontWeight: FontWeight.bold),)),
          ],
        ),
      ),
    );
  }
}
