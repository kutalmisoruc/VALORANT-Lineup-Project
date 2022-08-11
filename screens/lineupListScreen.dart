import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:project_a_18/Function/firebaseProcess.dart';
import 'package:project_a_18/Function/functionNeed.dart';
import 'package:project_a_18/colorPalette/color.dart';
import 'package:project_a_18/screens/lineupDetailScreen.dart';
import 'package:project_a_18/widget/iconFav.dart';
import 'package:project_a_18/widget/lineupContainer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/lineupAutoText.dart';

class LineupListScreen extends StatefulWidget {
  String agent;
  String map1;
  LineupListScreen({Key? key, required this.agent,required this.map1}) : super(key: key)
  {
    _initAd();
  }

  @override
  State<LineupListScreen> createState() => _LineupListScreenState();
}
late InterstitialAd _interstitialAd;
  bool _isAdLoaded = false;
  void _initAd() {
    InterstitialAd.load(
      adUnitId: "ca-app-pub-3940256099942544/1033173712",
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
      onAdLoaded:  onAdLoaded, 
      onAdFailedToLoad: (error){})
      );
  }

  void onAdLoaded(InterstitialAd ad) {
    _interstitialAd = ad;
    _isAdLoaded = true;
  }
class _LineupListScreenState extends State<LineupListScreen> {
  final _inlineAdIndex = 1;
  late BannerAd _inlineBannerAd;
  bool _isInlineBannerAdLoaded = false;
  
  @override
  void initState() {
    super.initState();
    //_createInlineBannerAd();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //_inlineBannerAd.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    var object = functionNeed();
    var ekranBilgisi = MediaQuery.of(context);
    final double screenHeight = ekranBilgisi.size.height;
    final double screenWidth = ekranBilgisi.size.width;
    return Scaffold(
      appBar: AppBar(title: AutoSizeText("${widget.agent} ${widget.map1} Lineup",style: GoogleFonts.robotoMono(color: Colors.white,fontWeight: FontWeight.bold),stepGranularity: 1,maxLines: 1,minFontSize: 10),),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseProcess().LineUpDataPull(widget.agent,widget.map1.toLowerCase()),//LINEUP DATA PULL WITH MAP AND AGENT NAME
        builder: ((context, snapshot) {
          return !snapshot.hasData
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
            itemCount: snapshot.data!.docs.length+(_isInlineBannerAdLoaded ? 1 : 0),//IF AD LOAD IS TRUE ADD 1 TO LIST LENGTH OR ADD 0
            itemBuilder: (context, index) {
              DocumentSnapshot mypost = snapshot.data!.docs[_getListViewItemIndex(index)];
              if (_isInlineBannerAdLoaded && index == _inlineAdIndex) {
              return Container(
              padding: EdgeInsets.only(
              bottom: 10,
              ),
              width: _inlineBannerAd.size.width.toDouble(),
              height: _inlineBannerAd.size.height.toDouble(),
              child: AdWidget(ad: _inlineBannerAd),
              );
              }else{
              return GestureDetector(
                onTap: () {
                  //adShow();
                  Navigator.push(context,MaterialPageRoute(builder: (context) => LineupDetailScreen(id: mypost["id"],url: mypost["video"],)));
                },
                child: Card(
                  color: colorPalette.blackpearl,
                  child: Row(children: [
                    Container(
                      decoration: BoxDecoration(
                        color: colorPalette.watermelon,
                        border: Border.all(
                        color: colorPalette.cloudburst,
                        width: 3,),
                        borderRadius: BorderRadius.all(Radius.circular(0.0)),
                      ),
                      width: screenWidth*0.5,     //THIS FOR IMAGE
                      height: screenWidth*0.28125,//RATIO
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.network(mypost["image1"])),
                    ),
              
                    Expanded(
                      flex: 40,
                      child: Column(
                        children: [
                          LineupContainer(text1: "spike".tr, text2: mypost["plant"]),

                          LineupContainer(text1: "agent".tr, text2: mypost["agent"]),
                          
                          LineupContainer(text1: "utility".tr, text2: mypost["utility"].toString().tr),

                          LineupContainer(text1: "map".tr, text2: object.firstLetterUp(mypost["map"])),
                          
                        ],
                      ),
                    ),
                    
                  ],),
                ),
              );
              }
            },
          );
        }),
      ),
    );
  }
  void adShow(){
    if(_isAdLoaded){
          _interstitialAd.show();
      }
  }

  void _createInlineBannerAd() {
    _inlineBannerAd = BannerAd(
      size: AdSize.largeBanner,
      adUnitId:  "ca-app-pub-3940256099942544/6300978111",
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isInlineBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    _inlineBannerAd.load();
  }
  //FOR PLACEMENT AD TO TRUE INDEX İF THİS NOT WORK CONFLICT INDEX AND SOME DATA DOESNT SHOW
  int _getListViewItemIndex(int index) {
  if (index >= _inlineAdIndex && _isInlineBannerAdLoaded) {
    return index - 1;
  }
  return index;
}
}
//FAV LINEUP PULL FROM SHAREDPREFERENCES
Future<List> dataPull()async{
var listpull = <String>[];
var sp = await SharedPreferences.getInstance();
listpull = sp.getStringList("list")!;

 return listpull;
}
