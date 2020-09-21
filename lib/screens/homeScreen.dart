import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizero/constants/backgroundColor.dart';
import 'package:quizero/screens/quizScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget customerCard(int idNumber, String subject, String subjectImage, int numberOfQuestions){
   return InkWell(
     onTap: (){
       Navigator.of(context).pushReplacement(MaterialPageRoute(
         builder: (context) => GetJson(idNumber)
       ));
     },
     child: Container(
       decoration: BoxDecoration(
           color: Colors.orangeAccent[100],
           borderRadius: new BorderRadius.only(
             topLeft: const Radius.circular(10.0),
           ),
         boxShadow: [
           BoxShadow(
             color: Colors.grey.withOpacity(0.75),
             spreadRadius: 1,
             blurRadius: 2,
             offset: Offset(1, 1)// changes position of shadow
           ),
         ],
       ),
       height: MediaQuery.of(context).size.width/3,
       margin: EdgeInsets.fromLTRB(10.0,5.0,10.0,5.0),
       padding: EdgeInsets.all(5.0),
       child: Row(
         children: [
           SizedBox(
             width: MediaQuery.of(context).size.width/40,
           ),
           Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Container(
                 decoration: BoxDecoration(
                 color: Colors.white,
                 shape: BoxShape.circle,
                 boxShadow: [
                   BoxShadow(blurRadius: 1, color: Colors.white, spreadRadius: 0, offset: Offset(1, 1))
                 ],
               ),
                 child: CircleAvatar(
                   radius: MediaQuery.of(context).size.width/8,
                   backgroundImage: AssetImage(subjectImage),
                 ),
               ),
             ],
           ),
           SizedBox(
             width: MediaQuery.of(context).size.width/20,
           ),
           Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(subject, style: TextStyle(color: createMaterialColor(Color(0xFF000099)), fontWeight: FontWeight.bold, fontSize: 30.0),),
               Text(numberOfQuestions.toString() + " questions", style: TextStyle(color: createMaterialColor(Color(0xFF000000)), fontWeight: FontWeight.bold),),
             ],
           )
         ],
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Quizero"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(0.0, 2.5, 0.0, 0.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              customerCard(1,"Art","images/subjects/art&civilization.jpg",50),
              customerCard(2,"Astronomy","images/subjects/astronomy.jpg",50),
              customerCard(3,"Botany","images/subjects/botany.jpg",50),
              customerCard(4,"Chemistry","images/subjects/chemistry.jpg",50),
              customerCard(5,"Geography","images/subjects/geography.jpg",50),
              customerCard(6,"Literature","images/subjects/literature.jpg",50),
              customerCard(7,"Physics","images/subjects/physics.jpg",50),
              customerCard(8,"Sports","images/subjects/sports.jpg",50),
              customerCard(9,"Technology","images/subjects/technology.jpg",50),
              customerCard(10,"Zoology","images/subjects/zoology.jpg",50),
              customerCard(11,"All in One","images/subjects/allinone.jpg",500),
            ],
          ),
        ),
      ),
    );
  }
}
