import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizero/screens/homeScreen.dart';

class ResultScreen extends StatefulWidget {
  int marks;
  ResultScreen(this.marks);
  @override
  _ResultScreenState createState() => _ResultScreenState(marks: marks);
}

class _ResultScreenState extends State<ResultScreen> {
  int marks;
  _ResultScreenState({this.marks});
  String imageString;
  String text;
  void forImage(){
    if (marks == 50){
      imageString = 'images/rewards/brilliant.png';
      text = "Congratulations! you are crowned as the new Qing-of-Quizero.";
    }else if(marks >= 40 && marks < 50){
      imageString ='images/rewards/aboveaverage.png';
      text = "You are ABOVE AVERAGE";
    }else if(marks >= 30 && marks < 40){
      imageString ='images/rewards/average.png';
      text = "You are AVERAGE.";
    }else if(marks >= 20 && marks < 30){
      imageString ='images/rewards/belowaverage.png';
      text = "You are BELOW AVERAGE.";
    }else{
      imageString = 'images/rewards/fail.png';
      text = "You've failed. Try harder.";
    }
  }

  @override
  Widget build(BuildContext context) {
    forImage();
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height/3*2/9*7,
              alignment: Alignment.bottomCenter,
              child: Image(
                height: MediaQuery.of(context).size.height/30*14,
                width: MediaQuery.of(context).size.height/30*14,
                image: AssetImage(imageString),
              ),
              ),
            Container(
              padding: EdgeInsets.all(10.0),
              height: MediaQuery.of(context).size.height/3*2/9*2,
              alignment: Alignment.center,
              child: Text("Your result is "+ marks.toString() + "\n" + text, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
            ),
            Container(
                color: Colors.blueAccent,
                height: MediaQuery.of(context).size.height/3,
                child: Center(
                  child: RaisedButton(
                    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    color: Colors.orangeAccent,
                    onPressed: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
                    },
                    child: Text("Next Quiz", style: TextStyle(fontSize: 30.0)),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
