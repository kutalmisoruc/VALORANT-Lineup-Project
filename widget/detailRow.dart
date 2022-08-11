import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_a_18/colorPalette/color.dart';

class DetailRow extends StatelessWidget {
  final String text1;
  final String text2;
  const DetailRow({Key? key,
  required this.text1,
  required this.text2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colorPalette.watermelon,
        border: Border.all(
          color: colorPalette.cloudburst,
          width: 3.0,),
          borderRadius: BorderRadius.all(Radius.circular(3.0))
      ),
            margin: EdgeInsets.all(3.0),
            child: Row(children: [//1 ROW AND 2 EXPANDED FOR 50:50 RATIO 
              Expanded(child: Container(child: Center(child: AutoSizeText(text1,style: GoogleFonts.robotoMono(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),stepGranularity: 1,maxLines: 1,minFontSize: 10,)))),
              Expanded(child: Container(child: Center(child: AutoSizeText(text2,style: GoogleFonts.robotoMono(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),stepGranularity: 1,maxLines: 1,minFontSize: 10,)))),
                    ],),
            );
  }
}