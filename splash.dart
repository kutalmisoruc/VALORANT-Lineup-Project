import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:project_a_18/Function/ad_helper.dart';
import 'package:project_a_18/bottomBarScreens/bottomBarHome.dart';
import 'package:project_a_18/colorPalette/color.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class Splash extends StatefulWidget {
  Splash({Key? key}) : super(key: key)
  {
    //FOR AD BUT DEACTİVE NOW
    //_initAd();
  }

  @override
  State<Splash> createState() => _SplashState();
}
late InterstitialAd _interstitialAd;
  bool _isAdLoaded = false;
  //AD FUNC
  void _initAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
      onAdLoaded:  onAdLoaded, 
      onAdFailedToLoad: (error){print("reklam yok");})
      );
  }
//AD LOADION CHECK FUNC
  void onAdLoaded(InterstitialAd ad) {
    _interstitialAd = ad;
    _isAdLoaded = true;
  }
class _SplashState extends State<Splash> {
  late Image image1;
  @override
  void initState() {
    super.initState();
    //splash ıcon assets path
    image1 = Image.asset("lib/assets/snake_v1.png");
    checkFirst();
    
  }
  @override
  void didChangeDependencies() {
    precacheImage(image1.image, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double screenHeight = ekranBilgisi.size.height;
    final double screenWidth = ekranBilgisi.size.width;
    return Container(
      width: screenWidth,
      height: screenHeight,
      color: colorPalette.watermelon,
            child: Column(
              children: [
                Spacer(),
                //ICON
                Padding(
                    padding: const EdgeInsets.all(16),
                    child: Align(alignment: Alignment.center,
                    child: image1),
                  ),
                  //APP NAME
                  AutoSizeText("VALOUTİLİY",style: GoogleFonts.robotoMono(color: colorPalette.mirage,fontSize: 30,fontWeight: FontWeight.bold,textStyle: Theme.of(context).textTheme.bodyLarge),stepGranularity: 1,maxLines: 1,minFontSize: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(color: colorPalette.mirage),
                  ),
                  Spacer(),
                 
              ],
            ),
          );
        
      
  }
   checkFirst()async{
    //1.5 SECONDS WAİT FOR SPLASF
    await Future.delayed(Duration(milliseconds: 1500),() async{
      //INTERNET CONNECTION CHECK
      bool result = await InternetConnectionChecker().hasConnection;
      if(result==true){//has an internet connection
      print("internet var");
      adShow();
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => BottomBarHome()));
      }else{
        print("internet yok");
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => BottomBarHome()));
      }

      
    });
  }
  //AD SHOW FUNC
  void adShow(){
    if(_isAdLoaded){
          _interstitialAd.show();
      }
  }
}