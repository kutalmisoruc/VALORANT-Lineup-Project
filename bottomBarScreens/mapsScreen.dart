import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:project_a_18/Function/urlLink.dart';
import 'package:project_a_18/Function/ad_helper.dart';
import 'package:project_a_18/bottomBarScreens/bottomBarHome.dart';
import 'package:project_a_18/colorPalette/color.dart';
import 'package:project_a_18/screens/agentsListScreen.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({ Key? key }) : super(key: key);

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  final _inlineAdIndex = 3;
  late BannerAd _inlineBannerAd;
  bool _isInlineBannerAdLoaded = false;

  @override
  void initState() {
    super.initState();
    //_createInlineBannerAd();
  }
  
  @override
  void dispose() {
    super.dispose();
    //_inlineBannerAd.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double screenWidth = ekranBilgisi.size.width;

    return Scaffold(
      appBar: AppBar(title: Text('maps'.tr,style: GoogleFonts.robotoMono(fontWeight: FontWeight.bold)),),

      body: Url().mapList.isEmpty ? Center(child: AutoSizeText("no data".tr,style: GoogleFonts.robotoMono(color: Colors.white,fontSize: 24,textStyle: Theme.of(context).textTheme.titleLarge),
              minFontSize: 10,stepGranularity: 1,maxLines: 1,))
      :RefreshIndicator(
        onRefresh: () => Navigator.push(context,MaterialPageRoute(builder: (context) => BottomBarHome(),)),
        backgroundColor: colorPalette.watermelon,
        color: colorPalette.midnightblue,
        child: ListView.builder(
        itemCount: Url().mapList.length+(_isInlineBannerAdLoaded ? 1 : 0),
        itemBuilder: (context,index){
      
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
            //CARD CLICK WHICH LINE
            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => AgentsListScreen(map: Url().mapList[_getListViewItemIndex(index)])));
            },
            child: Card(
              margin: EdgeInsets.all(4.0),
              child: Row(children: [
                SizedBox(
                  width: screenWidth*0.5,
                  height: screenWidth*0.28125,
                  child:  FittedBox(
                    fit: BoxFit.fill,
                    child: CachedNetworkImage(imageUrl: Url().mapFotoLink[_getListViewItemIndex(index)],
                    placeholder: (context, url) => AutoSizeText("load".tr,style: GoogleFonts.robotoMono(fontSize: 24),
                minFontSize: 10,stepGranularity: 1,maxLines: 1,),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    )), 
                    
                ),
                Expanded(child: Center(child: AutoSizeText(Url().mapList[_getListViewItemIndex(index)],style: GoogleFonts.robotoMono(fontSize: 24,textStyle: Theme.of(context).textTheme.titleLarge),
                minFontSize: 10,stepGranularity: 1,maxLines: 1,))),
              ]),
            ),
          );
          }
        },
        ),
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
}