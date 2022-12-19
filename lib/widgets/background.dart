import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Color ColorBubble1;
  final Color ColorBubble2;



  const Background({
    Key? key, 
    required this.ColorBubble1, 
    required this.ColorBubble2, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: _Background(),
      child: Stack(
      children: [

        //top bubble
        Positioned(top: -150, left: -150,child: _Bubble(color: ColorBubble1, size: 350)),
        Positioned(top: -250, left: 60,child: _Bubble(color: ColorBubble2, size: 350)),

        // bottom bubble
        Positioned(bottom: -150, right: -150,child: _Bubble(color: ColorBubble1, size: 350,),),
        Positioned(bottom: -250, right: 60,child: _Bubble(color: ColorBubble2, size: 350,),),
        


        // //top bubble
        // Positioned(top: -150, left: -150,child: _Bubble(color:Color.fromARGB(226, 80, 70, 156), size: 350,),),
        // Positioned(top: -250, left: 60,child: _Bubble(color:Color.fromRGBO(90, 70, 178, 1), size: 350,),),

        // // bottom bubble
        // Positioned(bottom: -150, right: -150,child: _Bubble(color:Color.fromARGB(226, 80, 70, 156), size: 350,),),
        // Positioned(bottom: -250, right: 60,child: _Bubble(color:Color.fromRGBO(90, 70, 178, 1), size: 350,),),
        
        // Positioned(bottom: -150, right: -150,child: _Bubble(color:Color.fromARGB(134, 70, 109, 156), size: 350,),),
        // Positioned(bottom: -250, right: 60,child: _Bubble(color:Color.fromARGB(203, 70, 119, 255), size: 350,),),



     ],
    )
     );
  }
}


BoxDecoration _Background () => const BoxDecoration(
  // gradient: LinearGradient(colors: [
  //   Color.fromRGBO(63, 63, 156, 1),
  //   Color.fromRGBO(90, 70, 178, 1),
  // ])
  color: Colors.white24

);



class _Bubble extends StatelessWidget {
  final Color? color;
  final double size;

  const _Bubble({super.key, this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(size),
      color: color ),
    );
  }
}