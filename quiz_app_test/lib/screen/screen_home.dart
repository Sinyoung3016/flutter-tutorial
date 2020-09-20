import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget{
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>{
  @override
  Widget build(BuildContext context) {
    //반응형 UI : MediaQuery 현재 기기의 여러가지 상태정보 알수있음.
    //따라서 상대적인 수치를 사용.
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return SafeArea( //기기의 상단 바 부분, 하단 영역을 침범하지 않는 안전한 영역을 잡아주는 위젯
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Quiz App'),
          backgroundColor: Colors.blueAccent,
          leading: Container(), //Container를 비움 = 앱바의 좌측에 있는 버튼 등을 지우는 효과가 있음.
        ),
        body: Column (
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget> [
            Padding(
              padding: EdgeInsets.all(width * 0.015),
            ),
            Center(child: Image.asset(
                'images/quiz.jpg', //이후 pubspec.yaml에서 등록
                width: width * 0.8,
              ),
            ),
            Text(
             'Flutter Quiz App',
              style: TextStyle(
                fontSize: width * 0.07,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.02),
            ),
            Text(
              '퀴즈를 풀기 전, 안내 사항입니다. \n 꼼꼼히 읽고 퀴즈 풀기를 눌러주세요.',
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.02),
            ),
            infoBeforeTest(width, "1. 문제는 랜덤으로 3문제가 나옵니다."),
            infoBeforeTest(width, "2. 문제를 잘 읽고 정답을 고른 뒤, \n 다음 문제 버튼을 눌러주세요."),
            infoBeforeTest(width, "3. 만점을 향해 도전하세요!"),
            Padding(
              padding: EdgeInsets.all(width * 0.015),
            ),
            btnStart(width, height),
          ]
        )
      ),
    );
  }

  //buildStep
  Widget infoBeforeTest(double width, String title){
    return Container(
      padding: EdgeInsets.fromLTRB(
          width * 0.15,
          width * 0.02,
          width * 0.03,
          width * 0.03,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon (
            Icons.check_box,
            size: width * 0.05,
          ),
          Padding(
              padding: EdgeInsets.only(right: width * 0.005),),
          Text(title),
      ],
      ),
    );
  }

  Widget btnStart(double width, double height) {
    return Container(
      padding: EdgeInsets.only(bottom: width * 0.01),
      child: Center(
        child: ButtonTheme(
          minWidth: width * 0.3,
          height: height * 0.06,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)
          ),
          child: RaisedButton(
            child: Text(
              'Start Now!',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.blueAccent,
            onPressed: (){},
          ),
        ),
      )
    );
  }

}