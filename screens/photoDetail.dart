import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:project_a_18/colorPalette/color.dart';
import 'package:project_a_18/widget/pinchImage.dart';

class PhotoDetail extends StatefulWidget {
  String url;
  PhotoDetail({Key? key,
  required this.url,
  }) : super(key: key);

  @override
  State<PhotoDetail> createState() => _PhotoDetailState();
}

class _PhotoDetailState extends State<PhotoDetail> {
  late BannerAd _bottomBannerAd;
  bool _isBottomBannerAdLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_createBottomBannerAd();
  }

  @override
  void dispose() {
  super.dispose();
  //_bottomBannerAd.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double screenHeight = ekranBilgisi.size.height;
    final double screenWidth = ekranBilgisi.size.width;
    return Scaffold(
      appBar: AppBar(title: Text("photo".tr+" "+"detail".tr,style:GoogleFonts.robotoMono(fontWeight: FontWeight.bold),),),
      body: PinchImage(url: widget.url,),
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
  
}