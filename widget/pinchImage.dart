import 'package:flutter/material.dart';
import 'package:project_a_18/colorPalette/color.dart';

class PinchImage extends StatefulWidget {
  String url;//PHOTO LINK
  PinchImage({Key? key,
  required this.url,
  }) : super(key: key);

  @override
  State<PinchImage> createState() => _PinchImageState();
}

class _PinchImageState extends State<PinchImage> 
  with SingleTickerProviderStateMixin{
  late TransformationController controller;
  late AnimationController animationController;
  Animation<Matrix4>? animation;

  final double minScale = 1;//MIN PHOTO PINH DISTANCE
  final double maxScale = 4;//MAX PHOTO PINH DISTANCE
  OverlayEntry? entry;

  @override
  void initState() {
    super.initState();

    controller = TransformationController();
    animationController=AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200)
    )..addListener(() =>controller.value=animation!.value)
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed){
      removeOverlay();
      }

     });
  }
  @override
  void dispose() {
    controller.dispose();
    animationController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double screenHeight = ekranBilgisi.size.height;
    final double screenWidth = ekranBilgisi.size.width;
    return buildImage(screenWidth);
  }

   Widget buildImage(double width) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 56),
      child: Align(
        alignment: Alignment.center,
        child: InteractiveViewer(
          transformationController: controller,
          clipBehavior: Clip.none,
          panEnabled: false,
          minScale: minScale,
          maxScale: maxScale,
          onInteractionStart: (details) {
            if(details.pointerCount<2) return;
            print("start");
            showOverlay(context);
          },
          onInteractionEnd: (details) {
            print("end");
            resetAnimation();
          },
          child: Container(
            width: width,
            margin: EdgeInsets.zero,
            color: colorPalette.blackpearl,
            child: Image.network(widget.url,fit: BoxFit.contain,),
          ),
        ),
      ),
    );
  }

  void showOverlay(BuildContext context) {
    final renderBox = context.findRenderObject()! as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = MediaQuery.of(context).size;

    entry= OverlayEntry(
      builder: (context){
        return Positioned(
          left: offset.dx,
          top: offset.dy,
          width: size.width,
          child: buildImage(size.width));
      });
    final overlay = Overlay.of(context)!;
    overlay.insert(entry!);
  }
  
  void removeOverlay() {
    entry?.remove();
    entry=null;
  }

  void resetAnimation() {
    animation = Matrix4Tween(
      begin: controller.value,
      end: Matrix4.identity(),
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.bounceIn)
    );

    animationController.forward(from: 0);
  }
}