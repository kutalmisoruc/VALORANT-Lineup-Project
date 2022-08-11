import 'package:flutter/material.dart';
import 'package:project_a_18/colorPalette/color.dart';
import 'lineupAutoText.dart';

class LineupContainer extends StatelessWidget {
  final String text1,text2;
  const LineupContainer({Key? key,
  required this.text1,
  required this.text2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double screenHeight = ekranBilgisi.size.height;
    final double screenWidth = ekranBilgisi.size.width;
    return Container(
              decoration: BoxDecoration(
              color: colorPalette.watermelon,
              border: Border.all(
              color: colorPalette.cloudburst,
              width: 3,),
              borderRadius: BorderRadius.all(Radius.circular(0)),
              ),
              height: (screenWidth*0.28125)/4,
              child: Row(children: [//1 ROW 2 EXPANDED FOR 50:50 RATIO
              Expanded(child: Container(child: Center(child: AutoTextSize(text: text1,)),)),
              Expanded(child: Container(child: Center(child: AutoTextSize(text: text2,)),)),
              ],),
              );
  }
}