import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizero/constants/backgroundColor.dart';
import 'package:quizero/screens/resultScreen.dart';

class GetJson extends StatelessWidget {

  int number = 0;
  int idNumber;
  String address;

  GetJson(
      this.idNumber,
      );

  void anyValue(address){
    Random random = new Random();
    int randomNumber = random.nextInt(10);
    number = randomNumber;
  }

  void identity(){
    if(idNumber == 1){
      address = "json/art&civilization.json";
    }else if(idNumber == 2){
      address = "json/astronomy.json";
    }else if(idNumber == 3){
      address = "json/botany.json";
    }else if(idNumber == 4){
      address = "json/chemistry.json";
    }else if(idNumber == 5){
      address = "json/geography.json";
    }else if(idNumber == 6){
      address = "json/literature.json";
    }else if(idNumber == 7){
      address = "json/physics.json";
    }else if(idNumber == 8){
      address = "json/sports.json";
    }else if(idNumber == 9){
      address = "json/technology.json";
    }else if(idNumber == 10){
      address = "json/zoology.json";
    }else{
      address = "json/all.json";
    }
  }

  @override
  Widget build(BuildContext context) {
    identity();
    return FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString(address),
        builder: (context, snapshot){
          List mydata = json.decode(snapshot.data.toString());
          if (mydata == null){
            return Scaffold(
              body: Center(
                child: Text("Loading"),
              )
            );
          }
          else{
            anyValue(address);
            return QuizScreen(mydata: mydata, number: number, address: address);
          }
        }
    );
  }
}


class QuizScreen extends StatefulWidget {

  var mydata;
  int number;
  String address;

  QuizScreen({Key key, @required this.mydata, this.number, this.address}): super( key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState(mydata: mydata, number: number, address: address);
}

class _QuizScreenState extends State<QuizScreen> {

  int number;
  int i = 0;
  var mydata;
  String address;

  _QuizScreenState({
    this.mydata, this.number, this.address
});

//Playing with Buttons
  Color colorToShow = createMaterialColor(Color(0xFF000099));
  Color right = Colors.green;
  Color wrong = Colors.red;
  int marks = 0;

  Map<String, Color> btnColor ={
    "option1": createMaterialColor(Color(0xFF000099)),
    "option2": createMaterialColor(Color(0xFF000099)),
    "option3": createMaterialColor(Color(0xFF000099)),
    "option4": createMaterialColor(Color(0xFF000099)),
  };

  void checkAnswer(int question, String option){
    if (mydata[question]["answer"].toString() == mydata[question][option].toString()){
      marks = marks + 5;
      colorToShow = right;
    }
    else{
      colorToShow = wrong;
    }
    setState((){
      btnColor[option] = colorToShow;
      cancelTimer = true;
    });
    Timer(Duration(seconds: 1), anyValue);
  }

  void anyValue(){
    cancelTimer = false;
    Random random = new Random();
    int value = 50;
    if(address == "json/all.json"){
      value = 500;
    }
    int randomNumber = random.nextInt(value);
    timer = 15;
    setState(() {
      number = randomNumber;
      if(i<9){
        i++;
      }
      else{
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => ResultScreen(marks))
        );
      }
      btnColor["option1"] =  createMaterialColor(Color(0xFF000099));
      btnColor["option2"] =  createMaterialColor(Color(0xFF000099));
      btnColor["option3"] =  createMaterialColor(Color(0xFF000099));
      btnColor["option4"] =  createMaterialColor(Color(0xFF000099));
    });
    startTimer();
  }

  //Alternating Timer
  int timer = 15;
  String showTimer = "15";
  bool cancelTimer = false;

  @override
  void initState(){
    startTimer();
    super.initState();
  }

  void startTimer() async{
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t) {
      setState(() {
        if(timer<1){
          t.cancel();
          anyValue();
        }else if(cancelTimer == true){
          t.cancel();
        }
        else{
          timer = timer - 1;
        }
        showTimer = timer.toString();
      });
    });
  }

  Widget ChoiceButton(int qN, String oN, double mininumWidth, double height){
    return Container(
      margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
      child: MaterialButton(
        onPressed: (){
          checkAnswer(qN, oN);
          },
        color: btnColor[oN],
        minWidth: mininumWidth,
        height: height,
        splashColor: Colors.blue,
        highlightColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Text(
          mydata[qN][oN].toString(),
          style: TextStyle(fontSize: 20.0, color: Colors.white),
          maxLines: 1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp
    ]);

    return WillPopScope(
      onWillPop: (){
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Quizero"),
            content: Text("You can't go back from here"),
            actions: [
              FlatButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: Text("Ok"),
              )
            ],
          )
        );
      },
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  color: createMaterialColor(Color(0xFF000099)),
                  child: Center(
                      child: Text(
                        mydata[number]["question"],
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      )
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ChoiceButton(number,"option1", MediaQuery.of(context).size.width/2, MediaQuery.of(context).size.height/15),
                      ChoiceButton(number,"option2", MediaQuery.of(context).size.width/2, MediaQuery.of(context).size.height/15),
                      ChoiceButton(number,"option3", MediaQuery.of(context).size.width/2, MediaQuery.of(context).size.height/15),
                      ChoiceButton(number,"option4", MediaQuery.of(context).size.width/2, MediaQuery.of(context).size.height/15),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.orange,
                  child: Center(
                    child: Text(showTimer, style: TextStyle(color: Colors.white, fontSize: 30.0),),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
