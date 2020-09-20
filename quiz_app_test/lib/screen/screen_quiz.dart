import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:quiz_app_test/model/model_quiz.dart';
import 'package:quiz_app_test/screen/screen_result.dart';
import 'package:quiz_app_test/widget/widget_candidates.dart';


class QuizScreen extends StatefulWidget {
  List<Quiz> quizs;
  QuizScreen({this.quizs});
  @override
  QuizScreenState createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen>{
  List<int> answers = [-1,-1,-1]; //사용자의 답
  List<bool> answerState = [false, false, false, false]; //4개의 값이 눌렸는지 안눌렸는지.
  int currentIndex = 0; //현재 보고있는 문제
  SwiperController controller = SwiperController();

  Widget build(BuildContext context){
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.blueAccent),
            ),
            width: width * 0.8,
            height: height * 0.5,
            child: Swiper(
              controller: controller,
              physics: NeverScrollableScrollPhysics(), 
              //강제로 스와이프 모션을 통해 넘어가지 않음, 따라서 스킵 불가
              loop: false,
              itemCount: widget.quizs.length,
              itemBuilder: (BuildContext context, int index){
                return quizCard(widget.quizs[index], width, height);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget quizCard(Quiz quiz, double width, double height){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, width*0.02, 0, width*0.02),
            child: Text(
              'Q' + (currentIndex + 1).toString() + '.',
              style: TextStyle(
                fontSize: width * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            child: AutoSizeText(
              quiz.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                fontSize: width * 0.05, fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(child: Container(),),
          //빈컨테이너는 이후에 배치될 children이 아래서부터 배치되는 효과를 줌.
          Column(children: candidates(width, quiz),),
          Container(
            padding: EdgeInsets.all(width * 0.015),
            child: Center(
              child: ButtonTheme(
                minWidth: width * 0.5,
                height: height * 0.035,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: RaisedButton(
                  child: currentIndex == widget.quizs.length-1 ? Text('Show Result') : Text('Next Question'),
                  textColor: Colors.white,
                  color: Colors.blueAccent,
                  onPressed: answers[currentIndex] == -1 ? null : (){
                    //답을 작성한 상태
                    if(currentIndex == widget.quizs.length - 1) {
                      //결과보기
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResultScreen(
                                      answers: answers,
                                      quizs: widget.quizs)));
                    }
                    else{
                      //다음문제로
                      answerState = [false, false, false, false];
                      currentIndex += 1;
                      controller.next();
                    }
                  },
                ),
              ),
            )
          ),
        ]
      ),
    );
  }

  List<Widget> candidates(double width, Quiz quiz){
    List<Widget> children = [];
    for(int i = 0; i < 4; i++) {
      children.add(
        CandWidget(
            index: i,
            text: quiz.candidates[i],
            width: width,
            answerState: answerState[i],
            tap: () {
              setState(() {
                for (int j = 0; j < 4; j++) {
                  if (i == j) {
                    answerState[j] = true;
                    answers[currentIndex] = j;
                  }
                  else
                    answerState[j] = false;
                }
              });
            }
        ),
      );
      children.add(
        Padding(
            padding: EdgeInsets.all(width * 0.02)
        ),
      );
    }
    return children;
  }

}