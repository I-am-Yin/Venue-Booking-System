// ignore_for_file: file_names
import 'package:flutter/material.dart';


class BackgroundImageWidget extends StatelessWidget {
 final Widget child;
 const BackgroundImageWidget({super.key, required this.child});


 @override
 Widget build(BuildContext context) {
   return Container(
     decoration: BoxDecoration(
       image: DecorationImage(
           image: const AssetImage('images/backgroundIMG.gif'),
           fit: BoxFit.cover,
           colorFilter: ColorFilter.mode(
               Colors.black.withOpacity(0.5), BlendMode.darken)),
     ),
     child: child,
   );
 }
}



