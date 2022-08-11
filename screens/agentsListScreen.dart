import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_a_18/Function/firebaseProcess.dart';
import 'package:project_a_18/screens/lineupListScreen.dart';
import 'package:project_a_18/widget/circlePhotoWidget.dart';

class AgentsListScreen extends StatefulWidget {
  //SELECTED MAP DATA COMING FROM MAPSCREEN
  String map;
  AgentsListScreen({Key? key,required this.map}) : super(key: key);
  
  @override
  State<AgentsListScreen> createState() => _AgentsListScreenState();
}

class _AgentsListScreenState extends State<AgentsListScreen> {
  
  @override
  Widget build(BuildContext context) {
    String map1 = widget.map;
    var ekranBilgisi = MediaQuery.of(context);
    final double screenHeight = ekranBilgisi.size.height;
    final double screenWidth = ekranBilgisi.size.width;

    return Scaffold(
      appBar: AppBar(title: AutoSizeText("map".tr+": ${widget.map}",style: GoogleFonts.robotoMono(color: Colors.white,fontWeight: FontWeight.bold),stepGranularity: 1,maxLines: 1,minFontSize: 10,),),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseProcess().AgentsDataPull(),
        builder: (context, snapshot){
          return !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,//HOW MANY AGENT SHOW 1 LINE
              childAspectRatio: 1//AGENT CARD RATIO
              ),
              itemCount: snapshot.data!.docs.length,//NUMBER OF AGENT 
              itemBuilder: (context, index) {
              DocumentSnapshot mypost = snapshot.data!.docs[index];
              return CirclePhotoWidget(agent: mypost["Name"],map: widget.map,url: mypost["Icon"],);
              },
            );
        },
      ),
    );
  }
}