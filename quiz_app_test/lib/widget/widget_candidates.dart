import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CandWidget extends StatefulWidget{
  VoidCallback tap; //42줄의 onTap에서 쓰임. CandWidget을 사용하는 부모 Widget에서 지정해준 tap을 이용해 ontap을 실행.
  String text;
  int index;
  double width;
  bool answerState;

  CandWidget({this.tap, this.index, this.width, this.text, this.answerState});
  CandWidgetState createState() => CandWidgetState();
}

class CandWidgetState extends State<CandWidget>{
  @override
  Widget build(BuildContext context) {
   return Container(
     width: widget.width * 0.8,
     height: widget.width * 0.1,
     padding: EdgeInsets.fromLTRB(
         widget.width * 0.05,
         widget.width * 0.02,
         widget.width * 0.05,
         widget.width * 0.02,
     ),
     decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(20),
       border: Border.all(color: Colors.blueAccent),
       color: widget.answerState ? Colors.blueAccent : Colors.white,
     ),
     child: InkWell(
       child: Text(
         widget.text,
         style: TextStyle(
           fontSize: widget.width * 0.04,
           color: widget.answerState ? Colors.white : Colors.black,
         ),
       ),
       onTap: (){
         setState(() {
           widget.tap();
           widget.answerState = !widget.answerState;
         });
       }
     ),
   );
  }
}