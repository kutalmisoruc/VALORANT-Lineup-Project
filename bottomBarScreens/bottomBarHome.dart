import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_a_18/bottomBarScreens/favoriteScreen.dart';
import 'package:project_a_18/bottomBarScreens/mapsScreen.dart';
import 'package:project_a_18/colorPalette/color.dart';

class BottomBarHome extends StatefulWidget {
  const BottomBarHome({ Key? key }) : super(key: key);

  @override
  State<BottomBarHome> createState() => _BottomBarHomeState();
}

class _BottomBarHomeState extends State<BottomBarHome> {
  //OPEN SCREEN INDEX FOR BOTTOMBAR
  int chosenIndex = 0;
  var screenList = [MapsScreen(),FavoriteScareen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //BOTTOMBAR ACTİVE SCREEN SHOW
      body: screenList[chosenIndex],
      
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
          icon: Icon(Icons.map_outlined),
          label: 'maps'.tr,
          ),
          
          BottomNavigationBarItem(
          icon: Icon(Icons.star_outlined),
          label: 'favori'.tr,
          ),
        ],
            
        currentIndex: chosenIndex,
        onTap: (index){
          setState(() {
            chosenIndex=index;
          });
        },
        selectedItemColor: colorPalette.watermelon,
        backgroundColor: colorPalette.blackpearl,
        selectedIconTheme: IconThemeData(color: colorPalette.watermelon,opacity: 1),
        unselectedIconTheme: IconThemeData(color: colorPalette.watermelon,opacity: 0.8),
        showUnselectedLabels: false,
      ),
    );
  }
}