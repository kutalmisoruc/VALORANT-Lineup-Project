import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:project_a_18/Function/firebaseProcess.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:project_a_18/Function/functionNeed.dart';
import 'package:project_a_18/bottomBarScreens/mapsScreen.dart';
import 'package:project_a_18/colorPalette/color.dart';
import 'package:project_a_18/screens/lineupVideoScreen.dart';
import 'package:project_a_18/widget/detailRow.dart';
import 'package:project_a_18/widget/iconFav.dart';
import 'package:project_a_18/widget/photoList.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LineupDetailScreen extends StatefulWidget {
  String id;//LINEUP DOCUMENT ID 
  String url;//LINEUP VIDEO LINK
  LineupDetailScreen({Key? key, 
  required this.id,
  required this.url,
  }) : super(key: key);

  @override
  State<LineupDetailScreen> createState() => _LineupDetailScreen();
}

class _LineupDetailScreen extends State<LineupDetailScreen> {
  late BannerAd _bottomBannerAd;
  bool _isBottomBannerAdLoaded = false;

  var list = <String>[];
  bool check1=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataPull();//FAV LINEUP DATA PULL
   // _createBottomBannerAd();
  }

  @override
  void dispose() {
  super.dispose();
  //_bottomBannerAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var object = functionNeed();
    var ekranBilgisi = MediaQuery.of(context);
    final double screenHeight = ekranBilgisi.size.height;
    final double screenWidth = ekranBilgisi.size.width;
    return Scaffold(
      
      appBar: AppBar(title: Text("detail".tr,style: GoogleFonts.robotoMono(fontWeight: FontWeight.bold),),
      actions: [widget.url.isNotEmpty 
      ?GestureDetector(onTap: () {Navigator.push(context,MaterialPageRoute(builder: (context) => LineupVideoScreen(url: widget.url,)));},//IF THERE IS A LINEUP VIDEO LINK SHOW ICON
      child: Icon(Icons.play_circle_outline_outlined,color: colorPalette.watermelon,size: 35,))
      :Row(),//ELSE DONT SHOW
      IconFav(id: widget.id,check1: check1,)]),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseProcess().LineUpDetailDataPull(widget.id),
          builder: ((context, snapshot) {
            if(ConnectionState.waiting==snapshot.connectionState){
              return Center(child: CircularProgressIndicator());
            }
            DocumentSnapshot mypost = snapshot.data!.docs[0];
            return !snapshot.hasData
            ? CircularProgressIndicator()
            : Column(children: [
                PhotoList(array: mypost["image"]),

                Expanded(
                  child: DetailRow(text1: "agent".tr,text2: mypost["agent"],)
                ),
                Expanded(
                  child: DetailRow(text1: "map".tr,text2: object.firstLetterUp(mypost["map"]),)
                ),
                Expanded(
                  child: DetailRow(text1: "site".tr,text2: mypost["side"],)
                ),
                Expanded(
                  child: DetailRow(text1: "plant".tr, text2: mypost["plant"])
                ),
                Expanded(
                  child: DetailRow(text1: "utility".tr,text2: mypost["utility"].toString().tr,)
                ),
                Expanded(
                  child: DetailRow(text1: "keyboard".tr, text2: mypost["default"])
                ),
                Expanded(
                  child: DetailRow(text1: "jump".tr,text2: mypost["jump"].toString().tr,)
                ),
                mypost["rebound"]>0//IF REBOUND MORE THAN 0 SHOW THIS LINE OR ELSE DONT SHOW
                ? Expanded(child: DetailRow(text1: "rebound".tr,text2: mypost["rebound"].toString().tr))
                : Row(),
                
              ],
            );
          }
      )),
      //FOR BOTTOMBAR AD
      bottomNavigationBar: _isBottomBannerAdLoaded
      ? Container(
      height: _bottomBannerAd.size.height.toDouble(),
      width: _bottomBannerAd.size.width.toDouble(),
      child: AdWidget(ad: _bottomBannerAd),
      )
      : null,
    );
  }
  void _createBottomBannerAd() {
    _bottomBannerAd = BannerAd(
      adUnitId: "ca-app-pub-3940256099942544/6300978111",
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBottomBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    _bottomBannerAd.load();
  }

  Future<void> dataPull()async{
var sp = await SharedPreferences.getInstance();
if((sp.getStringList("list")??null) != null){
  list = sp.getStringList("list")!;
}
if(list.contains(widget.id)){
  check1=true;
}else check1=false;
}
}