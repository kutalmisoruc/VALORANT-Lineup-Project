import 'package:flutter/material.dart';
import 'package:project_a_18/colorPalette/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class IconFav extends StatefulWidget {
  
  final String id;
  final bool check1;
  IconFav({Key? key,
  required this.id,
  required this.check1,
  }
  ) : super(key: key);

  @override
  State<IconFav> createState() => _IconFavState();
}
class _IconFavState extends State<IconFav> {
  late SharedPreferences sp;
  
var list =  <String>[];
  @override
  void initState() {
    super.initState();
    dataPull().then((value) {setState(() {//FAV LINEUP DATA PULL THEN SETSTATE
      
    });});
  }
  @override
  Widget build(BuildContext context) {
    bool check;//false is not fav true is fav

    var buttonIcon;
    return  FutureBuilder(
      
      future: null,
      builder: (context, snapshot) {
      if(list.contains(widget.id)==false){//IF THIS LINEUP ID IN LIST THIS LINEUP NOT FAV LINEUP
      check=false;//NOT FAV
      buttonIcon = Icons.star_border_outlined;
      return IconButton(//NOT FAV BUTTON
      icon: Icon(buttonIcon),
      color: Colors.amber,
      onPressed: () {
        setState(() {
          if(check==false){//IF NOT FAV MAKE FAV TO ICON
          Get.snackbar("add fav".tr,"",backgroundColor: colorPalette.midnightblue,
          snackPosition: SnackPosition.BOTTOM,colorText: Colors.white,duration: Duration(milliseconds: 2500),dismissDirection: DismissDirection.vertical,);
          check=true;//MAKE FAV
          buttonIcon=Icons.star;
          dataSave(widget.id);
          dataPull();
          }
          else{//IF FAV MAK NOT FAV TO ICON
          check=false;
          buttonIcon=Icons.star_border_outlined;
          dataDelete(widget.id);
          dataPull();
          }
          
        });
      },
      );
      }
      else{//IF FAV MAKE NOT FAV TO ICON
      check=true;
      buttonIcon = Icons.star;
      return IconButton(
      icon: Icon(buttonIcon),
      color: Colors.amber,
      onPressed: () {
        setState(() {
          if(check==false){//IF NOT FAV MAKE FAV TO ICON
          check=true;
          buttonIcon=Icons.star;
          dataSave(widget.id);
          dataPull();
          }
          else{//IF FAV MAK NOT FAV TO ICON
          check=false;
          buttonIcon=Icons.star_border_outlined;
          dataDelete(widget.id);
          dataPull();
          }
        });
      },
      ); 
      }
      
    },);
  }
  //FAV LINEUP ID DATA PULL
  Future<void> dataPull()async{
  sp = await SharedPreferences.getInstance();
  if((sp.getStringList("list")??null) != null){
    list = sp.getStringList("list")!;
  }
  
  }

  //FAV LINEUP ID DELETE FUNC
  Future<void> dataDelete(String id)async{
  sp = await SharedPreferences.getInstance();
  if((sp.getStringList("list")??null) != null){
    list = (sp.getStringList("list")??null)!;
  }
  if(list.contains(id)==true){//have id id inside of list
    sp.remove("list");
    list.remove(id);
    sp.setStringList("list", list);

  }else print("veri yok");
}
  //SAVE LINEUP ID FOR MADE FAV
  Future<void> dataSave(String id)async{
  sp = await SharedPreferences.getInstance();
  if((sp.getStringList("list")??null) != null){
    list = (sp.getStringList("list")??null)!;
  }
  
  list.add(id);
  sp.setStringList("list", list);
}


}





