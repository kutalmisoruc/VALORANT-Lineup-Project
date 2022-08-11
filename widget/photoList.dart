// ignore_for_file: unused_local_variable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:project_a_18/colorPalette/color.dart';
import 'package:project_a_18/screens/lineupVideoScreen.dart';
import 'package:project_a_18/screens/photoDetail.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PhotoList extends StatefulWidget {
  List array =[];//PHOTO LINKS LIST
  PhotoList({Key? key,
  required this.array,
  }) : super(key: key);

  @override
  State<PhotoList> createState() => _PhotoListState();
}

class _PhotoListState extends State<PhotoList> {
  
  int activeIndex=0;//WHICH PHOTO INDEKS SHOW FOR PAGE INDICATOR
  
  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double screenHeight = ekranBilgisi.size.height;
    final double screenWidth = ekranBilgisi.size.width;
    return GestureDetector(
      onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => PhotoDetail(url: widget.array[activeIndex],))),
      child: Container(
        decoration:   BoxDecoration(
          border: Border.all(color: colorPalette.cloudburst,
          width: 3.0),
          borderRadius: BorderRadius.all(Radius.circular(3.0))),

          width: screenWidth,
          height: screenWidth*0.5625,
          child: Stack(//TO SHOW ABOVE THE PHOTO TO PAGE INDICATOR
            children: [
              CarouselSlider.builder(//FOR SCROLL PHOTOS
                options: CarouselOptions(
                  onPageChanged:  (index, reason) {//IF PHOTO CHANGES
                    setState(() {
                      activeIndex=index;//CHANGE SHOWING PHOTO INDEX
                    });
                  },
                enableInfiniteScroll: false,//DONT LOOP SCROLL
                viewportFraction: 1,),
    
                itemCount: widget.array.length,//NUMBER OF PHOTOS
                itemBuilder: (context, index, realIndex) {
                  final urlImage=widget.array[index];
                  return buildImage(urlImage, index);
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(alignment: Alignment.bottomCenter,child: buildIndicator()),//BOTTOM CENTER LOOKING GOOD
              ),
              ]
          )
          ),
    );
  }
  Widget buildImage(String urlImage,int index) => Card(
  margin: EdgeInsets.zero,
  shadowColor: colorPalette.watermelon,
  color: colorPalette.blackpearl,
  child: Image.network(urlImage,fit: BoxFit.contain,),
);

  Widget buildIndicator() => AnimatedSmoothIndicator(
  activeIndex: activeIndex,
  count: widget.array.length,
  effect: WormEffect(dotColor: colorPalette.cloudburst,activeDotColor: colorPalette.watermelon),
);
}