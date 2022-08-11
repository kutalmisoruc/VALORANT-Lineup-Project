
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_a_18/colorPalette/color.dart';
import 'package:project_a_18/screens/lineupListScreen.dart';

class CirclePhotoWidget extends StatelessWidget {
  String map,agent,url;

  CirclePhotoWidget({Key? key,
  required this.map,
  required this.agent,
  required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double screenHeight = ekranBilgisi.size.height;
    final double screenWidth = ekranBilgisi.size.width;
    
    return Material(
                color: colorPalette.blackpearl,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => LineupListScreen(agent: agent,map1: map)));
                  },
                  child: CircleAvatar(
                        backgroundColor: colorPalette.watermelon,
                        radius: screenWidth*0.3,//RADIUS SIZE
                        backgroundImage: NetworkImage(url),//AGENT IMAGE
                        child: Align(alignment: Alignment.bottomCenter,
                        child:Container(color: colorPalette.midnightblue.withOpacity(0.5),height:screenWidth*0.07,//THIS WAS FOR AGENT NAME CONTAINER LOOKING WİTH OPACITY
                        child: Center(child: AutoSizeText(agent,style: GoogleFonts.robotoMono(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),stepGranularity: 1,maxLines: 1,minFontSize: 10))))
                          ),
                        ),
            );
  }
}