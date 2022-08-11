import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AutoTextSize extends StatelessWidget {
  final String text;
  const AutoTextSize({Key? key,
  required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(text,style: GoogleFonts.robotoMono(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),stepGranularity: 1,maxLines: 1,minFontSize: 10);
  }
}