import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:project_a_18/Function/firebaseProcess.dart';
import 'package:project_a_18/colorPalette/color.dart';
import 'package:project_a_18/screens/lineupDetailScreen.dart';
import 'package:project_a_18/widget/lineupContainer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteScareen extends StatefulWidget {
  const FavoriteScareen({Key? key}) : super(key: key);

  @override
  State<FavoriteScareen> createState() => _FavoriteScareenState();
}

class _FavoriteScareenState extends State<FavoriteScareen> {
  //{Stream<QuerySnapshot<Object?>>?
  final _inlineAdIndex = 1;
  late BannerAd _inlineBannerAd;
  bool _isInlineBannerAdLoaded = false;
  var list = <String>[];
  late QuerySnapshot query;
  var queryList = <String>[];
  @override
  void initState() {
    super.initState();
    //FAV LİST GET FROM SHAREDPREFERENCES THEN SET STATE
    dataPull().then((value) {
      setState(() {
        
      });
    });
    //LİNEUP COLLECTİON DATA PULL FROM FİRESTORE THEN SEND VALUE FONKS FOR CHECKİNG THE WHİCH ONE İS FAVORİTE
    LineUpFavDataPull().then((value) => fonks(value, list));
    //_createInlineBannerAd();
  }

  @override
  void dispose() {
    super.dispose();
    //_inlineBannerAd.dispose();
  }
  //LİNEUP COLLECTİON DATA PULL FROM FİRESTORE
 Future LineUpFavDataPull() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("Lineup")
        .get();

    // Get data from docs and convert map to List
    allStreams = querySnapshot.docs.map((doc) => doc.data()).toList();
    return allStreams;
  }
  List mypost=[];

  //CHECKING THE WHICH ONE IS FAVORITE
  fonks(List list1,List list) async{
    for(int i=0;i<list1.length;i++){
      for(int x=0;x<list.length;x++){
        if(list1[i]["id"]==list[x]){
        mypost.add(list1[i]);
      }
      }
    }
    setState(() {
    });
  }
 var allStreams;
  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double screenWidth = ekranBilgisi.size.width;
    final double screenHeight = ekranBilgisi.size.height;
    return Scaffold(
      appBar: AppBar(title: Text("favori".tr,style: GoogleFonts.robotoMono(fontWeight: FontWeight.bold)),),

      body: list.length<1//IF DOES NOT HAVE FAVORİTE SHOW WARNİNG (LİST>0 IF THIS IS THIS YOU HAVE FAV)
      ? Container(width: screenWidth,height: screenHeight,color: colorPalette.mirage,child: Center(child: AutoSizeText("no data".tr,style: GoogleFonts.robotoMono(color: Colors.white,fontSize: 24,textStyle: Theme.of(context).textTheme.titleLarge),
              minFontSize: 10,stepGranularity: 1,maxLines: 1,)))
      :  ListView.builder(
              itemCount: mypost.length+(_isInlineBannerAdLoaded ? 1 : 0),//FAV LENGTH + İF AD LOADİNG SUCCES PLUS 1 TO LENGTH
              itemBuilder: (context, index) {
                //PLACEMENT AD TO TRUE INDEX WE WANT
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
                    Navigator.push(context,MaterialPageRoute(builder: (context) => LineupDetailScreen(id: mypost[index]["id"],url: mypost[index]["video"],)));
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
                        //THESE VALUES FOR 16:9 RATİO AND RESPONSİVE DESİGN
                        width: screenWidth*0.5,
                        height: screenWidth*0.28125,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Image.network(mypost[index]["image1"],)),
                      ),
                
                      Expanded(
                        flex: 40,
                        child: Column(
                          children: [
                            LineupContainer(text1: "spike".tr, text2: mypost[index]["plant"]),
                            
                            LineupContainer(text1: "agent".tr, text2: mypost[index]["agent"]),
                            
                            LineupContainer(text1: "utility".tr, text2: mypost[index]["utility"].toString().tr),
      
                            LineupContainer(text1: "map".tr, text2: mypost[index]["map"].toString().replaceFirst(mypost[index]["map"].toString()[0],mypost[index]["map"].toString()[0].toUpperCase())),
                          ],
                        ),
                      ),
                    ],),
                  ),
                );
                }
              },
            ),
      
      
    );
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
  //FAV ID LIST PULL SHAREDPREFERENCES LIST
  Future<void> dataPull()async{
  var sp = await SharedPreferences.getInstance();
  if((sp.getStringList("list")??null) != null){
  list = sp.getStringList("list")!;
  }
  }
}